package com.clover.salad.consult.query.service;

import com.clover.salad.common.exception.ConsultsException;
import com.clover.salad.common.util.AuthUtil;
import com.clover.salad.consult.query.dto.ConsultQueryDTO;
import com.clover.salad.consult.query.mapper.ConsultMapper;
import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.security.JwtUtil;
import com.clover.salad.security.SecurityUtil;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ConsultQueryServiceImplTest {

    @Mock
    private ConsultMapper consultMapper;

    @Mock
    private JwtUtil jwtUtil;

    @Mock
    private EmployeeQueryService employeeQueryService;

    @InjectMocks
    private ConsultQueryServiceImpl consultQueryService;

    // 1. findAll()
    @Test
    void 상담_전체_조회() {
        try (MockedStatic<AuthUtil> mockedAuth = mockStatic(AuthUtil.class)) {
            List<ConsultQueryDTO> mockList = List.of(new ConsultQueryDTO());
            when(consultMapper.findAll()).thenReturn(mockList);

            List<ConsultQueryDTO> result = consultQueryService.findAll();

            assertThat(result).isNotEmpty();
            verify(consultMapper).findAll();
        }
    }

    // 2. findConsultById()
    @Test
    void 상담_단건_조회() {
        try (MockedStatic<AuthUtil> mockedAuth = mockStatic(AuthUtil.class)) {
            int consultId = 1;
            ConsultQueryDTO mockDto = new ConsultQueryDTO();
            when(consultMapper.findConsultByIdIncludingDeleted(consultId)).thenReturn(mockDto);

            ConsultQueryDTO result = consultQueryService.findConsultById(consultId);

            assertThat(result).isNotNull();
            verify(consultMapper).findConsultByIdIncludingDeleted(consultId);
        }
    }

    @Test
    void 상담_단건_조회_내역_없음() {
        try (MockedStatic<AuthUtil> mockedAuth = mockStatic(AuthUtil.class)) {
            int consultId = 999;
            when(consultMapper.findConsultByIdIncludingDeleted(consultId)).thenReturn(null);

            assertThatThrownBy(() -> consultQueryService.findConsultById(consultId))
                    .isInstanceOf(ConsultsException.ConsultNotFoundException.class);
        }
    }

    // 3. findMyConsultById()
    @Test
    void 내_상담_조회() {
        int consultId = 10;
        int employeeId = 5;

        try (MockedStatic<AuthUtil> mockedAuth = mockStatic(AuthUtil.class)) {
            mockedAuth.when(AuthUtil::getEmployeeId).thenReturn(employeeId);

            ConsultQueryDTO dto = new ConsultQueryDTO();
            when(consultMapper.findConsultByEmployeeIdAndConsultId(employeeId, consultId))
                    .thenReturn(dto);

            ConsultQueryDTO result = consultQueryService.findMyConsultById(consultId);

            assertThat(result).isNotNull();
            verify(consultMapper).findConsultByEmployeeIdAndConsultId(employeeId, consultId);
        }
    }

    // 5. searchMyConsults()
    @Test
    void 상담_검색() {
        String token = "valid.token.value";
        int employeeId = 7;

        try (MockedStatic<AuthUtil> mockedAuth = mockStatic(AuthUtil.class)) {
            mockedAuth.when(AuthUtil::resolveToken).thenReturn(token);
            when(jwtUtil.getEmployeeId(token)).thenReturn(employeeId);

            when(consultMapper.searchMyConsults(eq(employeeId), any(), any(), any(), any(), any(),
                    any())).thenReturn(List.of(new ConsultQueryDTO()));

            List<ConsultQueryDTO> result = consultQueryService.searchMyConsults("2024-01-01",
                    "2024-12-31", "상담", "강수지", 1.0, 4.5);

            assertThat(result).isNotEmpty();
            verify(consultMapper).searchMyConsults(eq(employeeId), any(), any(), any(), any(),
                    any(), any());
        }
    }
}
