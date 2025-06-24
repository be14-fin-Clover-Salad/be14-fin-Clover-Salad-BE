package com.clover.salad.notification.query.controller;

import com.clover.salad.notification.command.application.service.NotificationCommandService;
import com.clover.salad.notification.query.dto.NotificationDropdownResponseDTO;
import com.clover.salad.notification.query.dto.NotificationListResponseDTO;
import com.clover.salad.notification.query.service.NotificationQueryService;
import com.clover.salad.security.SecurityUtil;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/notification")
public class NotificationQueryController {

	private final NotificationQueryService notificationQueryService;
	private final NotificationCommandService notificationCommandService;

	@Autowired
	public NotificationQueryController(NotificationQueryService notificationQueryService,
		NotificationCommandService notificationCommandService) {
		this.notificationQueryService = notificationQueryService;
		this.notificationCommandService = notificationCommandService;
	}

	/* 설명. 알림 드롭다운 조회 */
	@GetMapping("/unread-latest")
	public ResponseEntity<List<NotificationDropdownResponseDTO>> getUnreadDropdown() {
		List<NotificationDropdownResponseDTO> notifications = notificationQueryService.getUnreadTop5();
		return ResponseEntity.ok(notifications);
	}

	/* 설명. 알림 목록 조회 */
	@GetMapping("/list")
	public ResponseEntity<List<NotificationListResponseDTO>> getAllNotifications(
		@RequestParam(defaultValue = "0") int page
	) {
		List<NotificationListResponseDTO> notifications = notificationQueryService.getAllNotifications(page);
		return ResponseEntity.ok(notifications);
	}
}
