package com.clover.salad.employee.query.service;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.common.file.repository.FileUploadRepository;
import com.clover.salad.employee.command.domain.aggregate.entity.DepartmentEntity;
import com.clover.salad.employee.command.domain.aggregate.entity.EmployeeEntity;
import com.clover.salad.employee.command.domain.aggregate.enums.EmployeeLevel;
import com.clover.salad.employee.command.domain.repository.DepartmentRepository;
import com.clover.salad.employee.command.domain.repository.EmployeeRepository;
import com.clover.salad.employee.query.dto.DepartmentEmployeeSearchResponseDTO;
import com.clover.salad.employee.query.dto.DepartmentHierarchyDTO;
import com.clover.salad.employee.query.dto.EmployeeDetailDTO;
import com.clover.salad.employee.query.dto.EmployeeMypageQueryDTO;
import com.clover.salad.employee.query.dto.EmployeeSearchRequestDTO;
import com.clover.salad.employee.query.dto.EmployeeSearchResponseDTO;
import com.clover.salad.employee.query.dto.LoginHeaderInfoDTO;
import com.clover.salad.employee.query.mapper.DepartmentMapper;
import com.clover.salad.employee.query.mapper.EmployeeMapper;

@ExtendWith(MockitoExtension.class)
class EmployeeQueryServiceImplTest {

	@Mock
	private EmployeeMapper employeeMapper;

	@Mock
	private DepartmentMapper departmentMapper;

	@Mock
	private EmployeeRepository employeeRepository;

	@Mock
	private FileUploadRepository fileUploadRepository;

	@Mock
	private DepartmentRepository departmentRepository;

	@InjectMocks
	private EmployeeQueryServiceImpl service;

	@Test
	public void 사원_리스트_검색() {
		// given
		EmployeeSearchRequestDTO dto = new EmployeeSearchRequestDTO();
		List<EmployeeSearchResponseDTO> expected = List.of(new EmployeeSearchResponseDTO());
		when(employeeMapper.searchEmployees(dto)).thenReturn(expected);

		// when
		List<EmployeeSearchResponseDTO> result = service.searchEmployees(dto);

		// then
		assertThat(result).isEqualTo(expected);
	}

	@Test
	public void 사번_조회() {
		// given
		EmployeeEntity employee = new EmployeeEntity();
		employee.setCode("A001");
		when(employeeRepository.findById(1)).thenReturn(Optional.of(employee));

		// when
		String code = service.findCodeById(1);

		// then
		assertThat(code).isEqualTo("A001");
	}

	@Test
	public void 이름_조회() {
		// given
		when(employeeMapper.findNameById(1)).thenReturn("홍길동");

		// when
		String name = service.findNameById(1);

		// then
		assertThat(name).isEqualTo("홍길동");
	}

	@Test
	public void 하위부서포함_사원조회() {
		// given
		List<DepartmentHierarchyDTO> subDepts = List.of(new DepartmentHierarchyDTO(1, "A", 0));
		List<DepartmentEmployeeSearchResponseDTO> employees = List.of(new DepartmentEmployeeSearchResponseDTO());

		when(departmentMapper.selectSubDepartments(10)).thenReturn(subDepts);
		when(employeeMapper.searchEmployeesByDeptIds(List.of(1))).thenReturn(employees);

		// when
		List<DepartmentEmployeeSearchResponseDTO> result = service.searchEmployeesByDepartmentWithSub(10);

		// then
		assertThat(result).isEqualTo(employees);
	}

	@Test
	public void 로그인_헤더_정보_조회() {
		// given
		LoginHeaderInfoDTO raw = new LoginHeaderInfoDTO(1, "이름", null, null, null);
		EmployeeEntity employee = new EmployeeEntity();
		employee.setLevel(EmployeeLevel.L2);

		when(employeeMapper.findLoginHeaderInfoById(1)).thenReturn(raw);
		when(employeeRepository.findById(1)).thenReturn(Optional.of(employee));

		// when
		LoginHeaderInfoDTO result = service.getLoginHeaderInfoById(1);

		// then
		assertThat(result.getId()).isEqualTo(1);
		assertThat(result.getName()).isEqualTo("이름");
		assertThat(result.getLevelLabel()).isEqualTo(EmployeeLevel.L2.getLabel());
	}


	@Test
	public void 마이페이지_정보_조회_성공() {
		// given
		int id = 1;

		EmployeeEntity employee = mock(EmployeeEntity.class);
		FileUploadEntity file = mock(FileUploadEntity.class);
		DepartmentEntity dept = mock(DepartmentEntity.class);

		when(employeeRepository.findById(id)).thenReturn(Optional.of(employee));
		when(fileUploadRepository.findById(anyInt())).thenReturn(Optional.of(file));
		when(departmentRepository.findById(anyInt())).thenReturn(Optional.of(dept));

		when(employee.getCode()).thenReturn("EMP123");
		when(employee.getName()).thenReturn("홍길동");
		when(employee.getPhone()).thenReturn("010-1234-5678");
		when(employee.getEmail()).thenReturn("hong@example.com");
		when(employee.getLevel()).thenReturn(EmployeeLevel.L1);
		when(employee.getHireDate()).thenReturn(LocalDate.of(2020, 1, 1));
		when(employee.getWorkPlace()).thenReturn("서울");
		when(employee.getProfile()).thenReturn(10);
		when(employee.getDepartmentId()).thenReturn(20);
		when(file.getPath()).thenReturn("/profile/image.png");
		when(dept.getName()).thenReturn("기획팀");

		// when
		EmployeeMypageQueryDTO result = service.getMyPageInfoById(id);

		// then
		assertThat(result.getCode()).isEqualTo("EMP123");
		assertThat(result.getName()).isEqualTo("홍길동");
		assertThat(result.getEmail()).isEqualTo("hong@example.com");
		assertThat(result.getPhone()).isEqualTo("010-1234-5678");
		assertThat(result.getLevel()).isEqualTo("사원");
		assertThat(result.getHireDate()).isEqualTo(LocalDate.of(2020, 1, 1));
		assertThat(result.getWorkPlace()).isEqualTo("서울");
		assertThat(result.getProfilePath()).isEqualTo("/profile/image.png");
		assertThat(result.getDepartmentName()).isEqualTo("기획팀");
	}

	@Test
	public void 상세정보_조회() {
		// given
		EmployeeDetailDTO dto = new EmployeeDetailDTO();
		when(employeeMapper.findEmployeeDetailById(1)).thenReturn(dto);

		// when
		EmployeeDetailDTO result = service.getEmployeeDetailById(1);

		// then
		assertThat(result).isEqualTo(dto);
	}
}
