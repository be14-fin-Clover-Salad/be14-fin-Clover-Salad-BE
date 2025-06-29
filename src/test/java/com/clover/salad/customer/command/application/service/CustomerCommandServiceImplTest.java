package com.clover.salad.customer.command.application.service;

import com.clover.salad.common.exception.CustomersException;
import com.clover.salad.common.util.AuthUtil;
import com.clover.salad.consult.query.service.ConsultQueryService;
import com.clover.salad.contract.query.service.ContractService;
import com.clover.salad.customer.command.application.dto.CustomerCreateRequest;
import com.clover.salad.customer.command.application.dto.CustomerUpdateRequest;
import com.clover.salad.customer.command.domain.aggregate.entity.Customer;
import com.clover.salad.customer.command.domain.aggregate.vo.CustomerType;
import com.clover.salad.customer.command.domain.repository.CustomerRepository;
import com.clover.salad.customer.query.service.CustomerQueryService;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class CustomerCommandServiceImplTest {

    @Mock
    private CustomerRepository customerRepository;
    @Mock
    private CustomerQueryService customerQueryService;
    @Mock
    private ContractService contractService;
    @Mock
    private ConsultQueryService consultQueryService;

    @InjectMocks
    private CustomerCommandServiceImpl customerCommandService;

    // 1. registerCustomer - 신규 고객 등록 성공 (bypass)
    @Test
    void 신규_고객_등록() {
        CustomerCreateRequest request = mock(CustomerCreateRequest.class);
        when(request.getName()).thenReturn("홍길동");
        when(request.getPhone()).thenReturn("01012345678");
        when(request.getBirthdate()).thenReturn("19900101");

        when(customerQueryService.findRegisteredCustomerId(any(), any(), any())).thenReturn(null); // 신규
        when(customerQueryService.existsConsultByCustomer(any(), any(), any())).thenReturn(true); // 기존
                                                                                                  // //
                                                                                                  // 이력

        Customer saved = Customer.builder().type(CustomerType.PROSPECT).build();
        saved.setId(100);
        when(request.toEntity()).thenReturn(saved);
        when(customerRepository.saveAndFlush(any())).thenReturn(saved);

        Integer resultId = customerCommandService.registerCustomer(request, true);

        assertThat(resultId).isEqualTo(100);
        verify(customerRepository).saveAndFlush(any());
    }

    // 2. registerCustomer - 기존 고객이면 update만
    @Test
    void 기존_고객일_경우_수정() {
        CustomerCreateRequest request = mock(CustomerCreateRequest.class);
        when(request.getName()).thenReturn("김철수");
        when(request.getPhone()).thenReturn("01099998888");
        when(request.getBirthdate()).thenReturn("19851225");

        when(customerQueryService.findRegisteredCustomerId(any(), any(), any())).thenReturn(77);

        Customer existing = Customer.builder().type(CustomerType.CUSTOMER).build();
        when(customerRepository.findById(77)).thenReturn(Optional.of(existing));

        Integer result = customerCommandService.registerCustomer(request, false);

        assertThat(result).isEqualTo(77);
        verify(customerRepository, never()).save(any());
    }

    // 3. updateCustomer - 수정 성공 (관리자 권한)
    @Test
    void 고객_수정() {
        int customerId = 1;

        try (MockedStatic<AuthUtil> auth = mockStatic(AuthUtil.class)) {
            auth.when(AuthUtil::isAdmin).thenReturn(true);

            // 기존 고객 mock
            Customer customer = Customer.builder().name("강오돌").phone("01012341234").build();
            when(customerRepository.findById(customerId)).thenReturn(Optional.of(customer));

            // 수정 요청 mock (수정 후 엔티티 반환)
            CustomerUpdateRequest request = mock(CustomerUpdateRequest.class);
            Customer updatedCustomer = Customer.builder().name("강오둘").phone("01043214321").build();
            when(request.toEntity(any())).thenReturn(updatedCustomer);

            customerCommandService.updateCustomer(customerId, request);

            verify(customerRepository).findById(customerId);
        }
    }

    // 4. deleteCustomer - 권한 없음 예외
    @Test
    void 고객_삭제() {
        int customerId = 10;
        int employeeId = 999;

        try (MockedStatic<AuthUtil> auth = mockStatic(AuthUtil.class)) {
            auth.when(AuthUtil::isAdmin).thenReturn(false);
            auth.when(AuthUtil::getEmployeeId).thenReturn(employeeId);

            // 실제 삭제 대상 Customer mock 객체 생성
            Customer customer = Customer.builder().name("삭제될 고객").isDeleted(false).build();

            when(customerRepository.findById(customerId)).thenReturn(Optional.of(customer));

            // 실행
            customerCommandService.deleteCustomer(customerId);

            // soft delete 확인
            assertThat(customer.isDeleted()).isTrue();
            verify(customerRepository).findById(customerId);
        }
    }
}
