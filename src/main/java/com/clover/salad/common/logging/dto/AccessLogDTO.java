package com.clover.salad.common.logging.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AccessLogDTO {
	private String time;
	private String user;
	private String ip;
	private String method;
	private String uri;
	private String userAgent;
}
