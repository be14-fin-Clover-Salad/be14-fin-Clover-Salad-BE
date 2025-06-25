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

import com.clover.salad.approval.command.application.dto.ApprovalRequestDTO;
import com.clover.salad.approval.command.domain.aggregate.entity.ApprovalEntity;
import com.clover.salad.approval.command.domain.repository.ApprovalRepository;
import com.clover.salad.approval.query.mapper.ApprovalMapper;
import com.clover.salad.contract.command.entity.ContractEntity;
import com.clover.salad.contract.command.repository.ContractRepository;
import com.clover.salad.employee.query.mapper.EmployeeMapper;
import com.clover.salad.notification.command.application.service.NotificationCommandService;
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

	@InjectMocks
	private ApprovalCommandServiceImpl approvalCommandService;

	@BeforeEach
	void setUp() {
		List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_MEMBER"));

		// TokenPrincipal 생성
		TokenPrincipal principal = new TokenPrincipal(10, "EMP001", authorities);

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
}
