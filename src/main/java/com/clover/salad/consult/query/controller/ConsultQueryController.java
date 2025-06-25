package com.clover.salad.consult.query.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.clover.salad.common.exception.ConsultsException;
import com.clover.salad.consult.query.dto.ConsultQueryDTO;
import com.clover.salad.consult.query.service.ConsultQueryService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/consult")
@RequiredArgsConstructor
public class ConsultQueryController {

    private final ConsultQueryService consultService;
    private static final Logger log = LoggerFactory.getLogger(ConsultQueryController.class);

    /** 🔐 관리자: 전체 상담 목록 조회 */
    @GetMapping
    public ResponseEntity<List<ConsultQueryDTO>> search(
            @RequestParam(required = false) String consultDateFrom,
            @RequestParam(required = false) String consultDateTo,
            @RequestParam(required = false) String content,
            @RequestParam(required = false) String customerName,
            @RequestParam(required = false) Double minScore,
            @RequestParam(required = false) Double maxScore,
            @RequestParam(required = false) Long departmentId,
            @RequestParam(required = false) String departmentName) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        List<String> roles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority).toList();

        List<ConsultQueryDTO> consults;
        if (roles.contains("ROLE_ADMIN")) {
            log.info("[Consult] ROLE_ADMIN 분기 진입");
            consults = consultService.searchAll(consultDateFrom, consultDateTo, content,
                    customerName, minScore, maxScore, departmentId, departmentName);
        } else if (roles.contains("ROLE_MANAGER")) {
            int managerId = Integer.parseInt(authentication.getName());
            log.info("[Consult] ROLE_MANAGER 분기 진입, managerId={}", managerId);
            consults = consultService.findConsultsByManagerId(managerId);
        } else {
            log.info("[Consult] ROLE_EMPLOYEE 분기 진입");
            consults = consultService.searchMyConsults(consultDateFrom, consultDateTo, content,
                    customerName, minScore, maxScore);
        }
        return ResponseEntity.ok(consults);
    }

    /** 🔐 관리자: 상담 단건 조회 */
    @GetMapping("/{consultId}")
    public ResponseEntity<?> findById(@PathVariable int consultId) {
        try {
            return ResponseEntity.ok(consultService.findConsultById(consultId));
        } catch (ConsultsException.ConsultAccessDeniedException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("관리자만 접근할 수 있습니다.");
        } catch (ConsultsException.ConsultNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }

    /** 👤 로그인한 사원: 본인 상담 목록 조회 */
    @GetMapping("/my")
    public ResponseEntity<List<ConsultQueryDTO>> findMyConsults() {
        return ResponseEntity.ok(consultService.findMyConsults());
    }

    /** 👤 로그인한 사원: 본인 상담 단건 조회 */
    @GetMapping("/my/{consultId}")
    public ResponseEntity<?> findMyConsultById(@PathVariable int consultId) {
        try {
            return ResponseEntity.ok(consultService.findMyConsultById(consultId));
        } catch (ConsultsException.ConsultAccessDeniedException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch (ConsultsException.ConsultNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }

    /** 🔐 관리자: 특정 사원의 상담 목록 조회 */
    @GetMapping("/employee/{employeeId}")
    public ResponseEntity<?> findConsultsByEmployeeId(@PathVariable int employeeId) {
        try {
            return ResponseEntity.ok(consultService.findConsultsByEmployeeId(employeeId));
        } catch (ConsultsException.ConsultAccessDeniedException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch (ConsultsException.ConsultNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }

    /** 🔐 관리자: 특정 사원의 상담 단건 조회 */
    @GetMapping("/employee/{employeeId}/consult/{consultId}")
    public ResponseEntity<?> findConsultByEmployeeAndConsultId(@PathVariable int employeeId,
            @PathVariable int consultId) {
        try {
            return ResponseEntity
                    .ok(consultService.findConsultByEmployeeAndConsultId(employeeId, consultId));
        } catch (ConsultsException.ConsultAccessDeniedException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch (ConsultsException.ConsultNotFoundException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        }
    }
}
