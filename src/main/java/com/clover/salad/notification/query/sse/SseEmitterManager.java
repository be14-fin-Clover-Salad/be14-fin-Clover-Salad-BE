package com.clover.salad.notification.query.sse;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class SseEmitterManager {
	private final Map<Integer, SseEmitter> emitters = new ConcurrentHashMap<>();
	private final Map<Integer, List<Object>> pending = new ConcurrentHashMap<>();

	public SseEmitter connect(int employeeId) {
		log.info("[SSE] Emitter 등록 시작 - employeeId: {}", employeeId);

		SseEmitter existing = emitters.remove(employeeId);
		if (existing != null) {
			existing.complete(); // 안전 종료
			log.info("[SSE] 기존 emitter 종료 - employeeId: {}", employeeId);
		}

		SseEmitter emitter = new SseEmitter(60 * 60 * 1000L); // 1시간 타임아웃
		emitters.put(employeeId, emitter);

		emitter.onCompletion(() -> {
			emitters.remove(employeeId);
			emitter.complete();
			log.info("[SSE] 연결 종료 - employeeId: {}", employeeId);
		});
		emitter.onTimeout(() -> {
			emitters.remove(employeeId);
			emitter.complete();
			log.warn("[SSE] 타임아웃 발생 - employeeId: {}", employeeId);
		});
		emitter.onError(e -> {
			emitters.remove(employeeId);
			emitter.completeWithError(e);
			log.error("[SSE] 에러 발생 - employeeId: {}, 오류: {}", employeeId, e.getMessage());
		});

		try {
			emitter.send(SseEmitter.event().name("heartbeat").data("connected"));
		} catch (IOException e) {
			emitter.completeWithError(e);
			emitters.remove(employeeId);
			log.error("[SSE] 더미 이벤트 전송 실패 - employeeId: {}, 이유: {}", employeeId, e.getMessage());
			throw new RuntimeException("SSE 연결 실패");
		}

		// 보관된 알림 전송 시도
		List<Object> buffered = pending.remove(employeeId);
		if (buffered != null && !buffered.isEmpty()) {
			for (Object data : buffered) {
				try {
					emitter.send(SseEmitter.event().name("notification").data(data));
					log.info("[SSE] 보관된 알림 전송 - employeeId: {}", employeeId);
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
				emitter.completeWithError(e);
				emitters.remove(employeeId);
				log.error("[SSE] 알림 전송 실패 - employeeId: {}, 이유: {}", employeeId, e.getMessage());
			}
		} else {
			log.warn("[SSE] emitter 없음 → 알림 보관 - employeeId: {}", employeeId);
			List<Object> buffer = pending.computeIfAbsent(employeeId, k -> new CopyOnWriteArrayList<>());
			if (buffer.size() < 100) {
				buffer.add(data);
			} else {
				log.warn("[SSE] 보관 버퍼 초과 - employeeId: {}", employeeId);
			}
		}
	}
}
