package com.clover.salad.notification.command.application.service;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.Duration;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

@ExtendWith(MockitoExtension.class)
class NotificationTokenServiceImplTest {

	@Mock
	private RedisTemplate<String, String> redisTemplate;

	@Mock
	private ValueOperations<String, String> valueOperations;

	@InjectMocks
	private NotificationTokenServiceImpl notificationTokenServiceImpl;

	@Test
	public void 토큰_발급_후_레디스_저장() {

		// given
		int employeeId = 123;
		when(redisTemplate.opsForValue()).thenReturn(valueOperations);

		// when
		String token = notificationTokenServiceImpl.issueToken(employeeId);

		// then
		verify(valueOperations).set(startsWith("sse:"), eq("123"), eq(Duration.ofMinutes(5)));
	}

	@Test
	public void 토큰으로_사원id_복원_후_삭제() {

		// given
		String token = "sample-token";
		when(redisTemplate.opsForValue()).thenReturn(valueOperations);
		when(redisTemplate.opsForValue().get("sse:" + token)).thenReturn("123");

		// when
		Integer employeeId = notificationTokenServiceImpl.resolveEmployeeId(token);

		// then
		assertThat(employeeId).isEqualTo(123);
		verify(redisTemplate, times(1)).delete("sse:" + token);
	}

	@Test
	public void 존재하지_않는_토큰_null_반환() {

		// given
		String token = "non_exist";
		when(redisTemplate.opsForValue()).thenReturn(valueOperations);
		when(valueOperations.get("sse:" + token)).thenReturn(null);

		// when
		Integer employeeId = notificationTokenServiceImpl.resolveEmployeeId(token);

		// then
		assertThat(employeeId).isNull();
		verify(redisTemplate, never()).delete(anyString());
	}
}
