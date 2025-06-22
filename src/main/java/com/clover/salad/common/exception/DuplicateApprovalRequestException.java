package com.clover.salad.common.exception;

public class DuplicateApprovalRequestException extends RuntimeException {
	public DuplicateApprovalRequestException() {
		super("결재가 반려된 경우가 아니라면 중복 결재 요청이 불가능합니다.");
	}

}
