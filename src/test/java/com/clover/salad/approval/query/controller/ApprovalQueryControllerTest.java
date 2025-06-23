package com.clover.salad.approval.query.controller;

import static org.assertj.core.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.clover.salad.SaladApplication;
import com.clover.salad.approval.command.domain.aggregate.entity.ApprovalEntity;
import com.clover.salad.approval.query.dto.ApprovalSearchRequestDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest(classes = SaladApplication.class)
@AutoConfigureMockMvc
@Transactional
public class ApprovalQueryControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Test
	void 결재_내역_조회_성공() throws Exception {

		// given
		ApprovalSearchRequestDTO approvalSearchRequestDTO = new ApprovalSearchRequestDTO();
		approvalSearchRequestDTO.setTitle("계약");

		// when
		String response = mockMvc.perform(post("/approval/search")
			.contentType(MediaType.APPLICATION_JSON)
			.content(objectMapper.writeValueAsString(approvalSearchRequestDTO)))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		// then
		assertThat(response).contains("title");
	}

	@Test
	void 결재_상세_조회_성공() throws Exception {

		// given
		int approvalId = 1;

		// when


		// then

	}
}
