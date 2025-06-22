package com.clover.salad.customer.command.domain.aggregate.vo;

import com.fasterxml.jackson.annotation.JsonCreator;

public enum CustomerType {

	CUSTOMER("고객"), PROSPECT("리드");

	private final String label;

	CustomerType(String label) {
		this.label = label;
	}

	public String getLabel() {
		return label;
	}

	@JsonCreator(mode = JsonCreator.Mode.DELEGATING)
	public static CustomerType from(String input) {
		if (input == null) {
			return null;
		}

		// 먼저 enum 상수명으로 직접 매칭 시도
		try {
			return CustomerType.valueOf(input);
		} catch (IllegalArgumentException e) {
			// enum 상수명이 아니면 label로 매칭 시도
			for (CustomerType type : values()) {
				if (type.getLabel().equals(input)) {
					return type;
				}
			}
			throw new IllegalArgumentException("고객 유형은 '고객' 또는 '리드'만 가능합니다.");
		}
	}
}
