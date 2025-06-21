package com.clover.salad.customer.command.application.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.clover.salad.customer.command.application.dto.CustomerCreateRequest;
import com.clover.salad.customer.command.application.dto.CustomerUpdateRequest;
import com.clover.salad.customer.command.application.service.CustomerCommandService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/customer")
@RequiredArgsConstructor
public class CustomerCommandController {

	private final CustomerCommandService customerCommandService;

	/** 고객 등록 (중복 시 수정 처리) */
	@PostMapping
	public ResponseEntity<String> registerCustomer(
			@RequestBody @Valid CustomerCreateRequest request) {
		customerCommandService.registerCustomer(request);
		return ResponseEntity.ok(request.getName() + " 고객 정보가 정상 등록되었습니다.");
	}

	// 고객 수정
	@PatchMapping("/{customerId}")
	public ResponseEntity<String> update(@PathVariable int customerId,
			@RequestBody @Valid CustomerUpdateRequest request) {
		customerCommandService.updateCustomer(customerId, request);
		return ResponseEntity.ok("고객 정보가 수정되었습니다.");
	}

	// 고객 삭제
	@DeleteMapping("/{customerId}")
	public ResponseEntity<String> delete(@PathVariable int customerId) {
		customerCommandService.deleteCustomer(customerId);
		return ResponseEntity.ok("고객 정보를 삭제하였습니다.");
	}
}
