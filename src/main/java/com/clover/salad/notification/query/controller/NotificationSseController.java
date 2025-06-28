package com.clover.salad.notification.query.controller;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.clover.salad.notification.command.application.service.NotificationTokenService;
import com.clover.salad.notification.query.sse.SseEmitterManager;

import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/notification")
public class NotificationSseController {

	private final SseEmitterManager sseEmitterManager;
	private final NotificationTokenService notificationTokenService;

	public NotificationSseController(
		SseEmitterManager sseEmitterManager,
		NotificationTokenService notificationTokenService
	) {
		this.sseEmitterManager = sseEmitterManager;
		this.notificationTokenService = notificationTokenService;
	}

	@GetMapping(value = "/subscribe", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public SseEmitter subscribe(@RequestParam("token") String token, HttpServletResponse response) {
		log.info("[SSE] 구독 요청 수신 - token: {}", token);

		response.setContentType("text/event-stream");

		Integer employeeId = notificationTokenService.resolveEmployeeId(token);
		if (employeeId == null) {
			log.warn("[SSE] 유효하지 않은 구독 토큰: {}", token);

			SseEmitter dummy = new SseEmitter(0L);
			try {
				dummy.send(SseEmitter.event().name("error").data("Invalid token"));
				dummy.complete();
			} catch (IOException ignored) {}
			return dummy;
		}

		log.info("[SSE] 구독 인증 완료 - employeeId: {}", employeeId);

		SseEmitter emitter = sseEmitterManager.connect(employeeId);

		try {
			response.flushBuffer();
		} catch (IOException e) {
			log.error("[SSE] flushBuffer 실패 - employeeId: {}, 이유: {}", employeeId, e.getMessage());
		}

		return emitter;
	}
}
