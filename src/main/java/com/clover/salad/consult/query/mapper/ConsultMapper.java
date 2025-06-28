package com.clover.salad.consult.query.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.clover.salad.consult.query.dto.ConsultQueryDTO;

@Mapper
public interface ConsultMapper {

        /** 전체 상담 목록 (관리자용, 삭제 포함) */
        List<ConsultQueryDTO> findAll();

        // 팀장용 상담 내역 조회
        List<ConsultQueryDTO> findConsultsByDepartmentId(@Param("departmentId") int departmentId);

        /** 특정 상담 ID 기준 단건 조회 (관리자용, 삭제 포함) */
        ConsultQueryDTO findConsultById(@Param("id") int id);

        /** 특정 상담 ID 기준 단건 조회 (관리자용, 삭제 포함) */
        ConsultQueryDTO findConsultByIdIncludingDeleted(@Param("id") int id);

        /** 특정 상담 ID 기준 단건 조회 (사원용, 삭제 제외) */
        ConsultQueryDTO findConsultByIdExcludingDeleted(@Param("id") int id);

        /** 사번(employeeId) 기준 전체 상담 목록 조회 */
        List<ConsultQueryDTO> findConsultsByEmployeeId(@Param("employeeId") int employeeId);

        /** 사번 + 상담 ID 기준 단건 조회 (선택적으로 사용할 경우) */
        ConsultQueryDTO findConsultByEmployeeIdAndConsultId(@Param("employeeId") int employeeId,
                        @Param("consultId") int consultId);

        /** 사번 + 상담 ID 기준 단건 조회 (관리자용, 삭제 포함) */
        ConsultQueryDTO findConsultByEmployeeIdAndConsultIdIncludingDeleted(
                        @Param("employeeId") int employeeId, @Param("consultId") int consultId);

        /** 고객 ID 기준 전체 상담 목록 조회 */
        List<ConsultQueryDTO> findConsultsByCustomerId(@Param("customerId") int customerId);

        /** 사번(employeeId) 기준 고객 ID 목록 조회 */
        List<Integer> findCustomerIdsByEmployeeId(@Param("employeeId") int employeeId);

        List<ConsultQueryDTO> searchAll(@Param("consultDateFrom") String consultDateFrom,
                        @Param("consultDateTo") String consultDateTo,
                        @Param("content") String content,
                        @Param("customerName") String customerName,
                        @Param("minScore") Double minScore, @Param("maxScore") Double maxScore);

        List<ConsultQueryDTO> searchMyConsults(@Param("employeeId") int employeeId,
                        @Param("consultDateFrom") String consultDateFrom,
                        @Param("consultDateTo") String consultDateTo,
                        @Param("content") String content,
                        @Param("customerName") String customerName,
                        @Param("minScore") Double minScore, @Param("maxScore") Double maxScore);
}
