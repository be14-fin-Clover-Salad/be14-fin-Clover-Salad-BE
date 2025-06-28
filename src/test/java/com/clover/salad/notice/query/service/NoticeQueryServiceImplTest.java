package com.clover.salad.notice.query.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.sql.Array;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.employee.query.dto.DepartmentQueryDTO;
import com.clover.salad.employee.query.dto.EmployeeQueryDTO;
import com.clover.salad.employee.query.mapper.EmployeeMapper;
import com.clover.salad.notice.query.dto.CheckInfoDTO;
import com.clover.salad.notice.query.dto.NoticeDetailDTO;
import com.clover.salad.notice.query.dto.NoticeListDTO;
import com.clover.salad.notice.query.mapper.NoticeMapper;

@ExtendWith(MockitoExtension.class)
class NoticeQueryServiceImplTest {

	@Mock
	private NoticeMapper noticeMapper;

	@Mock
	private EmployeeMapper employeeMapper;

	@InjectMocks
	private NoticeQueryServiceImpl noticeQueryService;

	private EmployeeQueryDTO dummyEmployee;
	private List<NoticeListDTO> mockNoticeList;

	private NoticeListDTO createDummyNotice(int id,String title, String writerName, String writerLevel){
		NoticeListDTO dto = new NoticeListDTO();
		dto.setId(id);
		dto.setTitle(title);
		dto.setCreatedAt(LocalDateTime.now());
		dto.setDeleted(false);
		dto.setWriterId(2);
		dto.setWriterName(writerName);
		dto.setWriterLevel(writerLevel);
		dto.setDepartmentName("영업1팀");
		dto.setChecked(false);
		return dto;
	}

	private NoticeDetailDTO createDummyDetail(int id, String title) {
		NoticeDetailDTO dto = new NoticeDetailDTO();
		dto.setId(id);
		dto.setTitle(title);
		dto.setContent("공지 내용");
		dto.setWriterName("강수지");
		dto.setWriterLevel("사원");
		dto.setDepartmentName("영업1팀");
		dto.setDeleted(false);
		dto.setCreatedAt(LocalDateTime.now());
		return dto;
	}

	private List<CheckInfoDTO> createDummyCheckInfo(){
		CheckInfoDTO dto = new CheckInfoDTO();
		dto.setEmployeeId(1);
		dto.setEmployeeName("김성민");
		dto.setChecked(true);
		return List.of(dto);
	}

	@BeforeEach
	void setUp() {
		dummyEmployee = new EmployeeQueryDTO();
		dummyEmployee.setId(1);
		dummyEmployee.setLevel("사원");
		DepartmentQueryDTO dept = new DepartmentQueryDTO();
		dept.setId(1);
		dept.setName("영업1팀");

		dummyEmployee.setDepartment(dept);

		mockNoticeList = List.of(
			createDummyNotice(1,"공지사항1","강수지","사원"),
			createDummyNotice(2,"공지사항2","강수지","사원")
		);
	}

	@Test
	@DisplayName("공지사항_리스트_조회_성공")
	void findNoticeList() {
		int employeeId = dummyEmployee.getId();

		when(employeeMapper.findEmployeeById(employeeId)).thenReturn(dummyEmployee);
		when(noticeMapper.findNoticeList(employeeId,"사원",1)).thenReturn(mockNoticeList);

		List<NoticeListDTO> result = noticeQueryService.findNoticeList(employeeId);

		assertEquals(2, result.size());
		assertEquals("공지사항1",result.get(0).getTitle());
		assertEquals("공지사항2",result.get(1).getTitle());

		verify(employeeMapper).findEmployeeById(employeeId);
		verify(noticeMapper).findNoticeList(employeeId,dummyEmployee.getLevel(),dummyEmployee.getDepartment().getId());
	}

	@Test
	@DisplayName("공지사항_상세보기_조회_성공")
	void getNoticeDetail() {
		int employeeId = dummyEmployee.getId();
		int noticeId = 1;

		when(employeeMapper.findEmployeeById(employeeId)).thenReturn(dummyEmployee);
		when(noticeMapper.getNoticeDetail(anyMap())).thenReturn(createDummyDetail(noticeId,"공지사항1"));
		when(noticeMapper.findTargetEmployeesOfNotice(noticeId)).thenReturn(createDummyCheckInfo());

		NoticeDetailDTO result = noticeQueryService.getNoticeDetail(noticeId,employeeId);

		assertNotNull(result);
		assertEquals(noticeId,result.getId());
		assertEquals("공지사항1",result.getTitle());
		assertEquals("공지 내용",result.getContent());
		assertEquals(1,result.getCheckList().size());
		assertEquals("김성민",result.getCheckList().get(0).getEmployeeName());
		assertTrue(result.getCheckList().get(0).isChecked());

		verify(employeeMapper).findEmployeeById(employeeId);
		verify(noticeMapper).getNoticeDetail(anyMap());
		verify(noticeMapper).findTargetEmployeesOfNotice(noticeId);
	}
}