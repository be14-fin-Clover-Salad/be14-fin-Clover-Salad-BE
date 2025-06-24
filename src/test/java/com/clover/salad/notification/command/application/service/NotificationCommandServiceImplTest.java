package com.clover.salad.notification.command.application.service;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.notification.command.application.dto.NotificationCreateDTO;
import com.clover.salad.notification.command.domain.aggregate.entity.NotificationEntity;
import com.clover.salad.notification.command.domain.aggregate.enums.NotificationType;
import com.clover.salad.notification.command.domain.repository.NotificationRepository;
import com.clover.salad.notification.query.sse.SseEmitterManager;
import com.clover.salad.security.SecurityUtil;

@ExtendWith(MockitoExtension.class)
class NotificationCommandServiceImplTest {

	@Mock
	private NotificationRepository notificationRepository;

	@Mock
	private SseEmitterManager sseEmitterManager;

	@InjectMocks
	private NotificationCommandServiceImpl notificationCommandService;

	@Test
	public void 알림_생성_후_SSE로_전송() {

		// given
		NotificationCreateDTO notificationCreateDTO = NotificationCreateDTO.builder()
			.type(NotificationType.APPROVAL)
			.content("결재 요청이 도착했습니다.")
			.url("/approval/123")
			.employeeId(1)
			.build();

		when(notificationRepository.save(any(NotificationEntity.class)))
			.thenAnswer(invocation -> invocation.getArgument(0));

		// when
		notificationCommandService.createNotification(notificationCreateDTO);

		// then
		verify(notificationRepository, times(1)).save(any(NotificationEntity.class));
		verify(sseEmitterManager, times(1)).send(eq(1), eq(notificationCreateDTO));
	}

	@Test
	public void 알림_일음_처리() {

		// given
		NotificationEntity notificationEntity = NotificationEntity.builder()
			.id(1)
			.employeeId(100)
			.type(NotificationType.APPROVAL)
			.content("내용")
			.url("/test")
			.createdAt(LocalDateTime.now())
			.isRead(false)
			.isDeleted(false)
			.build();

		when(notificationRepository.findById(1)).thenReturn(Optional.of(notificationEntity));

		try(MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
			mockedSecurityUtil.when(SecurityUtil::getEmployeeId).thenReturn(100);

			// when
			notificationCommandService.markAsRead(1);

			// then
			assertThat(notificationEntity.isRead()).isTrue();
			verify(notificationRepository, times(1)).save(notificationEntity);
		}
	}

	@Test
	public void 알림_소프트_딜리트() {

		// given
		NotificationEntity entity1 = NotificationEntity.builder()
			.id(1).employeeId(100).isDeleted(false).build();
		NotificationEntity entity2 = NotificationEntity.builder()
			.id(2).employeeId(100).isDeleted(false).build();

		List<Integer> ids = List.of(1, 2);
		List<NotificationEntity> entities = List.of(entity1, entity2);

		when(notificationRepository.findAllById(ids)).thenReturn(entities);

		try(MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
			mockedSecurityUtil.when(SecurityUtil::getEmployeeId).thenReturn(100);

			// when
			notificationCommandService.softDeleteNotifications(ids);

			// then
			assertThat(entity1.isDeleted()).isTrue();
			assertThat(entity2.isDeleted()).isTrue();
			verify(notificationRepository, times(1)).saveAll(entities);
		}
	}

	@Test
	public void 여러_알림_읽음_처리() {

		// given
		NotificationEntity entity1 = NotificationEntity.builder()
			.id(1).employeeId(100).isRead(false).build();
		NotificationEntity entity2 = NotificationEntity.builder()
			.id(2).employeeId(100).isRead(false).build();

		List<Integer> ids = List.of(1, 2);
		List<NotificationEntity> entities = List.of(entity1, entity2);

		when(notificationRepository.findAllById(ids)).thenReturn(entities);

		try (MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
			mockedSecurityUtil.when(SecurityUtil::getEmployeeId).thenReturn(100);

			// when
			notificationCommandService.markMultipleAsRead(ids);

			assertThat(entity1.isRead()).isTrue();
			assertThat(entity2.isRead()).isTrue();
			verify(notificationRepository, times(1)).saveAll(entities);
		}
	}
}
