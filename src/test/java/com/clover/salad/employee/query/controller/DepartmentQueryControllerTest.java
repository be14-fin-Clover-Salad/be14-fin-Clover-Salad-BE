package com.clover.salad.employee.query.controller;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
public class DepartmentQueryControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Test
	void 부서_계층_조회_성공() throws Exception {
		// when
		mockMvc.perform(get("/department/hierarchy"))
			// then
			.andExpect(status().isOk())
			.andExpect(jsonPath("$").isArray())
			.andExpect(jsonPath("$[0].id").isNotEmpty());
	}

	@Test
	void 부서별_사원_전체_조회_성공() throws Exception {
		// given
		int departmentId = 1;

		// when
		mockMvc.perform(get("/department/employee")
				.param("departmentId", String.valueOf(departmentId)))
			// then
			.andExpect(status().isOk())
			.andExpect(jsonPath("$").isArray())
			.andExpect(jsonPath("$[0].departmentName").isNotEmpty());
	}
}
