package com.clover.salad.consult.query.service;

import java.util.List;

import com.clover.salad.consult.query.dto.ConsultQueryDTO;

public interface ConsultQueryService {

        List<ConsultQueryDTO> searchAll(String consultDateFrom, String consultDateTo,
                        String content, String customerName, Double minScore, Double maxScore);

        List<ConsultQueryDTO> searchMyConsults(String consultDateFrom, String consultDateTo,
                        String content, String customerName, Double minScore, Double maxScore);

        // 관리자: 전체 고객 목록 조회
        List<ConsultQueryDTO> findAll();

        // 관리자: 고객 단건 조회
        ConsultQueryDTO findConsultById(int consultId);

        // 관리자: 특정 사원이 담당하는 고객 목록 조회
        List<ConsultQueryDTO> findConsultsByEmployeeId(int employeeId);

        // 관리자: 특정 사원이 담당하는 고객 단건 조회
        ConsultQueryDTO findConsultByEmployeeAndConsultId(int employeeId, int consultId);

        // 로그인한 사원: 자신의 고객 목록 조회
        List<ConsultQueryDTO> findMyConsults();

        // 로그인한 사원: 자신의 특정 고객 단건 조회
        ConsultQueryDTO findMyConsultById(int consultId);

        // 고객 ID로 상담 목록 조회
        List<ConsultQueryDTO> findConsultsByCustomerId(int customerId);

        // 사원 ID로 담당 고객 ID 목록 조회
        List<Integer> findCustomerIdsByEmployeeId(int employeeId);

        // 권한 미체크 - 특정 사원의 전체 상담 내역 조회
        List<ConsultQueryDTO> findCurrentOnly(int employeeId);
}
