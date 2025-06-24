package com.clover.salad.notification.command.application.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.clover.salad.notification.command.application.dto.NotificationDeleteRequestDTO;
import com.clover.salad.notification.command.application.service.NotificationCommandService;
import com.clover.salad.security.SecurityUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/notification")
public class NotificationCommandController {

	private final NotificationCommandService notificationCommandService;

	@Autowired
	public NotificationCommandController(NotificationCommandService notificationCommandService) {
		this.notificationCommandService = notificationCommandService;
	}

	@PatchMapping("/{id}/read")
	public ResponseEntity<String> markAsRead(@PathVariable("id") int id) {
		notificationCommandService.markAsRead(id);
		return ResponseEntity.ok("알림을 읽었습니다.");
	}

	@Transactional
	@PatchMapping("/delete")
	public ResponseEntity<String> softDeleteNotifications(@RequestBody NotificationDeleteRequestDTO dto) {
		notificationCommandService.softDeleteNotifications(dto.getDeleteNotification());
		return ResponseEntity.ok("선택된 알림이 삭제되었습니다.");
	}

	@PatchMapping("/read")
	public ResponseEntity<String> markMultipleAsRead(@RequestBody List<Integer> notificationIds) {
		notificationCommandService.markMultipleAsRead(notificationIds);
		return ResponseEntity.ok("모든 알림을 읽음 처리했습니다.");
	}
}
