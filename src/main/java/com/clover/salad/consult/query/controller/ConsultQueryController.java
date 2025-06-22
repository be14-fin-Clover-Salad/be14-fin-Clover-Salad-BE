package com.clover.salad.consult.query.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
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

    /** 🔐 관리자: 전체 상담 목록 조회 */
    @GetMapping
    public ResponseEntity<List<ConsultQueryDTO>> findAll() {
        return ResponseEntity.ok(consultService.findAll());
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
