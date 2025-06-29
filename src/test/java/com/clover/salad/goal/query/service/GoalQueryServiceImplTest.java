package com.clover.salad.goal.query.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.employee.query.dto.EmployeeSearchRequestDTO;
import com.clover.salad.employee.query.dto.EmployeeSearchResponseDTO;
import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.goal.command.application.dto.DefaultGoalDTO;
import com.clover.salad.goal.command.application.dto.DeptSearchTermDTO;
import com.clover.salad.goal.command.application.dto.EmployeeSearchTermDTO;
import com.clover.salad.goal.command.application.dto.GoalDTO;
import com.clover.salad.goal.query.mapper.GoalMapper;

@ExtendWith(MockitoExtension.class)
class GoalQueryServiceImplTest {
	
	@InjectMocks
	private GoalQueryServiceImpl goalQueryService;
	
	@Mock
	private GoalMapper goalMapper;
	
	@Mock
	private EmployeeQueryService employeeQueryService;
	
	@Test
	void testSearchGoalByEmployeeId() {
		// given
		EmployeeSearchTermDTO searchTerm = new EmployeeSearchTermDTO();
		List<GoalDTO> expectedList = List.of(new GoalDTO());
		
		when(goalMapper.selectGoalByEmployeeId(searchTerm)).thenReturn(expectedList);
		
		// when
		List<GoalDTO> result = goalQueryService.searchGoalByEmployeeId(searchTerm);
		
		// then
		assertEquals(expectedList, result);
		verify(goalMapper).selectGoalByEmployeeId(searchTerm);
	}
	
	@Test
	void testSearchGoalByDepartmentId() {
		// given
		DeptSearchTermDTO searchTerm = new DeptSearchTermDTO();
		List<GoalDTO> goalList = List.of(new GoalDTO());
		
		when(goalMapper.selectGoalByDepartmentId(searchTerm)).thenReturn(goalList);
		
		// when
		List<GoalDTO> result = goalQueryService.searchGoalByDepartmentId(searchTerm);
		
		// then
		assertEquals(goalList, result);
		verify(goalMapper).selectGoalByDepartmentId(searchTerm);
	}
	
	@Test
	void testSearchDefaultGoalByLevelAndTargetYear() {
		// given
		String level = "Manager";
		int year = 2024;
		DefaultGoalDTO expected = new DefaultGoalDTO();
		
		when(goalMapper.selectDefaultGoalByLevelAndTargetYear(level, year)).thenReturn(expected);
		
		// when
		DefaultGoalDTO result = goalQueryService.searchDefaultGoalByLevelAndTargetYear(level, year);
		
		// then
		assertEquals(expected, result);
		verify(goalMapper).selectDefaultGoalByLevelAndTargetYear(level, year);
	}
	
	@Test
	void testSearchYearGoalByCurrentGoal() {
		// given
		int employeeCode = 1234;
		int targetYear = 2024;
		
		EmployeeSearchResponseDTO employee = new EmployeeSearchResponseDTO();
		employee.setId(10);
		
		List<EmployeeSearchResponseDTO> expectedEmployeeList = List.of(employee);
		List<GoalDTO> expectedGoals = List.of(new GoalDTO());
		
		when(employeeQueryService.searchEmployees(any())).thenReturn(expectedEmployeeList);
		when(goalMapper.selectYearGoalByCurrentGoalTargetDate(10, targetYear)).thenReturn(expectedGoals);
		
		// when
		List<GoalDTO> result = goalQueryService.searchYearGoalByCurrentGoal(employeeCode, targetYear);
		
		// then
		assertEquals(expectedGoals, result);
		verify(employeeQueryService).searchEmployees(any());
		verify(goalMapper).selectYearGoalByCurrentGoalTargetDate(10, targetYear);
	}
}

