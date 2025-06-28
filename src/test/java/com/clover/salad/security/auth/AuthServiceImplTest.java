package com.clover.salad.security.auth;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import static reactor.core.publisher.Mono.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.security.EmployeeDetails;

@ExtendWith(MockitoExtension.class)
class AuthServiceImplTest {

	@Mock
	private EmployeeQueryService employeeQueryService;

	@InjectMocks
	private AuthServiceImpl authServiceImpl;

	@Test
	public void 아이디로_유저정보_조회_성공() {

		// given
		int id = 101;
		EmployeeDetails details = new EmployeeDetails(id, "202501101", "pw",
			List.of(new SimpleGrantedAuthority("ROLE_MEMBER")));

		when(employeeQueryService.loadUserById(id)).thenReturn(details);

		// when
		EmployeeDetails result = (EmployeeDetails) authServiceImpl.loadUserById(id);

		// then
		assertThat(result).isEqualTo(details);
		verify(employeeQueryService).loadUserById(id);
	}

	@Test
	public void 아이디로_사번_조회_성공() {

		// given
		int id = 102;
		when(employeeQueryService.findCodeById(id)).thenReturn("202501102");

		// when
		String result = authServiceImpl.findCodeByEmployeeId(id);

		// then
		assertThat(result).isEqualTo("202501102");
		verify(employeeQueryService).findCodeById(id);
	}

}
