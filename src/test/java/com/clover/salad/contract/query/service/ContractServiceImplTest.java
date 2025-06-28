package com.clover.salad.contract.query.service;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.util.ArrayList;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

import com.clover.salad.contract.query.dto.ContractDTO;
import com.clover.salad.contract.query.dto.ContractResponseDTO;
import com.clover.salad.contract.query.dto.ContractSearchDTO;
import com.clover.salad.contract.query.mapper.ContractMapper;
import com.clover.salad.employee.query.dto.EmployeeQueryDTO;
import com.clover.salad.employee.query.mapper.EmployeeMapper;
import com.clover.salad.security.SecurityUtil;

import org.mockito.Mock;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.MockedStatic;

@ExtendWith(MockitoExtension.class)
class ContractServiceImplTest {

	@Mock
	ContractMapper contractMapper;

	@Mock
	EmployeeMapper employeeMapper;

	@InjectMocks
	ContractServiceImpl contractService;

	MockedStatic<SecurityUtil> securityUtilMock;

	@BeforeEach
	void setUp() {
		securityUtilMock = mockStatic(SecurityUtil.class);
	}

	@DisplayName("findContractInfo: 직원 ID로 계약 리스트 조회 - 정상 케이스")
	@Test
	void findContractInfo_returnsContractList() {
		// given
		int employeeId = 42;
		List<ContractDTO> expectedList = new ArrayList<>();
		expectedList.add(new ContractDTO());
		when(contractMapper.selectContractInfo(employeeId)).thenReturn(expectedList);

		// when
		List<ContractDTO> actualList = contractService.findContractInfo(employeeId);

		// then
		assertNotNull(actualList, "결과 리스트가 null이 아니어야 한다");
		assertEquals(1, actualList.size(), "리스트 크기가 1이어야 한다");
		verify(contractMapper, times(1)).selectContractInfo(employeeId);
	}

	@DisplayName("searchContracts: ROLE_MANAGER인 경우 workplace 설정 후 검색 호출")
	@Test
	void searchContracts_roleManager_setsWorkPlace() {
		// given
		ContractSearchDTO searchDto = new ContractSearchDTO();
		int dummyParam = 0;
		int currentEmployeeId = 100;
		EmployeeQueryDTO employeeDto = new EmployeeQueryDTO();
		employeeDto.setWorkPlace("Seoul Office");

		// SecurityUtil 모킹
		securityUtilMock.when(SecurityUtil::getEmployeeId).thenReturn(currentEmployeeId);
		securityUtilMock.when(() -> SecurityUtil.hasRole("ROLE_MANAGER")).thenReturn(true);
		securityUtilMock.when(() -> SecurityUtil.hasRole("ROLE_ADMIN")).thenReturn(false);

		when(employeeMapper.findEmployeeById(currentEmployeeId)).thenReturn(employeeDto);
		when(contractMapper.searchContracts(eq(currentEmployeeId), any(ContractSearchDTO.class))).thenReturn(List.of(new ContractDTO()));

		// when
		List<ContractDTO> results = contractService.searchContracts(dummyParam, searchDto);

		// then
		assertNotNull(results, "검색 결과가 null이 아니어야 한다");
		// 검색 DTO가 workPlace 셋팅되고 employeeId는 null로 변경됨 확인
		assertEquals("Seoul Office", searchDto.getWorkPlace(), "workPlace 필드가 설정되어야 한다");
		assertNull(searchDto.getEmployeeId(), "employeeId는 null이어야 한다");

		verify(employeeMapper, times(1)).findEmployeeById(currentEmployeeId);
		verify(contractMapper, times(1)).searchContracts(currentEmployeeId, searchDto);
	}

	@DisplayName("searchContracts: ROLE_ADMIN인 경우 admin 전용 검색 호출")
	@Test
	void searchContracts_roleAdmin_callsAdminSearch() {
		// given
		ContractSearchDTO searchDto = new ContractSearchDTO();
		int dummyParam = 0;
		int currentEmployeeId = 200;

		securityUtilMock.when(SecurityUtil::getEmployeeId).thenReturn(currentEmployeeId);
		securityUtilMock.when(() -> SecurityUtil.hasRole("ROLE_MANAGER")).thenReturn(false);
		securityUtilMock.when(() -> SecurityUtil.hasRole("ROLE_ADMIN")).thenReturn(true);

		List<ContractDTO> adminResults = List.of(new ContractDTO(), new ContractDTO());
		when(contractMapper.searchContractsAdmin(eq(1), eq(searchDto))).thenReturn(adminResults);

		// when
		List<ContractDTO> results = contractService.searchContracts(dummyParam, searchDto);

		// then
		assertNotNull(results);
		assertEquals(2, results.size(), "관리자 검색 결과 개수 일치");
		verify(contractMapper, times(1)).searchContractsAdmin(1, searchDto);
		// admin인 경우 employeeMapper 호출 안함
		verify(employeeMapper, never()).findEmployeeById(anyInt());
	}

	@DisplayName("searchContracts: 일반 사용자일 경우 본인 employeeId 설정 후 검색 호출")
	@Test
	void searchContracts_normalUser_setsEmployeeId() {
		// given
		ContractSearchDTO searchDto = new ContractSearchDTO();
		int dummyParam = 0;
		int currentEmployeeId = 300;

		securityUtilMock.when(SecurityUtil::getEmployeeId).thenReturn(currentEmployeeId);
		securityUtilMock.when(() -> SecurityUtil.hasRole("ROLE_MANAGER")).thenReturn(false);
		securityUtilMock.when(() -> SecurityUtil.hasRole("ROLE_ADMIN")).thenReturn(false);

		when(contractMapper.searchContracts(eq(currentEmployeeId), any(ContractSearchDTO.class)))
			.thenReturn(List.of(new ContractDTO()));

		// when
		List<ContractDTO> results = contractService.searchContracts(dummyParam, searchDto);

		// then
		assertNotNull(results);
		assertEquals(currentEmployeeId, searchDto.getEmployeeId(), "employeeId가 본인으로 설정되어야 한다");
		assertNull(searchDto.getWorkPlace(), "workPlace는 null이어야 한다");
		verify(contractMapper, times(1)).searchContracts(currentEmployeeId, searchDto);
	}

	@DisplayName("findDetailInfo: 계약 상세 정보 조회 - 정상 ")
	@Test
	void findDetailInfo_returnsContractResponseDTO() {
		// given
		int contractId = 999;
		ContractResponseDTO expectedResponse = new ContractResponseDTO();

		when(contractMapper.selectDetailContractInfo(contractId)).thenReturn(expectedResponse);

		// when
		ContractResponseDTO result = contractService.findDetailInfo(contractId);

		// then
		assertNotNull(result);
		assertEquals(expectedResponse, result);
		verify(contractMapper, times(1)).selectDetailContractInfo(contractId);
	}

	@DisplayName("getCustomerIdsByEmployee: 직원별 고객 ID 리스트 조회 - 정상 ")
	@Test
	void getCustomerIdsByEmployee_returnsList() {
		// given
		int employeeId = 123;
		List<Integer> customerIds = List.of(1, 2, 3);

		when(contractMapper.findCustomerIdsByEmployeeId(employeeId)).thenReturn(customerIds);

		// when
		List<Integer> results = contractService.getCustomerIdsByEmployee(employeeId);

		// then
		assertNotNull(results);
		assertEquals(3, results.size());
		verify(contractMapper, times(1)).findCustomerIdsByEmployeeId(employeeId);
	}

	@DisplayName("contractValidationById: 계약 존재 여부 확인 - true 반환")
	@Test
	void contractValidationById_exists_returnsTrue() {
		// given
		int contractId = 55;
		when(contractMapper.existsById(contractId)).thenReturn(true);

		// when
		Boolean exists = contractService.contractValidationById(contractId);

		// then
		assertTrue(exists, "계약이 존재하면 true를 반환해야 한다");
		verify(contractMapper, times(1)).existsById(contractId);
	}

	@DisplayName("contractValidationById: 계약 존재하지 않을 경우 false 반환")
	@Test
	void contractValidationById_notExists_returnsFalse() {
		// given
		int contractId = 66;
		when(contractMapper.existsById(contractId)).thenReturn(false);

		// when
		Boolean exists = contractService.contractValidationById(contractId);

		// then
		assertFalse(exists, "계약이 없으면 false를 반환해야 한다");
		verify(contractMapper, times(1)).existsById(contractId);
	}

	@org.junit.jupiter.api.AfterEach
	void tearDown() {
		securityUtilMock.close();
	}
}
