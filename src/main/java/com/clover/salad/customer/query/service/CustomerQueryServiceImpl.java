package com.clover.salad.customer.query.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.clover.salad.common.exception.CustomersException;
import com.clover.salad.common.util.AuthUtil;
import com.clover.salad.contract.query.service.ContractService;
import com.clover.salad.customer.query.dto.CustomerQueryDTO;
import com.clover.salad.customer.query.mapper.CustomerMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomerQueryServiceImpl implements CustomerQueryService {

    private final CustomerMapper customerMapper;
    private final ContractService contractService;

    /** 전체 고객 목록 조회 - 관리자 전용 */
    @Override
    @Transactional(readOnly = true)
    public List<CustomerQueryDTO> findAll() {
        AuthUtil.assertAdmin();
        return customerMapper.findAll();
    }

    /** 고객 단건 조회 - 관리자 전용 */
    @Override
    @Transactional(readOnly = true)
    public CustomerQueryDTO findCustomerById(int customerId) {
        AuthUtil.assertAdmin();
        return customerMapper.findCustomerById(customerId);
    }

    /** 로그인한 사원이 담당하는 고객 목록 조회 */
    @Override
    @Transactional(readOnly = true)
    public List<CustomerQueryDTO> findMyCustomers() {
        int employeeId = AuthUtil.getEmployeeId();
        return getCustomersByEmployeeId(employeeId, true);
    }

    /** 관리자: 특정 사원이 담당하는 고객 목록 조회 */
    @Override
    @Transactional(readOnly = true)
    public List<CustomerQueryDTO> findCustomersByEmployeeId(int employeeId) {
        return getCustomersByEmployeeId(employeeId, false);
    }

    /** 내부 공통 로직 - 고객 목록 조회 */
    private List<CustomerQueryDTO> getCustomersByEmployeeId(int employeeId, boolean isSelf) {
        int loginEmployeeId = AuthUtil.getEmployeeId();
        if (AuthUtil.isMember() && !isSelf && loginEmployeeId != employeeId) {
            throw new CustomersException.CustomerAccessDeniedException(
                    "사원은 본인이 담당하는 고객 정보만 조회할 수 있습니다.");
        }

        List<Integer> customerIds = contractService.getCustomerIdsByEmployee(employeeId);
        if (customerIds == null || customerIds.isEmpty()) {
            throw new CustomersException.CustomerNotFoundException("해당 사원이 담당하는 고객이 없습니다.");
        }

        return customerMapper.findCustomersByIds(customerIds);
    }

    /** 로그인한 사원이 담당하는 고객 단건 조회 */
    @Override
    @Transactional(readOnly = true)
    public CustomerQueryDTO findMyCustomerById(int customerId) {
        int employeeId = AuthUtil.getEmployeeId();
        return findCustomerByEmployeeAndCustomerId(customerId, employeeId, true);
    }

    /** 관리자: 특정 사원이 담당하는 고객 단건 조회 */
    @Override
    @Transactional(readOnly = true)
    public CustomerQueryDTO findCustomerByEmployeeAndCustomerId(int customerId, int employeeId) {
        return findCustomerByEmployeeAndCustomerId(customerId, employeeId, false);
    }

    /** 내부 공통 로직 - 고객 단건 조회 */
    private CustomerQueryDTO findCustomerByEmployeeAndCustomerId(int customerId, int employeeId,
            boolean isSelf) {
        int loginEmployeeId = AuthUtil.getEmployeeId();

        // 삭제 여부 조건 분기
        CustomerQueryDTO customer = AuthUtil.isAdmin() ? customerMapper.findCustomerById(customerId)
                : customerMapper.findCustomerByIdExcludingDeleted(customerId);

        if (customer == null) {
            throw new CustomersException.CustomerNotFoundException("해당 고객을 조회할 수 없습니다.");
        }

        if (AuthUtil.isMember() && !isSelf && loginEmployeeId != employeeId) {
            throw new CustomersException.CustomerAccessDeniedException("해당 고객은 요청한 사원의 담당이 아닙니다.");
        }

        List<Integer> customerIds = contractService.getCustomerIdsByEmployee(employeeId);
        if (customerIds == null || !customerIds.contains(customerId)) {
            throw new CustomersException.CustomerAccessDeniedException("해당 고객은 요청한 사원의 담당이 아닙니다.");
        }

        return customer;
    }

    // @Override
    // @Transactional(readOnly = true)
    // public List<CustomerQueryDTO> findCustomersByDepartment() {
    // if (!AuthUtil.isManager()) {
    // throw new CustomersException.CustomerAccessDeniedException("팀장만 부서 전체 고객 조회가 가능합니다.");
    // }

    // String departmentName = AuthUtil.getDepartmentName();
    // List<Integer> customerIds = contractService.getCustomerIdsByDepartment(departmentName);

    // if (customerIds == null || customerIds.isEmpty()) {
    // throw new CustomersException.CustomerNotFoundException("해당 부서의 고객이 존재하지 않습니다.");
    // }

    // return customerMapper.findCustomersByIds(customerIds);
    // }

    /** 중복 고객 조회 (이름 + 생년월일 + 전화번호) */
    @Override
    @Transactional(readOnly = true)
    public Integer findRegisteredCustomerId(String customerName, String customerBirthdate,
            String customerPhone) {
        return customerMapper.findRegisteredCustomerId(customerName, customerBirthdate,
                customerPhone);
    }

    /** 계약 여부 확인 */
    @Override
    @Transactional(readOnly = true)
    public boolean existsContractByCustomer(String name, String birthdate, String phone) {
        return customerMapper.existsContractByCustomer(name, birthdate, phone);
    }

    /** 상담 여부 확인 */
    @Override
    @Transactional(readOnly = true)
    public boolean existsConsultByCustomer(String name, String birthdate, String phone) {
        return customerMapper.existsConsultByCustomer(name, birthdate, phone);
    }
}
