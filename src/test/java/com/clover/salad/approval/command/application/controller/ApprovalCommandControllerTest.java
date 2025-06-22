package com.clover.salad.approval.command.application.controller;

import com.clover.salad.approval.command.application.dto.ApprovalDecisionDTO;
import com.clover.salad.approval.command.application.dto.ApprovalRequestDTO;
import com.clover.salad.security.SecurityUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.MockedStatic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.Transactional;

import static org.mockito.Mockito.mockStatic;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(ApprovalCommandController.class)
public class ApprovalCommandControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Transactional
	@Test
	void 결재_요청_성공() throws Exception {

		// given
		int employeeId = 1;
		ApprovalRequestDTO approvalRequestDTO = new ApprovalRequestDTO();
		approvalRequestDTO.setTitle("결재 요청 테스트");
		approvalRequestDTO.setContent("테스트 내용");
		approvalRequestDTO.setContractId(1000);

		// when
		try (MockedStatic<SecurityUtil> mockedStatic = mockStatic(SecurityUtil.class)) {
			mockedStatic.when(SecurityUtil::getEmployeeId).thenReturn(employeeId);
			mockedStatic.when(() -> SecurityUtil.hasRole("ROLE_MANAGER")).thenReturn(false);
			mockedStatic.when(() -> SecurityUtil.hasRole("ROLE_MEMBER")).thenReturn(true);

			mockMvc.perform(post("/approval/request").contentType(MediaType.APPLICATION_JSON)
					.content(objectMapper.writeValueAsString(approvalRequestDTO)))

				// then
				.andExpect(status().isOk())
				.andExpect(content().string(org.hamcrest.Matchers.containsString("결재 요청이 정상적으로 처리되었습니다.")));
		}
	}

	@Transactional
	@Test
	void 결재_처리_성공() throws Exception {

		// given
		int employeeId = 5;
		ApprovalDecisionDTO approvalDecisionDTO = new ApprovalDecisionDTO();
		approvalDecisionDTO.setApprovalId(1);
		approvalDecisionDTO.setDecision("승인");
		approvalDecisionDTO.setComment("승인합니다.");

		// when
		try (MockedStatic<SecurityUtil> mockedStatic = mockStatic(SecurityUtil.class)) {
			mockedStatic.when(SecurityUtil::getEmployeeId).thenReturn(employeeId);
			mockedStatic.when(() -> SecurityUtil.hasRole("ROLE_MANAGER")).thenReturn(true);

			mockMvc.perform(post("/approval/decision").contentType(MediaType.APPLICATION_JSON)
					.content(objectMapper.writeValueAsString(approvalDecisionDTO)))

				// then
				.andExpect(status().isOk()).andExpect(content().string("결재 처리가 완료되었습니다."));
		}
	}
}
