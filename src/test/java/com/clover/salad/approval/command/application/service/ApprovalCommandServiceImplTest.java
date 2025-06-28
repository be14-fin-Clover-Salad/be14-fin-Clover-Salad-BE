package com.clover.salad.approval.command.application.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import com.clover.salad.approval.command.application.dto.ApprovalDecisionDTO;
import com.clover.salad.approval.command.application.dto.ApprovalRequestDTO;
import com.clover.salad.approval.command.domain.aggregate.entity.ApprovalEntity;
import com.clover.salad.approval.command.domain.aggregate.enums.ApprovalState;
import com.clover.salad.approval.command.domain.repository.ApprovalRepository;
import com.clover.salad.approval.query.mapper.ApprovalMapper;
import com.clover.salad.contract.command.entity.ContractEntity;
import com.clover.salad.contract.command.repository.ContractRepository;
import com.clover.salad.employee.query.mapper.EmployeeMapper;
import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.notification.command.application.service.NotificationCommandService;
import com.clover.salad.performance.command.application.service.PerformanceCommandService;
import com.clover.salad.security.SecurityUtil;
import com.clover.salad.security.token.TokenPrincipal;

@ExtendWith(MockitoExtension.class)
class ApprovalCommandServiceImplTest {

	@Mock
	private ApprovalRepository approvalRepository;

	@Mock
	private EmployeeMapper employeeMapper;

	@Mock
	private ApprovalMapper approvalMapper;

	@Mock
	private NotificationCommandService notificationCommandService;

	@Mock
	private ContractRepository contractRepository;

	@Mock
	private EmployeeQueryService employeeQueryService;

	@Mock
	private PerformanceCommandService performanceCommandService;

	@InjectMocks
	private ApprovalCommandServiceImpl approvalCommandService;

	@BeforeEach
	void setUp() {
		List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_MEMBER"));

		// TokenPrincipal 생성
		TokenPrincipal principal = new TokenPrincipal(10, "202501009", authorities);

		UsernamePasswordAuthenticationToken auth =
			new UsernamePasswordAuthenticationToken(principal, null, authorities);

		SecurityContextHolder.getContext().setAuthentication(auth);
	}

	@Test
	void 결재_요청_생성() {

		// given
		int contractId = 1;
		int requesterId = 10;
		int managerId = 20;

		ApprovalRequestDTO dto = new ApprovalRequestDTO();
		dto.setTitle("테스트");
		dto.setContent("내용");
		dto.setContractId(contractId);

		ContractEntity contract = new ContractEntity();
		when(contractRepository.findById(contractId)).thenReturn(Optional.of(contract));

		when(employeeMapper.findDepartmentIdByEmployeeId(requesterId)).thenReturn(1);
		when(employeeMapper.findManagerIdByDeptId(1)).thenReturn(managerId);
		when(employeeMapper.findNameById(requesterId)).thenReturn("홍길동");

		when(approvalMapper.countExistingApprovalRequest(any())).thenReturn(0);
		when(approvalMapper.findLastCodeByPrefix(any())).thenReturn(null);
		when(approvalMapper.countByCode(any())).thenReturn(0);

		ApprovalEntity mockSaved = ApprovalEntity.builder().id(123).build();
		when(approvalRepository.save(any())).thenReturn(mockSaved);

		// when
		int approvalId = approvalCommandService.requestApproval(dto);

		// then
		assertEquals(123, approvalId);
		verify(notificationCommandService).createNotification(any());
	}

	@Test
	public void 결재처리_승인_성공() {

		// given
		int approvalId = 20;
		int requesterId = 10;
		int managerId = 11;
		int contractId = 1;

		ApprovalDecisionDTO dto = new ApprovalDecisionDTO();
		dto.setApprovalId(approvalId);
		dto.setDecision("APPROVE");
		dto.setComment("승인합니다");

		List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_MANAGER"));
		TokenPrincipal principal = new TokenPrincipal(11, "202501010", authorities);
		UsernamePasswordAuthenticationToken auth =
			new UsernamePasswordAuthenticationToken(principal, null, authorities);
		SecurityContextHolder.getContext().setAuthentication(auth);

		ApprovalEntity entity = ApprovalEntity.builder()
			.id(dto.getApprovalId())
			.reqId(requesterId)
			.aprvId(managerId)
			.state(ApprovalState.REQUESTED)
			.contractId(contractId)
			.build();

		ContractEntity contract = new ContractEntity();

		when(approvalRepository.findById(dto.getApprovalId())).thenReturn(Optional.of(entity));
		when(contractRepository.findById(contractId)).thenReturn(Optional.of(contract));
		when(employeeQueryService.findCodeById(requesterId)).thenReturn("202501010");

		// when
		approvalCommandService.decideApproval(dto);

		// then
		verify(approvalRepository).save(any());
		verify(notificationCommandService).createNotification(any());
		verify(performanceCommandService).refreshEmployeePerformance(eq("202501010"), anyInt());
	}

	@Test
	public void 결재처리_반려_성공() {

		// given
		int approvalId = 30;
		int requesterId = 15;
		int managerId = 99;
		int contractId = 5;

		ApprovalDecisionDTO dto = new ApprovalDecisionDTO();
		dto.setApprovalId(approvalId);
		dto.setDecision("REJECT");
		dto.setComment("반려합니다.");

		List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_MANAGER"));
		TokenPrincipal principal = new TokenPrincipal(managerId, "202501015", authorities);
		UsernamePasswordAuthenticationToken auth =
			new UsernamePasswordAuthenticationToken(principal, null, authorities);
		SecurityContextHolder.getContext().setAuthentication(auth);

		ApprovalEntity entity = ApprovalEntity.builder()
			.id(dto.getApprovalId())
			.reqId(requesterId)
			.aprvId(managerId)
			.state(ApprovalState.REQUESTED)
			.contractId(contractId)
			.build();

		ContractEntity contract = new ContractEntity();

		when(approvalRepository.findById(dto.getApprovalId())).thenReturn(Optional.of(entity));
		when(contractRepository.findById(contractId)).thenReturn(Optional.of(contract));
		when(employeeQueryService.findCodeById(requesterId)).thenReturn("202501015");

		// when
		approvalCommandService.decideApproval(dto);

		// then
		verify(approvalRepository).save(any());
		verify(notificationCommandService).createNotification(any());
		verify(performanceCommandService).refreshEmployeePerformance(eq("202501015"), anyInt());

	}

}
