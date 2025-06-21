package com.clover.salad.security.auth;

import com.clover.salad.security.EmployeeDetails;
import com.clover.salad.security.JwtUtil;
import com.clover.salad.security.WebSecurity;

import io.jsonwebtoken.Claims;
import jakarta.servlet.http.Cookie;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDateTime;
import java.util.List;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
public class AuthControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@MockitoBean
	private JwtUtil jwtUtil;

	@MockitoBean
	private RedisTemplate<String, String> redisTemplate;

	@MockitoBean
	private AuthService authService;

	private ValueOperations<String, String> valueOperations;

	@BeforeEach
	void setUp() {
		valueOperations = mock(ValueOperations.class);
		when(redisTemplate.opsForValue()).thenReturn(valueOperations);
		when(valueOperations.get(startsWith("blacklist:"))).thenReturn(null);

		Claims mockClaims = mock(Claims.class);
		when(mockClaims.getSubject()).thenReturn("202501001");
		when(jwtUtil.getClaims("test-access-token")).thenReturn(mockClaims);
	}

	@Test
	void 로그아웃_성공_시_리프레시_토큰_삭제_및_블랙리스트_등록() throws Exception {
		String token = "Bearer test-access-token";

		when(jwtUtil.validateToken("test-access-token")).thenReturn(true);
		when(jwtUtil.getEmployeeId("test-access-token")).thenReturn(1);
		when(jwtUtil.getExpiration("test-access-token")).thenReturn(LocalDateTime.now().plusMinutes(30));

		mockMvc.perform(post("/auth/logout")
			.header("Authorization", token))
			.andExpect(status().isOk())
			.andExpect(content().string("로그아웃이 완료되었습니다."));

		verify(redisTemplate).delete("refresh:1");
	}

	@Test
	void 리프레시_토큰으로_액세스_토큰_재발급() throws Exception {
		String refreshToken = "refresh-token";
		Cookie refreshCookie = new Cookie("refreshToken", refreshToken);

		ValueOperations<String, String> valueOperations = mock(ValueOperations.class);
		when(redisTemplate.opsForValue()).thenReturn(valueOperations);
		when(valueOperations.get("refresh:1")).thenReturn(refreshToken);

		when(jwtUtil.validateToken(refreshToken)).thenReturn(true);
		when(jwtUtil.getEmployeeId(refreshToken)).thenReturn(1);

		EmployeeDetails employeeDetails = new EmployeeDetails(
			1, "202501001", "test", List.of(new SimpleGrantedAuthority("ROLE_MEMBER"))
		);

		when(authService.loadUserById(1)).thenReturn(employeeDetails);
		when(jwtUtil.createAccessToken(eq(1), eq("202501001"), any()))
			.thenReturn("new-access-token");

		mockMvc.perform(post("/auth/refresh-token")
			.cookie(refreshCookie))
			.andExpect(status().isOk())
			.andExpect(header().string("Authorization", "Bearer new-access-token"))
			.andExpect(content().string("AccessToken 재발급 완료"));
	}
}
