package com.clover.salad.security.auth;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.clover.salad.SaladApplication;
import com.clover.salad.employee.command.domain.aggregate.vo.RequestLoginVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;


@SpringBootTest(classes = SaladApplication.class)
@AutoConfigureMockMvc
public class AuthLoginIntegrationTest {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Test
	void 로그인_성공_시_액세스토큰_및_유저정보_반환() throws Exception {
		RequestLoginVO loginVO = new RequestLoginVO("ADMIN", "admin");

		mockMvc.perform(post("/auth/login")
			.contentType(MediaType.APPLICATION_JSON)
			.content(objectMapper.writeValueAsString(loginVO)))
			.andExpect(status().isOk())
			.andExpect(header().exists("Authorization"))
			.andExpect(cookie().exists("refreshToken"))
			.andExpect(jsonPath("$.name").exists())
			.andExpect(jsonPath("$.departmentName").exists());
	}
}
