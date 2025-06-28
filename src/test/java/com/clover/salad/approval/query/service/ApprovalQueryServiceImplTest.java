package com.clover.salad.approval.query.service;

import com.clover.salad.approval.query.dto.ApprovalSearchRequestDTO;
import com.clover.salad.approval.query.dto.ApprovalSearchResponseDTO;
import com.clover.salad.approval.query.mapper.ApprovalMapper;
import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.security.token.TokenPrincipal;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ApprovalQueryServiceImplTest {

	@Mock
	private ApprovalMapper approvalMapper;

	@Mock
	private EmployeeQueryService employeeQueryService;

	@InjectMocks
	private ApprovalQueryServiceImpl service;

	@BeforeEach
	void setUp() {
		List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_ADMIN"));
		TokenPrincipal principal = new TokenPrincipal(1, "ADMIN001", authorities);
		UsernamePasswordAuthenticationToken auth =
			new UsernamePasswordAuthenticationToken(principal, null, authorities);
		SecurityContextHolder.getContext().setAuthentication(auth);
	}

	@Test
	void 관리자_권한으로_결재목록_조회() {
		// given
		ApprovalSearchRequestDTO request = new ApprovalSearchRequestDTO();
		ApprovalSearchResponseDTO response = new ApprovalSearchResponseDTO(
			1, "A-2506-0001", "테스트", "내용", null, null,
			"요청", "비고", "홍길동", "이순신", "C-2506-0001"
		);

		when(approvalMapper.searchApprovals(request)).thenReturn(List.of(response));

		// when
		List<ApprovalSearchResponseDTO> result = service.searchApprovals(request);

		// then
		assertEquals(1, result.size());
		assertEquals("A-2506-0001", result.get(0).getCode());
	}
}
