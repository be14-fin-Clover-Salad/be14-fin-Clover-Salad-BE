package com.clover.salad.notification.command.domain.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.clover.salad.notification.command.domain.aggregate.entity.NotificationEntity;

public interface NotificationRepository extends JpaRepository<NotificationEntity, Integer> {
	void deleteByIsDeletedTrueAndCreatedAtBefore(LocalDateTime beforeDateTime);

	List<NotificationEntity> findAllByEmployeeIdAndIsReadFalse(int employeeId);
}
