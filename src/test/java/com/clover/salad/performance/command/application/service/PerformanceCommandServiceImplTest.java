package com.clover.salad.performance.command.application.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentMatchers;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.modelmapper.ExpressionMap;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeMap;

import com.clover.salad.common.exception.EmployeeNotFoundException;
import com.clover.salad.consult.query.dto.ConsultQueryDTO;
import com.clover.salad.consult.query.service.ConsultQueryService;
import com.clover.salad.contract.query.dto.ContractDTO;
import com.clover.salad.contract.query.service.ContractService;
import com.clover.salad.contract.command.repository.ContractProductRepository;
import com.clover.salad.customer.query.dto.CustomerQueryDTO;
import com.clover.salad.customer.query.service.CustomerQueryService;
import com.clover.salad.employee.command.domain.aggregate.entity.DepartmentEntity;
import com.clover.salad.employee.command.domain.repository.DepartmentRepository;
import com.clover.salad.employee.query.dto.EmployeeSearchResponseDTO;
import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.performance.command.application.dto.DepartmentPerformanceDTO;
import com.clover.salad.performance.command.application.dto.EmployeePerformanceDTO;
import com.clover.salad.performance.command.domain.aggregate.entity.DepartmentPerformance;
import com.clover.salad.performance.command.domain.aggregate.entity.EmployeePerformance;
import com.clover.salad.performance.command.domain.repository.DepartmentPerformanceRepository;
import com.clover.salad.performance.command.domain.repository.EmployeePerformanceRepository;
import com.clover.salad.performance.query.service.PerformanceQueryService;

@ExtendWith(MockitoExtension.class)
class PerformanceCommandServiceImplTest {
	
	@InjectMocks
	private PerformanceCommandServiceImpl performanceCommandService;
	
	@Mock
	private EmployeePerformanceRepository employeePerformanceRepository;
	@Mock
	private EmployeeQueryService employeeQueryService;
	@Mock
	private DepartmentRepository departmentRepository;
	@Mock
	private DepartmentPerformanceRepository departmentPerformanceRepository;
	@Mock
	private PerformanceQueryService performanceQueryService;
	@Mock
	private ModelMapper modelMapper;
	@Mock
	private ConsultQueryService consultQueryService;
	@Mock
	private ContractService contractService;
	@Mock
	private ContractProductRepository contractProductRepository;
	@Mock
	private CustomerQueryService customerQueryService;
	
	@Test
	void testRefreshEmployeePerformance_Success() {
		// given
		String employeeCode = "202501001";
		int targetDate = 202406;
		
		EmployeeSearchResponseDTO employee = new EmployeeSearchResponseDTO();
		employee.setId(100);
		when(employeeQueryService.searchEmployees(any())).thenReturn(List.of(employee));
		when(employeePerformanceRepository.findByEmployeeIdAndTargetDate(100, targetDate)).thenReturn(null);
		
		ConsultQueryDTO consult = new ConsultQueryDTO();
		consult.setConsultAt("2024-06-01 10:00:00");
		consult.setFeedbackScore(80.0);
		when(consultQueryService.findCurrentOnly(100)).thenReturn(List.of(consult));
		
		when(contractService.searchContracts(eq(100), any())).thenReturn(List.of(createContractDTO(1, 1000)));
		
		CustomerQueryDTO customer = new CustomerQueryDTO();
		customer.setRegisterAt(
			LocalDate.parse("2024-05-15 12:00:00", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
		);
		
		when(customerQueryService.findCurrentOnly(anyInt())).thenReturn(customer);
		
		mockTypeMap(EmployeePerformanceDTO.class, EmployeePerformance.class);
		when(modelMapper.map(any(EmployeePerformanceDTO.class), eq(EmployeePerformance.class)))
			.thenReturn(new EmployeePerformance());
		
		// when
		performanceCommandService.refreshEmployeePerformance(employeeCode, targetDate);
		
		// then
		verify(employeePerformanceRepository).save(any(EmployeePerformance.class));
	}
	
	@Test
	void testRefreshEmployeePerformance_EmployeeNotFound() {
		// given
		String employeeCode = "E001";
		int targetDate = 202406;
		when(employeeQueryService.searchEmployees(any())).thenReturn(List.of());
		
		// expect
		assertThrows(EmployeeNotFoundException.class, () ->
			performanceCommandService.refreshEmployeePerformance(employeeCode, targetDate)
		);
		verify(employeeQueryService).searchEmployees(any());
	}
	
	@Test
	void testRefreshDepartmentPerformance_UpdateExistingPerformance() {
		// given
		String deptName = "영업팀";
		int targetDate = 202406;
		int deptId = 1;
		
		DepartmentEntity department = new DepartmentEntity();
		department.setId(deptId);
		when(departmentRepository.findByName(deptName)).thenReturn(department);
		when(departmentPerformanceRepository.findByDepartmentIdAndTargetDate(deptId, targetDate)).thenReturn(null);
		
		EmployeePerformanceDTO ep1 = createSampleEmployeePerformanceDTO();
		when(performanceQueryService.searchEmployeePerformanceByTargetDateAndDepartmentId(targetDate, deptId))
			.thenReturn(List.of(ep1));
		
		mockTypeMap(DepartmentPerformanceDTO.class, DepartmentPerformance.class);
		when(modelMapper.map(any(DepartmentPerformanceDTO.class), eq(DepartmentPerformance.class)))
			.thenReturn(new DepartmentPerformance());
		
		// when
		performanceCommandService.refreshDepartmentPerformance(deptName, targetDate);
		
		// then
		verify(departmentPerformanceRepository).save(any(DepartmentPerformance.class));
	}
	
	@Test
	void testRefreshDepartmentPerformance_NewInsert() {
		// given
		String deptName = "영업팀";
		int targetDate = 202406;
		int deptId = 1;
		
		DepartmentEntity department = new DepartmentEntity();
		department.setId(deptId);
		when(departmentRepository.findByName(deptName)).thenReturn(department);
		when(departmentPerformanceRepository.findByDepartmentIdAndTargetDate(deptId, targetDate)).thenReturn(null);
		
		EmployeePerformanceDTO ep1 = createSampleEmployeePerformanceDTO();
		when(performanceQueryService.searchEmployeePerformanceByTargetDateAndDepartmentId(targetDate, deptId))
			.thenReturn(List.of(ep1));
		
		mockTypeMap(DepartmentPerformanceDTO.class, DepartmentPerformance.class);
		when(modelMapper.map(any(DepartmentPerformanceDTO.class), eq(DepartmentPerformance.class)))
			.thenReturn(new DepartmentPerformance());
		
		// when
		performanceCommandService.refreshDepartmentPerformance(deptName, targetDate);
		
		// then
		verify(departmentPerformanceRepository).save(any(DepartmentPerformance.class));
	}
	
	// 헬퍼 메서드: 타입 매핑 모킹
	private <S, D> void mockTypeMap(Class<S> source, Class<D> dest) {
		@SuppressWarnings("unchecked")
		TypeMap<S, D> typeMapMock = mock(TypeMap.class);
		when(modelMapper.typeMap(source, dest)).thenReturn(typeMapMock);
		doReturn(typeMapMock)
			.when(typeMapMock)
			.addMappings(ArgumentMatchers.<ExpressionMap<S, D>>any());
	}
	
	private EmployeePerformanceDTO createSampleEmployeePerformanceDTO() {
		return EmployeePerformanceDTO.builder()
			.rentalProductCount(2)
			.rentalRetentionCount(1)
			.totalRentalCount(3)
			.newCustomerCount(1)
			.totalRentalAmount(1000L)
			.customerFeedbackScore(90)
			.customerFeedbackCount(1)
			.build();
	}
	
	private ContractDTO createContractDTO(int customerId, int amount) {
		ContractDTO dto = new ContractDTO();
		dto.setId(1);
		dto.setCustomerId(customerId);
		dto.setAmount(amount);
		return dto;
	}
}
