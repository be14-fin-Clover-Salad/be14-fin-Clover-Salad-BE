package com.clover.salad.approval.query.controller;

import com.clover.salad.approval.query.dto.ApprovalDetailDTO;
import com.clover.salad.approval.query.dto.ApprovalSearchRequestDTO;
import com.clover.salad.approval.query.dto.ApprovalSearchResponseDTO;
import com.clover.salad.approval.query.service.ApprovalQueryService;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDateTime;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(
	controllers = ApprovalQueryController.class,
	excludeFilters = {
		@ComponentScan.Filter(type = FilterType.ASSIGNABLE_TYPE, classes = com.clover.salad.security.JwtFilter.class),
		@ComponentScan.Filter(type = FilterType.ASSIGNABLE_TYPE, classes = com.clover.salad.security.WebSecurity.class)
	}
)
@TestPropertySource(properties = {
	"spring.autoconfigure.exclude=org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration,org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration"
})
class ApprovalQueryControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@MockitoBean
	private ApprovalQueryService approvalQueryService;

	@Test
	void 결재_목록_조회() throws Exception {

		// given
		ApprovalSearchRequestDTO requestDTO = new ApprovalSearchRequestDTO();
		requestDTO.setTitle("출장");

		ApprovalSearchResponseDTO responseDTO = new ApprovalSearchResponseDTO(
			1, "A-2506-0001", "출장 요청", "제주도 출장", LocalDateTime.now(), null,
			"요청", null, "홍길동", "김팀장", "C-2024-0001"
		);
		when(approvalQueryService.searchApprovals(any()))
			.thenReturn(List.of(responseDTO));

		// when // then
		mockMvc.perform(post("/approval/search")
				.contentType("application/json")
				.content(objectMapper.writeValueAsString(requestDTO)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$[0].title").value("출장 요청"))
			.andExpect(jsonPath("$[0].code").value("A-2506-0001"));
	}

	@Test
	void 결재_상세_조회() throws Exception {

		// given
		int approvalId = 1;
		ApprovalDetailDTO detailDTO = new ApprovalDetailDTO();
		detailDTO.setId(approvalId);
		detailDTO.setCode("A-2506-0001");
		detailDTO.setTitle("출장 요청");
		detailDTO.setContent("제주도 출장");
		detailDTO.setState("요청");
		detailDTO.setReqName("홍길동");
		detailDTO.setAprvName("김팀장");
		detailDTO.setContractCode("C-2024-0001");
		when(approvalQueryService.getApprovalDetailById(approvalId)).thenReturn(detailDTO);

		// when // then
		mockMvc.perform(get("/approval/{id}", approvalId))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.title").value("출장 요청"))
			.andExpect(jsonPath("$.code").value("A-2506-0001"))
			.andExpect(jsonPath("$.reqName").value("홍길동"));
	}
}
