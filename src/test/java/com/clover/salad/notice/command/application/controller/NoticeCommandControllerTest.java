package com.clover.salad.notice.command.application.controller;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import com.clover.salad.employee.command.domain.aggregate.entity.EmployeeEntity;
import com.clover.salad.notice.command.application.dto.NoticeCreateRequest;
import com.clover.salad.notice.command.application.service.NoticeCommandService;
import com.clover.salad.security.EmployeeDetails;
import com.clover.salad.security.JwtUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

@SuppressWarnings("ALL")
@WebMvcTest(NoticeCommandController.class)
class NoticeCommandControllerTest {

	@Autowired
	private MockMvc mvc;

	@Autowired
	private ObjectMapper objectMapper;

	@MockBean
	private NoticeCommandService noticeCommandService;

	@MockBean
	private RedisTemplate<String, String> redisTemplate;

	@MockBean
	private JwtUtil jwtUtil;

	@Test
	void 공지사항_등록_성공() throws Exception {
		NoticeCreateRequest request = new NoticeCreateRequest();
		request.setTitle("업무 회의 공지");
		request.setContent("내일 10시에 전체 회의가 있습니다.");
		request.setTargetEmployeeId(List.of(1, 2, 3));

		int mockId = 100;
		String mockCode = "EMP001";
		String mockPassword = "pass";
		List<SimpleGrantedAuthority> roles = List.of(new SimpleGrantedAuthority("ROLE_MEMBER"));

		EmployeeDetails employeeDetails = new EmployeeDetails(mockId, mockCode, mockPassword, roles);

		doNothing().when(noticeCommandService)
			.createNotice(Mockito.any(NoticeCreateRequest.class), eq(mockId));

		mvc.perform(post("/support/notice/create")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(request))
				.with(csrf())
				.with(authentication(
					new UsernamePasswordAuthenticationToken(employeeDetails, null, employeeDetails.getAuthorities()))
				))
			.andExpect(status().isOk())
			.andExpect(content().string("공지 사항 등록 완료"));

		verify(noticeCommandService).createNotice(Mockito.any(), eq(mockId));
	}

	@Test
	void 권한_없는_사용자_공지작성_실패() throws Exception {
		NoticeCreateRequest request = new NoticeCreateRequest();
		request.setTitle("무단 접근");
		request.setContent("ROLE_MEMBER는 작성할 수 없습니다.");
		request.setTargetEmployeeId(List.of(1, 2));

		// ROLE_MEMBER로 인증
		EmployeeDetails member = new EmployeeDetails(100, "MEM01", "pw",
			List.of(new SimpleGrantedAuthority("ROLE_MEMBER")));

		mvc.perform(post("/support/notice/create")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(request))
				.with(csrf())
				.with(authentication(
					new UsernamePasswordAuthenticationToken(member, null, member.getAuthorities()))
				))
			.andExpect(status().isForbidden());
	}

	// @Test
	// void 공지사항_수정() {
	// 	// NoticeUpdateRequest request = new NoticeUpdate
	// }

	// @Test
	// void 공지사항_삭제() {
	// }
	//
	// @Test
	// void 공지사항_확인처리() {
	// }
}