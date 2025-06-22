package com.clover.salad.consult.query.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.clover.salad.common.exception.ConsultsException;
import com.clover.salad.common.util.AuthUtil;
import com.clover.salad.consult.query.dto.ConsultQueryDTO;
import com.clover.salad.consult.query.mapper.ConsultMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ConsultQueryServiceImpl implements ConsultQueryService {

    private final ConsultMapper consultMapper;

    /** 전체 상담 목록 조회 - 관리자 전용 */
    @Override
    @Transactional(readOnly = true)
    public List<ConsultQueryDTO> findAll() {
        AuthUtil.assertAdmin();
        return consultMapper.findAll();
    }

    /** 상담 단건 조회 - 관리자 전용 */
    @Override
    @Transactional(readOnly = true)
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
    @Transactional(readOnly = true)
    public List<ConsultQueryDTO> findMyConsults() {
        int employeeId = AuthUtil.getEmployeeId();
        return consultMapper.findConsultsByEmployeeId(employeeId);
    }

    /** 관리자: 특정 사원이 담당하는 상담 목록 조회 */
    @Override
    @Transactional(readOnly = true)
    public List<ConsultQueryDTO> findConsultsByEmployeeId(int employeeId) {
        AuthUtil.assertAdmin();
        return consultMapper.findConsultsByEmployeeId(employeeId);
    }

    /** 로그인한 사원이 담당하는 상담 단건 조회 */
    @Override
    @Transactional(readOnly = true)
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
    @Transactional(readOnly = true)
    public ConsultQueryDTO findConsultByEmployeeAndConsultId(int employeeId, int consultId) {
        AuthUtil.assertAdmin();
        ConsultQueryDTO consult = consultMapper
                .findConsultByEmployeeIdAndConsultIdIncludingDeleted(employeeId, consultId);

        if (consult == null) {
            throw new ConsultsException.ConsultNotFoundException("해당 상담 내역을 조회할 수 없습니다.");
        }

        return consult;
    }
}
