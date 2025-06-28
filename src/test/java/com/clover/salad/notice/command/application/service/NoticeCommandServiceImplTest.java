package com.clover.salad.notice.command.application.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.employee.command.domain.aggregate.entity.EmployeeEntity;
import com.clover.salad.employee.command.domain.repository.EmployeeRepository;
import com.clover.salad.notice.command.application.dto.NoticeCreateRequest;
import com.clover.salad.notice.command.application.dto.NoticeUpdateRequest;
import com.clover.salad.notice.command.domain.aggregate.entity.EmployeeNotice;
import com.clover.salad.notice.command.domain.aggregate.entity.Notice;
import com.clover.salad.notice.command.domain.repository.EmployeeNoticeRepository;
import com.clover.salad.notice.command.domain.repository.NoticeRepository;
import com.clover.salad.notification.command.application.service.NotificationCommandService;

@ExtendWith(MockitoExtension.class)
@DisplayName("공지사항 Command 서비스 계층 테스트")
class NoticeCommandServiceImplTest {

	@Mock
	private NoticeRepository noticeRepository;

	@Mock
	private EmployeeRepository employeeRepository;

	@Mock
	private EmployeeNoticeRepository employeeNoticeRepository;

	@Mock
	private NotificationCommandService notificationCommandService;

	@InjectMocks
	private NoticeCommandServiceImpl noticeCommandService;

	private EmployeeEntity createEmployee(int id, boolean isAdmin) {
		EmployeeEntity emp = new EmployeeEntity();
		emp.setId(id);
		emp.setAdmin(isAdmin);
		return emp;
	}

	@Test
	@DisplayName("공지사항_생성 _성공")
	void createNotice() {
		NoticeCreateRequest request = new NoticeCreateRequest();
		request.setTitle("공지사항 제목");
		request.setContent("공지사항 내용");
		request.setTargetEmployeeId(List.of(2,3));

		Notice savedNotice = new Notice();
		savedNotice.setId(1);
		when(noticeRepository.save(any(Notice.class))).thenReturn(savedNotice);
		when(employeeRepository.existsById(anyInt())).thenReturn(true);

		noticeCommandService.createNotice(request, 1);

		verify(noticeRepository).save(any(Notice.class));
		verify(employeeNoticeRepository).saveAll(any());
		verify(notificationCommandService, times(2)).createNotification(any());
	}

	@Test
	@DisplayName("공지사항_수정 _성공")
	void updateNotice() {
		int noticeId = 1;
		int writerId = 2;

		Notice existingNotice = new Notice();
		existingNotice.setId(noticeId);
		existingNotice.setEmployeeId(writerId);
		existingNotice.setDeleted(false);

		NoticeUpdateRequest request = new NoticeUpdateRequest();
		request.setTitle("수정된 제목");
		request.setContent("수정된 내용");
		request.setTargetEmployeeId(List.of(3,4,5));

		when(noticeRepository.findById(noticeId)).thenReturn(Optional.of(existingNotice));
		when(employeeRepository.findById(writerId)).thenReturn(Optional.of(createEmployee(writerId,false)));
		when(employeeNoticeRepository.findByNoticeId(noticeId)).thenReturn(new ArrayList<>());
		when(employeeRepository.existsById(anyInt())).thenReturn(true);

		noticeCommandService.updateNotice(noticeId, request, writerId);

		verify(noticeRepository).save(any());
		verify(employeeNoticeRepository).deleteAll(any());
		verify(employeeNoticeRepository).saveAll(any());
	}

	@Test
	@DisplayName("공지사항_삭제 _성공")
	void deleteNotice() {
		int noticeId = 1;
		int writerId = 2;

		Notice notice = new Notice();
		notice.setId(noticeId);
		notice.setEmployeeId(writerId);
		notice.setDeleted(false);

		EmployeeEntity writer = new EmployeeEntity();

		when(noticeRepository.findById(noticeId)).thenReturn(Optional.of(notice));
		when(employeeRepository.findById(writerId)).thenReturn(Optional.of(writer));

		noticeCommandService.deleteNotice(noticeId, writerId);

		assertTrue(notice.isDeleted());
		verify(noticeRepository).save(notice);
	}

	@Test
	@DisplayName("공지사항_확인_성공")
	void checkNotice() {
		int noticeId = 1;
		int employeeId = 2;

		Notice notice = new Notice();
		notice.setId(noticeId);
		notice.setDeleted(false);

		EmployeeNotice record = new EmployeeNotice();
		record.setId(noticeId);
		record.setEmployeeId(employeeId);
		record.setChecked(false);

		when(noticeRepository.findById(noticeId)).thenReturn(Optional.of(notice));
		when(employeeNoticeRepository.findByNoticeIdAndEmployeeId(noticeId,employeeId))
			.thenReturn(Optional.of(record));

		noticeCommandService.checkNotice(noticeId, employeeId);

		assertTrue(record.isChecked());
		verify(employeeNoticeRepository).save(record );
	}
}