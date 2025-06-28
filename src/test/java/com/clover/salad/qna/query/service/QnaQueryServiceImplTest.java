package com.clover.salad.qna.query.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDateTime;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.employee.command.domain.repository.EmployeeRepository;
import com.clover.salad.employee.query.dto.EmployeeQueryDTO;
import com.clover.salad.employee.query.mapper.EmployeeMapper;
import com.clover.salad.notification.command.application.service.NotificationCommandService;
import com.clover.salad.qna.command.domain.repository.QnaRepository;
import com.clover.salad.qna.query.dto.QnaDetailDTO;
import com.clover.salad.qna.query.dto.QnaListDTO;
import com.clover.salad.qna.query.mapper.QnaMapper;

@ExtendWith(MockitoExtension.class)
@DisplayName("문의사항 Query 서비스 계층 테스트")
class QnaQueryServiceImplTest {

	@Mock
	private QnaMapper qnaMapper;

	@Mock
	private EmployeeMapper employeeMapper;

	@InjectMocks
	private QnaQueryServiceImpl qnaQueryService;

	private EmployeeQueryDTO dummyEmployee;

	private List<QnaListDTO> mockQnaList;

	private QnaListDTO createQnaDummyList(int id, String title, String answerStatus, int writerId) {
		QnaListDTO dto = new QnaListDTO();
		dto.setId(id);
		dto.setTitle(title);
		dto.setCreatedAt(LocalDateTime.now());
		dto.setAnswerStatus(answerStatus);
		dto.setDeleted(false);
		dto.setWriterId(writerId);
		return dto;
	}

	private QnaDetailDTO createQnaDummyDetail(int id, String title,String content, int writerId, boolean isDeleted){
		QnaDetailDTO dto = new QnaDetailDTO();
		dto.setId(id);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setCreatedAt(LocalDateTime.now());
		dto.setAnswerStatus("대기");
		dto.setAnswerContent(null);
		dto.setDeleted(isDeleted);
		dto.setWriterId(writerId);
		dto.setWriterName("김성민");
		dto.setWriterLevel("사원");
		dto.setDepartmentName("영업1팀");
		return dto;
	}

	@BeforeEach
	void setUp() {
		dummyEmployee = new EmployeeQueryDTO();
		dummyEmployee.setId(1);
		dummyEmployee.setLevel("사원");

	}

	@Test
	@DisplayName("문의사항_리스트_조회_성공")
	void findQnaList() {
		int employeeId = dummyEmployee.getId();

		List<QnaListDTO> dummyList = List.of(
			createQnaDummyList(1,"문의 제목1","대기",employeeId),
			createQnaDummyList(2,"문의 제목2","완료",employeeId)
		);

		when(employeeMapper.findEmployeeById(employeeId)).thenReturn(dummyEmployee);
		when(qnaMapper.findQnaList(employeeId,"사원")).thenReturn(dummyList);

		List<QnaListDTO> result = qnaQueryService.findQnaList(employeeId);

		assertEquals(2, result.size());
		assertEquals("문의 제목1",result.get(0).getTitle());
		assertEquals("문의 제목2",result.get(1).getTitle());

		verify(employeeMapper).findEmployeeById(employeeId);
		verify(qnaMapper).findQnaList(employeeId,"사원");

	}

	@Test
	@DisplayName("문의사항_상세보기_조회_성공")
	void findQnaDetail() {
		int employeeId = dummyEmployee.getId();
		int qnaId = 1;

		QnaDetailDTO dummyDetail = createQnaDummyDetail(
			qnaId,"문의 제목1","문의 내용1",employeeId,false);

		when(employeeMapper.findEmployeeById(employeeId)).thenReturn(dummyEmployee);
		when(qnaMapper.findQnaDetail(qnaId,employeeId,"사원")).thenReturn(dummyDetail);

		QnaDetailDTO result = qnaQueryService.findQnaDetail(qnaId,employeeId);

		assertNotNull(result);
		assertEquals(qnaId,result.getId());
		assertEquals("문의 제목1",result.getTitle());
		assertEquals("문의 내용1",result.getContent());
		assertEquals("김성민",result.getWriterName());
		assertEquals("사원",result.getWriterLevel());
		assertEquals("영업1팀",result.getDepartmentName());

		verify(employeeMapper).findEmployeeById(employeeId);
		verify(qnaMapper).findQnaDetail(qnaId,employeeId,"사원");
	}
}