package com.clover.salad.notification.query.sse;

import static org.assertj.core.api.Assertions.*;

import java.io.IOException;

import org.junit.jupiter.api.Test;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

class SseEmitterManagerTest {

	@Test
	public void 연결_성공_시_이벤트_전송() throws IOException {

		// given
		SseEmitterManager sseEmitterManager = new SseEmitterManager();

		// when
		SseEmitter sseEmitter = sseEmitterManager.connect(1);

		// then
		assertThat(sseEmitter).isNotNull();
	}

	@Test
	public void 연결된_사용자에게_알림_전송() throws Exception {

		// given
		SseEmitterManager sseEmitterManager = new SseEmitterManager();
		SseEmitter sseEmitter = sseEmitterManager.connect(123);

		// when
		sseEmitterManager.send(123, "새로운 알림입니다.");

		// then
		assertThat(sseEmitter).isNotNull();

	}

	@Test
	public void 연결되지_않은_사용자의_알림을_버퍼에_보관() throws Exception {

		// given
		SseEmitterManager sseEmitterManager = new SseEmitterManager();

		// when
		sseEmitterManager.send(234, "보관용 알림.");

		// then
		assertThatCode(() -> sseEmitterManager.send(235, "다른 알림.")).doesNotThrowAnyException();
	}
}
