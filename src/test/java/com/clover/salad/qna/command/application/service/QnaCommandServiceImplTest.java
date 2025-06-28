package com.clover.salad.qna.command.application.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.employee.command.domain.aggregate.entity.EmployeeEntity;
import com.clover.salad.employee.command.domain.repository.EmployeeRepository;
import com.clover.salad.employee.query.mapper.EmployeeMapper;
import com.clover.salad.notification.command.application.service.NotificationCommandService;
import com.clover.salad.qna.command.application.dto.QnaAnswerRequest;
import com.clover.salad.qna.command.application.dto.QnaCreateRequest;
import com.clover.salad.qna.command.domain.aggregate.entity.Qna;
import com.clover.salad.qna.command.domain.repository.QnaRepository;

@ExtendWith(MockitoExtension.class)
@DisplayName("문의사항 Command 서비스 계층 테스트")
class QnaCommandServiceImplTest {

	@Mock
	private QnaRepository qnaRepository;

	@Mock
	private EmployeeRepository employeeRepository;

	@Mock
	private EmployeeMapper employeeMapper;

	@Mock
	private NotificationCommandService notificationCommandService;

	@InjectMocks
	private QnaCommandServiceImpl qnaCommandService;

	private QnaCreateRequest qnaCreateRequest;
	private QnaAnswerRequest qnaAnswerRequest;
	private EmployeeEntity dummyEmployee;
	private Qna dummyQna;

	@BeforeEach
	void setUp() {
		qnaCreateRequest = new QnaCreateRequest();
		qnaAnswerRequest = new QnaAnswerRequest();

		qnaCreateRequest.setTitle("문의 제목");
		qnaCreateRequest.setContent("문의 내용");
		qnaAnswerRequest.setAnswerContent("답변 내용");

		dummyEmployee = new EmployeeEntity();
		dummyEmployee.setId(1);
		dummyEmployee.setAdmin(false);

		dummyQna = new Qna();
		dummyQna.setId(1);
		dummyQna.setTitle("문의 제목");
		dummyQna.setContent("문의 내용");
		dummyQna.setAnswerStatus("대기");
		dummyQna.setDeleted(false);
		dummyQna.setEmployeeId(1);
	}

	@Test
	@DisplayName("문의사항_생성_성공")
	void createQna() {
		when(employeeRepository.existsById(1)).thenReturn(true);
		when(employeeMapper.findAdminIds()).thenReturn(List.of(2));

		qnaCommandService.createQna(qnaCreateRequest,1);

		verify(qnaRepository).save(any(Qna.class));
		verify(notificationCommandService).createNotification(any());
	}

	@Test
	@DisplayName("문의사항_삭제_성공")
	void deleteQna() {
		when(qnaRepository.findById(1)).thenReturn(Optional.of(dummyQna));
		when(employeeRepository.findById(1)).thenReturn(Optional.of(dummyEmployee));

		qnaCommandService.deleteQna(1,1);

		assertTrue(dummyQna.isDeleted());
		verify(qnaRepository).save(dummyQna);
	}

	@Test
	@DisplayName("문의사항_답변_성공")
	void answerQna() {
		dummyEmployee.setAdmin(true);

		when(qnaRepository.findById(1)).thenReturn(Optional.of(dummyQna));
		when(employeeRepository.findById(1)).thenReturn(Optional.of(dummyEmployee));

		qnaCommandService.answerQna(1, qnaAnswerRequest, 1);

		assertEquals("답변 내용", dummyQna.getAnswerContent());
		assertEquals("완료", dummyQna.getAnswerStatus());
		verify(qnaRepository).save(dummyQna);
		verify(notificationCommandService).createNotification(any());
	}

	@Test
	@DisplayName("문의사항_답변_수정_성공")
	void updateAnswer() {
		dummyEmployee.setAdmin(true);
		dummyQna.setAnswerStatus("완료");

		when(qnaRepository.findById(1)).thenReturn(Optional.of(dummyQna));
		when(employeeRepository.findById(1)).thenReturn(Optional.of(dummyEmployee));

		qnaCommandService.updateAnswer(1, qnaAnswerRequest, 1);

		assertEquals("답변 내용",dummyQna.getAnswerContent());
		verify(qnaRepository).save(dummyQna);
	}
}