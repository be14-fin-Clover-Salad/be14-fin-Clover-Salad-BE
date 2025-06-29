package com.clover.salad.performance.query.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.List;

import com.clover.salad.common.exception.EmployeeNotFoundException;
import com.clover.salad.employee.query.dto.EmployeeSearchRequestDTO;
import com.clover.salad.employee.query.dto.EmployeeSearchResponseDTO;
import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.performance.command.application.dto.*;
import com.clover.salad.performance.query.mapper.PerformanceMapper;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class PerformanceQueryServiceImplTest {

    @InjectMocks
    private PerformanceQueryServiceImpl performanceQueryService;

    @Mock
    private PerformanceMapper performanceMapper;

    @Mock
    private EmployeeQueryService employeeQueryService;

    @Test
    void testSearchEmployeePerformanceByEmployeeCode_Success() {
        // given
        String code = "E001";
        int id = 123;
        SearchTermDTO searchTerm = new SearchTermDTO(202401, 202406);

        EmployeeSearchResponseDTO emp = new EmployeeSearchResponseDTO();
        emp.setId(id);
        when(employeeQueryService.searchEmployees(any(EmployeeSearchRequestDTO.class)))
            .thenReturn(List.of(emp));

        List<EmployeePerformanceDTO> expected = List.of(new EmployeePerformanceDTO());
        when(performanceMapper.selectEmployeePerformanceByEmployeeId(id, 202401, 202406))
            .thenReturn(expected);

        // when
        List<EmployeePerformanceDTO> result =
            performanceQueryService.searchEmployeePerformanceByEmployeeCode(code, searchTerm);

        // then
        assertEquals(expected, result);
        verify(employeeQueryService).searchEmployees(any());
        verify(performanceMapper).selectEmployeePerformanceByEmployeeId(id, 202401, 202406);
    }

    @Test
    void testSearchEmployeePerformanceByEmployeeCode_NotFound() {
        // given
        String code = "E001";
        when(employeeQueryService.searchEmployees(any())).thenReturn(List.of());

        // when & then
        assertThrows(EmployeeNotFoundException.class, () ->
            performanceQueryService.searchEmployeePerformanceByEmployeeCode(
                code, new SearchTermDTO(202401, 202406))
        );
    }

    @Test
    void testSearchDepartmentPerformanceByDepartmentName() {
        // given
        String dept = "영업팀";
        SearchTermDTO searchTerm = new SearchTermDTO(202401, 202406);

        List<DepartmentPerformanceDTO> expected = List.of(new DepartmentPerformanceDTO());
        when(performanceMapper.selectDepartmentPerformanceByDepartmentName(dept, 202401, 202406))
            .thenReturn(expected);

        // when
        List<DepartmentPerformanceDTO> result =
            performanceQueryService.searchDepartmentPerformanceByDepartmentName(dept, searchTerm);

        // then
        assertEquals(expected, result);
        verify(performanceMapper).selectDepartmentPerformanceByDepartmentName(dept, 202401, 202406);
    }

    @Test
    void testSearchProductPerformanceByProductCode() {
        // given
        String productCode = "P001";
        SearchTermDTO term = new SearchTermDTO(202401, 202403);

        String expectedStart = "2024-01-01";
        String expectedEnd = "2024-03-31";

        List<ProductPerformancePerMonthDTO> expected = List.of(new ProductPerformancePerMonthDTO());
        when(performanceMapper.selectProductPerformanceByProductCode(productCode, expectedStart, expectedEnd))
            .thenReturn(expected);

        // when
        List<ProductPerformancePerMonthDTO> result =
            performanceQueryService.searchProductPerformanceByProductCode(productCode, term);

        // then
        assertEquals(expected, result);
        verify(performanceMapper)
            .selectProductPerformanceByProductCode(productCode, expectedStart, expectedEnd);
    }

    @Test
    void testSearchEmployeePerformanceByTargetDateAndDepartmentId() {
        // given
        int deptId = 10;
        int targetDate = 202406;

        List<EmployeePerformanceDTO> expected = List.of(new EmployeePerformanceDTO());
        when(performanceMapper.selectEmployeePerformanceByTargetDateAndDepartmentId(deptId, targetDate))
            .thenReturn(expected);

        // when
        List<EmployeePerformanceDTO> result =
            performanceQueryService.searchEmployeePerformanceByTargetDateAndDepartmentId(deptId, targetDate);

        // then
        assertEquals(expected, result);
        verify(performanceMapper).selectEmployeePerformanceByTargetDateAndDepartmentId(deptId, targetDate);
    }

    @Test
    void testGetDayOfMonth_First() {
        // when
        String result = PerformanceQueryServiceImpl.getDayOfMonth(202406, true);

        // then
        assertEquals("2024-06-01", result);
    }

    @Test
    void testGetDayOfMonth_Last() {
        // when
        String result = PerformanceQueryServiceImpl.getDayOfMonth(202402, false); // 윤년 2월

        // then
        assertEquals("2024-02-29", result);
    }
}
