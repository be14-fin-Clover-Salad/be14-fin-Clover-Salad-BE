package com.clover.salad.approval.query.service;

import com.clover.salad.approval.query.dto.ApprovalDetailDTO;
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

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

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

	@Test
	void 팀장_권한으로_결재목록_조회() {

		// given
		List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_MANAGER"));
		TokenPrincipal principal = new TokenPrincipal(20, "202501020", authorities);
		UsernamePasswordAuthenticationToken auth =
			new UsernamePasswordAuthenticationToken(principal, null, authorities);
		SecurityContextHolder.getContext().setAuthentication(auth);

		ApprovalSearchRequestDTO request = new ApprovalSearchRequestDTO();
		when(employeeQueryService.findNameById(20)).thenReturn("이순신");

		ApprovalSearchResponseDTO response = new ApprovalSearchResponseDTO(
			1, "A-2506-0002", "결재 제목", "결재 내용", null, null,
			"요청", "비고", "홍길동", "이순신", "C-2506-0002"
		);
		when(approvalMapper.searchByApprover(any())).thenReturn(List.of(response));

		// when
		List<ApprovalSearchResponseDTO> result = service.searchApprovals(request);

		// then
		assertEquals(1, result.size());
		assertEquals("A-2506-0002", result.get(0).getCode());
		verify(employeeQueryService).findNameById(20);
		verify(approvalMapper).searchByApprover(request);
	}

	@Test
	void 사원_권한으로_결재목록_조회() {

		// given
		List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_MEMBER"));
		TokenPrincipal principal = new TokenPrincipal(30, "202501030", authorities);
		UsernamePasswordAuthenticationToken auth =
			new UsernamePasswordAuthenticationToken(principal, null, authorities);
		SecurityContextHolder.getContext().setAuthentication(auth);

		ApprovalSearchRequestDTO request = new ApprovalSearchRequestDTO();
		when(employeeQueryService.findNameById(30)).thenReturn("홍길동");

		ApprovalSearchResponseDTO response = new ApprovalSearchResponseDTO(
			1, "A-2506-0003", "결재 제목", "결재 내용", null, null,
			"요청", "비고", "홍길동", "이순신", "C-2506-0003"
		);
		when(approvalMapper.searchByRequester(any())).thenReturn(List.of(response));

		// when
		List<ApprovalSearchResponseDTO> result = service.searchApprovals(request);

		// then
		assertEquals(1, result.size());
		assertEquals("A-2506-0003", result.get(0).getCode());
		verify(employeeQueryService).findNameById(30);
		verify(approvalMapper).searchByRequester(request);
	}

	@Test
	void 권한_없음_예외_발생() {

		// given
		int currentEmployeeID = 99;
		int otherRequestId = 98;

		List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_MEMBER"));
		TokenPrincipal principal = new TokenPrincipal(currentEmployeeID, "202501099", authorities);
		UsernamePasswordAuthenticationToken auth =
			new UsernamePasswordAuthenticationToken(principal, null, authorities);
		SecurityContextHolder.getContext().setAuthentication(auth);

		int approvalId = 1;
		ApprovalDetailDTO dto = new ApprovalDetailDTO();
		dto.setId(approvalId);
		dto.setReqId(otherRequestId);
		dto.setAprvId(10);

		when(approvalMapper.findApprovalDetailById(approvalId)).thenReturn(dto);

		// when // then
		assertThrows(AccessDeniedException.class, () -> service.getApprovalDetailById(approvalId));
	}
}
