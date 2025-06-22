package com.clover.salad.customer.query.service;

import java.util.List;

import com.clover.salad.customer.query.dto.CustomerQueryDTO;

public interface CustomerQueryService {

    // 관리자: 전체 고객 목록 조회
    List<CustomerQueryDTO> findAll();

    // 관리자: 고객 단건 조회
    CustomerQueryDTO findCustomerById(int customerId);

    // 관리자: 특정 사원이 담당하는 고객 목록 조회
    List<CustomerQueryDTO> findCustomersByEmployeeId(int employeeId);

    // 관리자: 특정 사원이 담당하는 고객 단건 조회
    CustomerQueryDTO findCustomerByEmployeeAndCustomerId(int customerId, int employeeId);

    // 로그인한 사원: 자신의 고객 목록 조회
    List<CustomerQueryDTO> findMyCustomers();

    // 로그인한 사원: 자신의 특정 고객 단건 조회
    CustomerQueryDTO findMyCustomerById(int customerId);

    // 팀장:
    // List<CustomerQueryDTO> findCustomersByDepartment();

    // List<Integer> getCustomerIdsByDepartment(String departmentName);

    // 중복 고객 확인
    Integer findRegisteredCustomerId(String name, String birthdate, String phone);

    // 계약 여부 확인
    boolean existsContractByCustomer(String name, String birthdate, String phone);

    // 상담 여부 확인
    boolean existsConsultByCustomer(String name, String birthdate, String phone);
}
