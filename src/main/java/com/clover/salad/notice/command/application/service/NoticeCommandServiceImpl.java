package com.clover.salad.notice.command.application.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.clover.salad.employee.command.domain.aggregate.entity.EmployeeEntity;
import com.clover.salad.employee.command.domain.repository.EmployeeRepository;
import com.clover.salad.notice.command.application.dto.NoticeCreateRequest;
import com.clover.salad.notice.command.application.dto.NoticeUpdateRequest;
import com.clover.salad.notice.command.domain.aggregate.entity.EmployeeNotice;
import com.clover.salad.notice.command.domain.aggregate.entity.Notice;
import com.clover.salad.notice.command.domain.repository.EmployeeNoticeRepository;
import com.clover.salad.notice.command.domain.repository.NoticeRepository;
import com.clover.salad.notification.command.application.dto.NotificationCreateDTO;
import com.clover.salad.notification.command.application.service.NotificationCommandService;
import com.clover.salad.notification.command.domain.aggregate.enums.NotificationType;

@Service
public class NoticeCommandServiceImpl implements NoticeCommandService {

	private final NoticeRepository noticeRepository;
	private final EmployeeNoticeRepository employeeNoticeRepository;
	private final EmployeeRepository employeeRepository;
	private final NotificationCommandService notificationCommandService;

	@Autowired
	public NoticeCommandServiceImpl(NoticeRepository noticeRepository,
		EmployeeNoticeRepository employeeNoticeRepository, EmployeeRepository employeeRepository,
		NotificationCommandService notificationCommandService
		) {
		this.noticeRepository = noticeRepository;
		this.employeeNoticeRepository = employeeNoticeRepository;
		this.employeeRepository = employeeRepository;
		this.notificationCommandService = notificationCommandService;
	}

	@Override
	public void createNotice(NoticeCreateRequest request, int writerId) {
		Notice notice = new Notice();
		notice.setTitle(request.getTitle());
		notice.setContent(request.getContent());
		notice.setCreatedAt(LocalDateTime.now());
		notice.setEmployeeId(writerId);
		noticeRepository.save(notice);

		List<Integer> targetIds = new ArrayList<>(request.getTargetEmployeeId());

		if(!targetIds.contains(writerId)){
			targetIds.add(writerId);
		}

		List<EmployeeNotice> employeeNotices = targetIds.stream()
			.map(empId -> {
				if (!employeeRepository.existsById(empId)) {
					throw new IllegalArgumentException("존재하지 않는 사원 ID입니다: " + empId);
				}
				EmployeeNotice employeeNotice = new EmployeeNotice();
				employeeNotice.setEmployeeId(empId);
				employeeNotice.setNoticeId(notice.getId());
				return employeeNotice;
			}).toList();

		employeeNoticeRepository.saveAll(employeeNotices);

		for (Integer empId : targetIds) {
			if (empId == writerId) continue;
			notificationCommandService.createNotification(NotificationCreateDTO.builder()
				.type(NotificationType.NOTICE)
				.content("새로운 공지사항이 등록되었습니다.")
				.url("/support/notice/" + notice.getId())
				.employeeId(empId)
				.build());
		}
	}

	@Override
	@Transactional
	public void updateNotice(int noticeId, NoticeUpdateRequest request, int writerId) {
		Notice notice = noticeRepository.findById(noticeId)
			.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 공지입니다."));


		if (notice.isDeleted()) {
			throw new IllegalStateException("삭제된 공지사항은 수정할 수 없습니다.");
		}

		EmployeeEntity writer = employeeRepository.findById(writerId)
			.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 사용자입니다."));

		boolean isAdmin = writer.isAdmin();

		if(!isAdmin && notice.getEmployeeId() != writerId) {
			throw new SecurityException("작성자 또는 관리자만 수정할 수 있습니다.");
		}

		notice.setTitle(request.getTitle());
		notice.setContent(request.getContent());
		notice.setCreatedAt(LocalDateTime.now());
		noticeRepository.save(notice);

		List<EmployeeNotice> existingNotices = employeeNoticeRepository.findByNoticeId(noticeId);
		Map<Integer, EmployeeNotice> existingMap = existingNotices.stream()
			.collect(Collectors.toMap(EmployeeNotice::getEmployeeId, en -> en));

		List<Integer> newIds = request.getTargetEmployeeId() != null
			? new ArrayList<>(request.getTargetEmployeeId())
			: new ArrayList<>();

		if (!newIds.contains(writerId)) {
			newIds.add(writerId);
		}

		List<EmployeeNotice> toDelete = existingNotices.stream()
			.filter(en -> !newIds.contains(en.getEmployeeId()))
			.toList();

		List<EmployeeNotice> toAdd = newIds.stream()
			.filter(id -> !existingMap.containsKey(id))
			.map(id -> {
				if (!employeeRepository.existsById(id)) {
					throw new IllegalArgumentException("존재하지 않는 사원 ID입니다: " + id);
				}

				EmployeeNotice employeeNotice = new EmployeeNotice();
				employeeNotice.setEmployeeId(id);
				employeeNotice.setNoticeId(notice.getId());
				employeeNotice.setChecked(false);
				return employeeNotice;
			}).toList();

		employeeNoticeRepository.deleteAll(toDelete);
		employeeNoticeRepository.saveAll(toAdd);
	}

	@Override
	@Transactional
	public void deleteNotice(int noticeId, int writerId) {
		Notice notice = noticeRepository.findById(noticeId)
			.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 공지입니다."));

		EmployeeEntity writer = employeeRepository.findById(writerId)
			.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 사용자입니다."));

		boolean isAdmin = writer.isAdmin();

		if(!isAdmin && notice.getEmployeeId() != writerId) {
			throw new SecurityException("작성자 또는 관리자만 삭제할 수 있습니다.");
		}

		if(notice.isDeleted()){
			throw new IllegalStateException("이미 삭제된 공지입니다.");
		}

		notice.setDeleted(true);

		noticeRepository.save(notice);
	}

	@Override
	@Transactional
	public void checkNotice(int noticeId, int employeeId) {

		Notice notice = noticeRepository.findById(noticeId)
			.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 공지입니다."));

		if (notice.isDeleted()) {
			throw new IllegalStateException("삭제된 공지에는 반응할 수 없습니다.");
		}

		EmployeeNotice record = employeeNoticeRepository
			.findByNoticeIdAndEmployeeId(noticeId, employeeId)
			.orElseThrow(() -> new IllegalArgumentException("공지 대상이 아닙니다."));

		if(!record.isChecked()) {
			record.setChecked(true);
			employeeNoticeRepository.save(record);
		}
	}
}
