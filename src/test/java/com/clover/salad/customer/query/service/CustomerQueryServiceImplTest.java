package com.clover.salad.customer.query.service;

import com.clover.salad.common.exception.CustomersException;
import com.clover.salad.common.util.AuthUtil;
import com.clover.salad.consult.query.dto.ConsultQueryDTO;
import com.clover.salad.consult.query.service.ConsultQueryService;
import com.clover.salad.customer.query.dto.CustomerQueryDTO;
import com.clover.salad.customer.query.mapper.CustomerMapper;
import com.clover.salad.employee.query.dto.EmployeeQueryDTO;
import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.security.JwtUtil;
import com.clover.salad.security.SecurityUtil;

import jakarta.servlet.http.HttpServletRequest;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;

import java.util.List;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class CustomerQueryServiceImplTest {

    @Mock
    private CustomerMapper customerMapper;
    @Mock
    private ConsultQueryService consultQueryService;
    @Mock
    private EmployeeQueryService employeeQueryService;
    @Mock
    private JwtUtil jwtUtil;
    @Mock
    private HttpServletRequest request;

    @InjectMocks
    private CustomerQueryServiceImpl customerQueryService;

    // 2. findMyCustomers - 정상 조회
    @Test
    void 내_고객_조회_성공() {
        String token = "jwt.token";
        int employeeId = 5;

        when(jwtUtil.resolveToken(request)).thenReturn(token);
        when(jwtUtil.getEmployeeId(token)).thenReturn(employeeId);

        List<CustomerQueryDTO> mockList = List.of(new CustomerQueryDTO());
        when(customerMapper.findCustomersByEmployeeId(employeeId)).thenReturn(mockList);

        List<CustomerQueryDTO> result = customerQueryService.findMyCustomers();

        assertThat(result).isNotEmpty();
        verify(customerMapper).findCustomersByEmployeeId(employeeId);
    }

    // 3. findMyCustomers - 고객 없음 예외
    @Test
    void 내_고객_조회_실패_고객없음() {
        String token = "token";
        int employeeId = 10;

        when(jwtUtil.resolveToken(request)).thenReturn(token);
        when(jwtUtil.getEmployeeId(token)).thenReturn(employeeId);

        when(customerMapper.findCustomersByEmployeeId(employeeId)).thenReturn(List.of());

        assertThatThrownBy(() -> customerQueryService.findMyCustomers())
                .isInstanceOf(CustomersException.CustomerNotFoundException.class)
                .hasMessageContaining("담당하는 고객이 없거나");
    }

    // 4. findCustomerById - 관리자 전용
    @Test
    void 고객_단건_조회_ADMIN() {
        int customerId = 1;

        try (MockedStatic<AuthUtil> auth = mockStatic(AuthUtil.class)) {
            // auth.when(AuthUtil::assertAdmin).thenCallRealMethod();

            when(customerMapper.findCustomerById(customerId)).thenReturn(new CustomerQueryDTO());

            CustomerQueryDTO result = customerQueryService.findCustomerById(customerId);

            assertThat(result).isNotNull();
        }
    }
}
