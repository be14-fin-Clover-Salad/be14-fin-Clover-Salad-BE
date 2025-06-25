package com.clover.salad.notification.query.service;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.notification.query.dto.NotificationDropdownResponseDTO;
import com.clover.salad.notification.query.dto.NotificationListResponseDTO;
import com.clover.salad.notification.query.mapper.NotificationMapper;
import com.clover.salad.security.SecurityUtil;

@ExtendWith(MockitoExtension.class)
class NotificationQueryServiceImplTest {

	@Mock
	private NotificationMapper notificationMapper;

	@InjectMocks
	private NotificationQueryServiceImpl notificationQueryServiceImpl;

	@Test
	public void 읽지_않은_알림_전체_조회() {

		// given
		int employeeId = 100;
		List<NotificationDropdownResponseDTO> expected = List.of(
			NotificationDropdownResponseDTO.builder().id(1).content("내용1").build(),
			NotificationDropdownResponseDTO.builder().id(2).content("내용2").build()
		);

		when(notificationMapper.findAllUnreadByEmployeeId(employeeId)).thenReturn(expected);

		try (MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
			mockedSecurityUtil.when(SecurityUtil::getEmployeeId).thenReturn(employeeId);

			// when
			List<NotificationDropdownResponseDTO> result = notificationQueryServiceImpl.getUnreadAll();

			// then
			assertThat(result).hasSize(2).containsExactlyElementsOf(expected);
		}
	}

	@Test
	public void 전체_알림_목록_페이지_조회() {

		// given
		int employeeId = 100;
		int page = 1;
		int limit = 20;
		int offset = page * limit;

		List<NotificationListResponseDTO> expected = List.of(
			NotificationListResponseDTO.builder().id(1).content("내용").isRead(false).build()
		);

		when(notificationMapper.findAllByEmployeeIdWithPaging(employeeId, limit, offset)).thenReturn(expected);

		try (MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
			mockedSecurityUtil.when(SecurityUtil::getEmployeeId).thenReturn(employeeId);

			// when
			List<NotificationListResponseDTO> result = notificationQueryServiceImpl.getAllNotifications(page);

			assertThat(result).hasSize(1).containsExactlyElementsOf(expected);
		}
	}

}
