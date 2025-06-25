package com.clover.salad.notice.command.application.controller;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import com.clover.salad.notice.command.application.service.NoticeCommandService;

@SuppressWarnings("ALL")
@WebMvcTest(NoticeCommandController.class)
class NoticeCommandControllerTest {

	@Autowired
	private MockMvc mvc;

	@MockBean
	private NoticeCommandService noticeCommandService;

	@Test
	void 공지사항_등록_() {

	}

	@Test
	void 공지사항_수정() {
	}

	@Test
	void 공지사항_삭제() {
	}

	@Test
	void 공지사항_확인처리() {
	}
}