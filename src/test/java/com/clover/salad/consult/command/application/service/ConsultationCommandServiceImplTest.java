package com.clover.salad.consult.command.application.service;

import com.clover.salad.common.util.AuthUtil;
import com.clover.salad.consult.command.application.dto.ConsultationCreateRequest;
import com.clover.salad.consult.command.application.dto.ConsultationUpdateRequest;
import com.clover.salad.consult.command.domain.aggregate.entity.Consultation;
import com.clover.salad.consult.command.domain.repository.ConsultationRepository;
import com.clover.salad.customer.command.application.dto.CustomerCreateRequest;
import com.clover.salad.customer.command.application.service.CustomerCommandService;
import com.clover.salad.customer.command.domain.aggregate.entity.Customer;
import com.clover.salad.customer.command.domain.repository.CustomerRepository;
import com.clover.salad.security.JwtUtil;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;

import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class ConsultationCommandServiceImplTest {

        @Mock
        private ConsultationRepository consultationRepository;

        @Mock
        private CustomerCommandService customerCommandService;

        @Mock
        private CustomerRepository customerRepository;

        @Mock
        private JwtUtil jwtUtil;

        @InjectMocks
        private ConsultationCommandServiceImpl consultationCommandService;

        // 1. createConsultation - 정상 케이스
        @Test
        void 상담_생성_성공() {
                String token = "mock.token";
                int employeeId = 1;
                int customerId = 10;

                try (MockedStatic<AuthUtil> authMock = mockStatic(AuthUtil.class)) {
                        authMock.when(AuthUtil::resolveToken).thenReturn(token);
                        when(jwtUtil.getEmployeeId(token)).thenReturn(employeeId);

                        ConsultationCreateRequest request = mock(ConsultationCreateRequest.class);
                        when(request.getCustomerName()).thenReturn("홍길동");
                        when(request.getCustomerPhone()).thenReturn("01012345678");
                        when(request.toSanitizedCustomerCreateRequest())
                                        .thenReturn(new CustomerCreateRequest());
                        when(request.getContent()).thenReturn("상담 내용");
                        when(request.getEtc()).thenReturn("비고");
                        when(customerCommandService.registerCustomer(any(), eq(true)))
                                        .thenReturn(customerId);

                        consultationCommandService.createConsultation(request);

                        verify(consultationRepository).save(any(Consultation.class));
                }
        }

        // 2. createConsultation - 고객 이름 or 연락처 누락
        @Test
        void 상담_생성_이름_연락처_누락() {
                ConsultationCreateRequest request = mock(ConsultationCreateRequest.class);
                when(request.getCustomerName()).thenReturn("");
                when(request.getCustomerPhone()).thenReturn(null);

                assertThatThrownBy(() -> consultationCommandService.createConsultation(request))
                                .isInstanceOf(IllegalArgumentException.class)
                                .hasMessageContaining("고객 이름과 연락처는 반드시 입력해야 합니다.");
        }

        // 3. updateConsultation - 정상 업데이트
        @Test
        void 상담_수정_성공() {
                int consultId = 5;
                int customerId = 10;

                Consultation consultation = Consultation.builder().customerId(customerId)
                                .content("이전 내용").etc("이전 비고").build();

                Customer customer = Customer.builder().id(customerId).name("홍길동").build();

                when(consultationRepository.findByIdAndIsDeletedFalse(consultId))
                                .thenReturn(Optional.of(consultation));
                when(customerRepository.findById(customerId)).thenReturn(Optional.of(customer));

                ConsultationUpdateRequest request = mock(ConsultationUpdateRequest.class);
                when(request.getContent()).thenReturn("수정된 상담");
                when(request.getEtc()).thenReturn("수정된 비고");
                when(request.getCustomerName()).thenReturn("김철수");
                when(request.getCustomerPhone()).thenReturn("01000000000");
                when(request.getCustomerBirthdate()).thenReturn("19900101");
                when(request.getCustomerEmail()).thenReturn("test@test.com");
                when(request.getCustomerAddress()).thenReturn("서울시 강남구");
                when(request.getCustomerType()).thenReturn(null);
                when(request.getCustomerEtc()).thenReturn("고객 비고");

                consultationCommandService.updateConsultation(consultId, request);

                verify(consultationRepository).findByIdAndIsDeletedFalse(consultId);
                verify(customerRepository).findById(customerId);
        }

        // 4. updateConsultation - 상담이 없을 경우 예외
        @Test
        void 상담_수정_내역_없음() {
                int consultId = 999;
                when(consultationRepository.findByIdAndIsDeletedFalse(consultId))
                                .thenReturn(Optional.empty());

                ConsultationUpdateRequest request = mock(ConsultationUpdateRequest.class);

                assertThatThrownBy(() -> consultationCommandService.updateConsultation(consultId,
                                request)).isInstanceOf(IllegalArgumentException.class)
                                                .hasMessageContaining("삭제되었거나 존재하지 않는 상담입니다.");
        }

        // 6. deleteConsultation - 삭제 대상 없음
        @Test
        void 상담_삭제_내역_없음() {
                int consultId = 999;
                when(consultationRepository.findByIdAndIsDeletedFalse(consultId))
                                .thenReturn(Optional.empty());

                assertThatThrownBy(() -> consultationCommandService.deleteConsultation(consultId))
                                .isInstanceOf(IllegalArgumentException.class)
                                .hasMessageContaining("삭제되었거나 존재하지 않는 상담입니다.");
        }
}
