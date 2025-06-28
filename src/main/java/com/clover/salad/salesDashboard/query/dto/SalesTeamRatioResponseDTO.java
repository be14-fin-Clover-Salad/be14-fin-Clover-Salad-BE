package com.clover.salad.salesDashboard.query.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SalesTeamRatioResponseDTO {
	private String teamName;
	private int teamAmount;
	private double ratio;
}
