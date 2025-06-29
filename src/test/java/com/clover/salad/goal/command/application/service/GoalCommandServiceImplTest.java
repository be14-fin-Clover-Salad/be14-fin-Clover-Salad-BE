package com.clover.salad.goal.command.application.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.clover.salad.employee.command.domain.aggregate.entity.EmployeeEntity;
import com.clover.salad.employee.command.domain.aggregate.enums.EmployeeLevel;
import com.clover.salad.employee.command.domain.repository.EmployeeRepository;
import com.clover.salad.goal.command.application.dto.DefaultGoalDTO;
import com.clover.salad.goal.command.application.dto.GoalDTO;
import com.clover.salad.goal.command.domain.aggregate.entity.Goal;
import com.clover.salad.goal.command.domain.repository.GoalRepository;
import com.clover.salad.goal.query.service.GoalQueryService;
import com.clover.salad.security.SecurityUtil;

@ExtendWith(MockitoExtension.class)
@DisplayName("실적 목표 서비스 계층 테스트")
class GoalCommandServiceImplTest {

	@InjectMocks
	private GoalCommandServiceImpl goalCommandService;

	@Mock
	private GoalRepository goalRepository;

	@Mock
	private GoalQueryService goalQueryService;

	@Mock
	private EmployeeRepository employeeRepository;

	// 유틸리티 클래스는 static mocking 필요 시 Mockito.mockStatic 사용
	
	@Test
	void testRegisterGoalSuccess() {
	    // given
	    int employeeId = 1;
	    EmployeeEntity employee = new EmployeeEntity();
	    employee.setId(employeeId);
	    employee.setLevel(EmployeeLevel.L1);
	
	    int targetDate = 202401;
	
	    DefaultGoalDTO defaultGoal = new DefaultGoalDTO();
		defaultGoal.setLevel(EmployeeLevel.L1.getLabel());
		defaultGoal.setTargetYear(2024);
	    defaultGoal.setRentalProductCount(5);
	    defaultGoal.setRentalRetentionRate(50);
	    defaultGoal.setNewCustomerCount(2);
	    defaultGoal.setTotalRentalAmount(500000L);
	    defaultGoal.setCustomerFeedbackScore(43);
	
	    List<GoalDTO> goalList = new ArrayList<>();
		for (int i = 0; i < 12; i++) {
			GoalDTO tempGoal = new GoalDTO();
			tempGoal.setTargetDate(targetDate + i);
			tempGoal.setRentalProductCount(10);
			tempGoal.setRentalRetentionCount(9);
			tempGoal.setTotalRentalCount(10);
			tempGoal.setNewCustomerCount(5);
			tempGoal.setTotalRentalAmount(1000000L);
			tempGoal.setCustomerFeedbackScore(250);
			tempGoal.setCustomerFeedbackCount(5);
			goalList.add(tempGoal);
		}
	
	    when(employeeRepository.findById(employeeId)).thenReturn(Optional.of(employee));
	    when(goalQueryService.searchDefaultGoalByLevelAndTargetYear(
			employee.getLevel().getLabel(),
			targetDate / 100)
		).thenReturn(defaultGoal);
	
	    // when
	    goalCommandService.registerGoal(goalList, employeeId);
	
	    // then
	    verify(goalRepository, times(12)).save(any(Goal.class));
	}
	
	@Test
	void testChangeGoalUserNotFound() {
	    // given
	    int employeeId = 99;
	    when(employeeRepository.findById(employeeId)).thenReturn(Optional.empty());
	
	    List<GoalDTO> goalList = new ArrayList<>();
	
	    // when & then
	    assertThrows(UsernameNotFoundException.class, () -> goalCommandService.changeGoal(goalList, employeeId));
	}
	
	@Test
	void testDeleteGoalNoAdmin() {
	    try (MockedStatic<SecurityUtil> mockedStatic = Mockito.mockStatic(SecurityUtil.class)) {
	        // given
	        mockedStatic.when(() -> SecurityUtil.hasRole("ROLE_ADMIN")).thenReturn(false);
	
	        GoalDTO goalDTO = new GoalDTO();
	        goalDTO.setEmployeeId(1);
	        goalDTO.setTargetDate(202401);
	        List<GoalDTO> goalList = List.of(goalDTO);
	
	        // when & then
	        assertThrows(SecurityException.class, () -> goalCommandService.deleteGoal(goalList));
	    }
	}
}

