package com.clover.salad.notification.query.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.notification.query.mapper.NotificationMapper;

@ExtendWith(MockitoExtension.class)
class NotificationQueryServiceImplTest {

	@Mock
	private NotificationMapper notificationMapper;

	@InjectMocks
	private NotificationQueryServiceImpl notificationQueryServiceImpl;

}
