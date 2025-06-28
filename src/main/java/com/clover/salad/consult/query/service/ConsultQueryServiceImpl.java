package com.clover.salad.consult.query.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.clover.salad.common.exception.ConsultsException;
import com.clover.salad.common.util.AuthUtil;
import com.clover.salad.consult.query.dto.ConsultQueryDTO;
import com.clover.salad.consult.query.mapper.ConsultMapper;
import com.clover.salad.security.JwtUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ConsultQueryServiceImpl implements ConsultQueryService {

    private final ConsultMapper consultMapper;
    private final JwtUtil jwtUtil;

    @Override
    public List<ConsultQueryDTO> searchAll(String consultDateFrom, String consultDateTo,
            String content, String customerName, Double minScore, Double maxScore) {
        return consultMapper.searchAll(consultDateFrom, consultDateTo, content, customerName,
                minScore, maxScore);
    }

    @Override
    public List<ConsultQueryDTO> searchMyConsults(String consultDateFrom, String consultDateTo,
            String content, String customerName, Double minScore, Double maxScore) {
        String token = AuthUtil.resolveToken();
        if (token == null) {
            throw new IllegalStateException("Authorization 토큰을 찾을 수 없습니다.");
        }
        int employeeId = jwtUtil.getEmployeeId(token);
        return consultMapper.searchMyConsults(employeeId, consultDateFrom, consultDateTo, content,
                customerName, minScore, maxScore);
    }

    /** 전체 상담 목록 조회 - 관리자 전용 */
    @Override
    public List<ConsultQueryDTO> findAll() {
        AuthUtil.assertAdmin();
        return consultMapper.findAll();
    }

    /** 상담 단건 조회 - 관리자 전용 */
    @Override
    public ConsultQueryDTO findConsultById(int consultId) {
        AuthUtil.assertAdmin();
        ConsultQueryDTO consult = consultMapper.findConsultByIdIncludingDeleted(consultId);

        if (consult == null) {
            throw new ConsultsException.ConsultNotFoundException("해당 상담 내역을 조회할 수 없습니다.");
        }

        return consult;
    }

    /** 로그인한 사원이 담당하는 상담 목록 조회 */
    @Override
    public List<ConsultQueryDTO> findMyConsults() {
        String token = AuthUtil.resolveToken();
        if (token == null) {
            throw new IllegalStateException("Authorization 토큰을 찾을 수 없습니다.");
        }
        int employeeId = jwtUtil.getEmployeeId(token);
        return consultMapper.findConsultsByEmployeeId(employeeId);
    }

    /** 관리자: 특정 사원이 담당하는 상담 목록 조회 */
    @Override
    public List<ConsultQueryDTO> findConsultsByEmployeeId(int employeeId) {
        AuthUtil.assertAdmin();
        return consultMapper.findConsultsByEmployeeId(employeeId);
    }

    /** 로그인한 사원이 담당하는 상담 단건 조회 */
    @Override
    public ConsultQueryDTO findMyConsultById(int consultId) {
        int employeeId = AuthUtil.getEmployeeId();
        ConsultQueryDTO consult =
                consultMapper.findConsultByEmployeeIdAndConsultId(employeeId, consultId);

        if (consult == null) {
            throw new ConsultsException.ConsultNotFoundException("해당 상담 내역을 조회할 수 없습니다.");
        }

        return consult;
    }

    /** 관리자: 특정 사원이 담당하는 상담 단건 조회 */
    @Override
    public ConsultQueryDTO findConsultByEmployeeAndConsultId(int employeeId, int consultId) {
        AuthUtil.assertAdmin();
        ConsultQueryDTO consult = consultMapper
                .findConsultByEmployeeIdAndConsultIdIncludingDeleted(employeeId, consultId);

        if (consult == null) {
            throw new ConsultsException.ConsultNotFoundException("해당 상담 내역을 조회할 수 없습니다.");
        }

        return consult;
    }

    @Override
    public List<ConsultQueryDTO> findConsultsByCustomerId(int customerId) {
        return consultMapper.findConsultsByCustomerId(customerId);
    }

    @Override
    public List<Integer> findCustomerIdsByEmployeeId(int employeeId) {
        return consultMapper.findCustomerIdsByEmployeeId(employeeId);
    }


    @Override
    @Transactional(readOnly = true)
    public List<ConsultQueryDTO> findCurrentOnly(int employeeId) {
        return consultMapper.findConsultsByEmployeeId(employeeId);
    }
}
