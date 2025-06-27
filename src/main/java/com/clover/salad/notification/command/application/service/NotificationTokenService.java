package com.clover.salad.notification.command.application.service;

public interface NotificationTokenService {
	String issueToken(int employeeId);
	Integer resolveEmployeeId(String token);
}
