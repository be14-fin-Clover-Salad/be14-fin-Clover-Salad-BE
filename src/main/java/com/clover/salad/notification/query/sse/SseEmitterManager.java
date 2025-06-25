package com.clover.salad.notification.query.sse;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class SseEmitterManager {
	private final Map<Integer, SseEmitter> emitters = new ConcurrentHashMap<>();
	private final Map<Integer, List<Object>> pending = new ConcurrentHashMap<>();

	private final ScheduledExecutorService heartbeatScheduler = Executors.newScheduledThreadPool(1);
	private final Map<Integer, ScheduledFuture<?>> heartbeatTasks = new ConcurrentHashMap<>();

	public SseEmitter connect(int employeeId) {
		log.info("[SSE] Emitter 등록 시작 - employeeId: {}", employeeId);

		SseEmitter existing = emitters.remove(employeeId);
		if (existing != null) {
			existing.complete();
			log.info("[SSE] 기존 emitter 종료 - employeeId: {}", employeeId);
		}

		SseEmitter emitter = new SseEmitter(60 * 60 * 1000L);
		emitters.put(employeeId, emitter);

		// 타임아웃/완료/에러 시 제거
		Runnable cleanup = () -> {
			emitters.remove(employeeId);
			ScheduledFuture<?> task = heartbeatTasks.remove(employeeId);
			if (task != null) task.cancel(true);
			log.info("[SSE] 연결 종료 또는 오류 - employeeId: {}", employeeId);
		};
		emitter.onCompletion(cleanup);
		emitter.onTimeout(cleanup);
		emitter.onError(e -> {
			log.error("[SSE] 에러 발생 - employeeId: {}, 이유: {}", employeeId, e.getMessage());
			cleanup.run();
		});

		try {
			emitter.send(SseEmitter.event().name("heartbeat").data("connected"));
		} catch (IOException e) {
			cleanup.run();
			throw new RuntimeException("SSE 연결 실패");
		}

		// 정기 heartbeat 전송 시작
		ScheduledFuture<?> heartbeat = heartbeatScheduler.scheduleAtFixedRate(() -> {
			try {
				emitter.send(SseEmitter.event().name("heartbeat").data("keep-alive"));
				log.debug("[SSE] heartbeat 전송 - employeeId: {}", employeeId);
			} catch (IOException e) {
				log.warn("[SSE] heartbeat 전송 실패 - employeeId: {}", employeeId);
				cleanup.run();
			}
		}, 30, 30, TimeUnit.SECONDS);

		heartbeatTasks.put(employeeId, heartbeat);

		// 보관된 알림 전송
		List<Object> buffered = pending.remove(employeeId);
		if (buffered != null) {
			for (Object data : buffered) {
				try {
					emitter.send(SseEmitter.event().name("notification").data(data));
				} catch (IOException e) {
					log.error("[SSE] 보관된 알림 전송 실패 - {}", e.getMessage());
				}
			}
		}

		return emitter;
	}

	public void send(int employeeId, Object data) {
		SseEmitter emitter = emitters.get(employeeId);
		log.info("[SSE] 알림 전송 시도 - employeeId: {}, emitter 존재 여부: {}", employeeId, emitter != null);

		if (emitter != null) {
			try {
				emitter.send(SseEmitter.event().name("notification").data(data));
				log.info("[SSE] 알림 전송 성공 - employeeId: {}", employeeId);
			} catch (IOException e) {
				emitters.remove(employeeId);
				ScheduledFuture<?> task = heartbeatTasks.remove(employeeId);
				if (task != null) task.cancel(true);
				log.error("[SSE] 알림 전송 실패 - employeeId: {}, 이유: {}", employeeId, e.getMessage());
			}
		} else {
			List<Object> buffer = pending.computeIfAbsent(employeeId, k -> new CopyOnWriteArrayList<>());
			if (buffer.size() < 100) {
				buffer.add(data);
			}
		}
	}
}
