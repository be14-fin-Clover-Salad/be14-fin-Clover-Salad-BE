package com.clover.salad.consult.query.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.clover.salad.consult.query.dto.ConsultQueryDTO;

@Mapper
public interface ConsultMapper {

        /** 전체 상담 목록 (관리자용, 삭제 포함) */
        List<ConsultQueryDTO> findAll();

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
}
