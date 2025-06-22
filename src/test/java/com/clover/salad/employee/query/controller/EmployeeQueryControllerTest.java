package com.clover.salad.employee.query.controller;

import com.clover.salad.employee.query.dto.EmployeeSearchRequestDTO;
import com.clover.salad.security.SecurityUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;

import static org.mockito.Mockito.mockStatic;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
public class EmployeeQueryControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Test
	void 사원_검색_성공() throws Exception {
		// given
		EmployeeSearchRequestDTO dto = new EmployeeSearchRequestDTO();
		dto.setName("강수지");

		// when
		mockMvc.perform(post("/employee/search")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(dto)))
			// then
			.andExpect(status().isOk())
			.andExpect(jsonPath("$[0].name").value("강수지"));
	}

	@Test
	void 사원_상세_조회_성공() throws Exception {
		// given
		int employeeId = 1;

		// when
		mockMvc.perform(get("/employee/detail")
				.param("employeeId", String.valueOf(employeeId)))
			// then
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.id").value(employeeId));
	}

	@Test
	void 로그인_헤더_정보_조회_성공() throws Exception {
		// given
		int employeeId = 1;

		// when
		try (MockedStatic<SecurityUtil> mockedStatic = mockStatic(SecurityUtil.class)) {
			mockedStatic.when(SecurityUtil::getEmployeeId).thenReturn(employeeId);

			mockMvc.perform(get("/employee/header"))
				// then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.id").value(employeeId));
		}
	}

	@Test
	void 마이페이지_정보_조회_성공() throws Exception {
		// given
		int employeeId = 1;

		// when
		try (MockedStatic<SecurityUtil> mockedStatic = mockStatic(SecurityUtil.class)) {
			mockedStatic.when(SecurityUtil::getEmployeeId).thenReturn(employeeId);

			mockMvc.perform(get("/employee/mypage"))
				// then
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.code").isNotEmpty());
		}
	}
}
