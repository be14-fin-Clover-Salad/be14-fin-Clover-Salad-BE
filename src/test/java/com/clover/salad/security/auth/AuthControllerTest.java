package com.clover.salad.security.auth;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.clover.salad.common.exception.AuthException;
import com.clover.salad.security.EmployeeDetails;
import com.clover.salad.security.JwtUtil;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.ResponseEntity;

import java.util.List;

@ExtendWith(MockitoExtension.class)
class AuthControllerTest {

	@Mock
	private JwtUtil jwtUtil;

	@Mock
	private RedisTemplate<String, String> redisTemplate;

	@Mock
	private AuthService authService;

	@Mock
	private HttpServletRequest request;

	@Mock
	private HttpServletResponse response;

	@Mock
	private ValueOperations<String, String> valueOperations;

	@InjectMocks
	private AuthController controller;

	@Test
	public void 리프레시_토큰_재발급_성공() {
		// given
		String refreshToken = "refresh-token";
		Cookie cookie = new Cookie("refreshToken", refreshToken);
		when(request.getCookies()).thenReturn(new Cookie[]{cookie});
		when(jwtUtil.validateToken(refreshToken)).thenReturn(true);
		when(jwtUtil.getEmployeeId(refreshToken)).thenReturn(1);

		// Redis 관련 mock 설정
		when(redisTemplate.opsForValue()).thenReturn(valueOperations);
		when(valueOperations.get("refresh:1")).thenReturn(refreshToken);

		EmployeeDetails details = new EmployeeDetails(1, "202501010", "pw",
			List.of(() -> "ROLE_MEMBER"));
		when(authService.loadUserById(1)).thenReturn(details);
		when(jwtUtil.createAccessToken(eq(1), eq("202501010"), any()))
			.thenReturn("new-access-token");

		// when
		ResponseEntity<String> result = controller.refreshAccessToken(request, response);

		// then
		assertThat(result.getBody()).isEqualTo("AccessToken 재발급 완료");
		assertThat(result.getStatusCodeValue()).isEqualTo(200);
		verify(response).setHeader("Authorization", "Bearer new-access-token");
	}

	@Test
	public void 리프레시_토큰_없으면_예외() {
		// given
		when(request.getCookies()).thenReturn(null);

		// when // then
		assertThatThrownBy(() -> controller.refreshAccessToken(request, response))
			.isInstanceOf(AuthException.class)
			.hasMessageContaining("RefreshToken 누락");
	}

	@Test
	public void 로그아웃_성공() {
		// given
		String token = "Bearer valid-access-token";
		String pureToken = "valid-access-token";
		int employeeId = 1;

		when(jwtUtil.validateToken(pureToken)).thenReturn(true);
		when(jwtUtil.getEmployeeId(pureToken)).thenReturn(employeeId);
		when(jwtUtil.getExpiration(pureToken)).thenReturn(LocalDateTime.now().plusMinutes(10));
		when(redisTemplate.opsForValue()).thenReturn(valueOperations);

		// when
		ResponseEntity<String> result = controller.logout(token, response);

		// then
		assertThat(result.getStatusCodeValue()).isEqualTo(200);
		assertThat(result.getBody()).isEqualTo("로그아웃이 완료되었습니다.");
		verify(valueOperations).set(startsWith("blacklist:"), eq("logout"), any(Duration.class));
		verify(redisTemplate).delete("refresh:" + employeeId);
		verify(response).addCookie(argThat(cookie ->
			"refreshToken".equals(cookie.getName()) &&
				cookie.getMaxAge() == 0 &&
				cookie.isHttpOnly() &&
				cookie.getSecure()
		));
	}
}
