package com.clover.salad.customer.query.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.clover.salad.common.exception.CustomersException;
import com.clover.salad.common.util.AuthUtil;
import com.clover.salad.customer.query.dto.CustomerQueryDTO;
import com.clover.salad.customer.query.service.CustomerQueryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/customer")
public class CustomerQueryController {

    private final CustomerQueryService customerQueryService;

    /** 전체 고객 목록 조회 (관리자 권한 필요) */
    @GetMapping
    public ResponseEntity<List<CustomerQueryDTO>> findAll() {
        return ResponseEntity.ok(customerQueryService.findAll());
    }

    /** 고객 단건 조회 (관리자 권한 필요) */
    @GetMapping("/{customerId}")
    public ResponseEntity<CustomerQueryDTO> findCustomerById(@PathVariable int customerId) {
        return ResponseEntity.ok(customerQueryService.findCustomerById(customerId));
    }

    /** 로그인한 사원이 담당하는 고객 목록 조회 */
    @GetMapping("/my")
    public ResponseEntity<List<CustomerQueryDTO>> getMyCustomers() {
        return ResponseEntity.ok(customerQueryService.findMyCustomers());
    }

    /** 로그인한 사원이 담당하는 고객 단건 조회 */
    @GetMapping("/my/{customerId}")
    public ResponseEntity<?> getMyCustomerById(@PathVariable int customerId) {
        int employeeId = AuthUtil.getEmployeeId();
        try {
            CustomerQueryDTO customer = customerQueryService
                    .findCustomerByEmployeeAndCustomerId(customerId, employeeId);
            return ResponseEntity.ok(customer);
        } catch (CustomersException.CustomerAccessDeniedException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch (CustomersException.CustomerNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }

    /** 특정 사원(employeeId)이 담당하는 고객 목록 조회 (관리자만 사용) */
    @GetMapping("/employee/{employeeId}")
    public ResponseEntity<?> getCustomersByEmployeeId(@PathVariable int employeeId) {
        try {
            List<CustomerQueryDTO> customers =
                    customerQueryService.findCustomersByEmployeeId(employeeId);
            return ResponseEntity.ok(customers);
        } catch (CustomersException.CustomerAccessDeniedException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch (CustomersException.CustomerNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }

    /** 특정 사원(employeeId)이 담당하는 고객 단건 조회 (관리자만 사용) */
    @GetMapping("/employee/{employeeId}/customer/{customerId}")
    public ResponseEntity<?> findCustomerByEmployeeAndCustomerId(@PathVariable int employeeId,
            @PathVariable int customerId) {
        try {
            CustomerQueryDTO customer = customerQueryService
                    .findCustomerByEmployeeAndCustomerId(customerId, employeeId);
            return ResponseEntity.ok(customer);
        } catch (CustomersException.CustomerAccessDeniedException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch (CustomersException.CustomerNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }

    /** 특정 고객의 상담 내역 조회 */
    @GetMapping("/{customerId}/consults")
    public ResponseEntity<?> getConsultsByCustomerId(@PathVariable int customerId) {
        return ResponseEntity.ok(customerQueryService.findConsultsByCustomerId(customerId));
    }

    /** 로그인한 팀장의 부서 전체 고객 목록 조회 -- 계약 쪽 수정 필요하므로 보류 처리 */
    // @GetMapping("/department")
    // public ResponseEntity<?> getCustomersByDepartment() {
    // try {
    // List<CustomerQueryDTO> customers = customerQueryService.findCustomersByDepartment();
    // return ResponseEntity.ok(customers);
    // } catch (CustomersException.CustomerAccessDeniedException ex) {
    // return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
    // } catch (CustomersException.CustomerNotFoundException ex) {
    // return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
    // }
    // }

}
