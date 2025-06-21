package com.clover.salad.employee.command.application.controller;

import com.clover.salad.employee.command.application.dto.*;
import com.clover.salad.employee.command.application.service.EmployeeCommandService;
import com.clover.salad.security.JwtFilter;
import com.clover.salad.security.SecurityUtil;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.MockedStatic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

import static org.mockito.Mockito.*;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = EmployeeCommandController.class,
	excludeFilters = @ComponentScan.Filter(
		type = FilterType.ASSIGNABLE_TYPE,
		classes = JwtFilter.class
	))
@ExtendWith(SpringExtension.class)
public class EmployeeCommandControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@MockitoBean
	private EmployeeCommandService employeeCommandService;

	@Autowired
	private ObjectMapper objectMapper;

	private static final int MOCK_EMPLOYEE_ID = 1;

	private MockedStatic<SecurityUtil> securityUtilMockedStatic;

	@BeforeEach
	void setUp() throws Exception {
		SecurityContextHolder.clearContext();
		securityUtilMockedStatic = mockStatic(SecurityUtil.class);
		securityUtilMockedStatic.when(SecurityUtil::getEmployeeId).thenReturn(MOCK_EMPLOYEE_ID);
	}

	@AfterEach
	void tearDown() throws Exception {
		if (securityUtilMockedStatic != null) {
			securityUtilMockedStatic.close();
		}
	}

	@Test
	void 회원정보_수정_성공() throws Exception {

		// given
		EmployeeUpdateDTO employeeUpdateDTO = new EmployeeUpdateDTO();
		employeeUpdateDTO.setName("홍길동");
		employeeUpdateDTO.setEmail("hong@example.com");
		employeeUpdateDTO.setPhone("010-1234-5678");

		// when
		mockMvc.perform(MockMvcRequestBuilders.patch("/employee/mypage")
				.with(csrf())
				.with(user("testEmployee").roles("MEMBER"))
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(employeeUpdateDTO)))
			.andExpect(status().isOk())
			.andExpect(content().string("회원 정보가 수정되었습니다."));

		// then
		ArgumentCaptor<EmployeeUpdateDTO> captor = ArgumentCaptor.forClass(EmployeeUpdateDTO.class);
		verify(employeeCommandService).updateEmployee(eq(MOCK_EMPLOYEE_ID), captor.capture());
	}

	@Test
	void 비밀번호_재설정_요청_성공() throws Exception {

		// given
		RequestResetPasswordDTO requestResetPasswordDTO = new RequestResetPasswordDTO();
		requestResetPasswordDTO.setCode("202501001");
		requestResetPasswordDTO.setEmail("202501001@saladerp.com");

		// when
		mockMvc.perform(MockMvcRequestBuilders.post("/employee/password-reset")
				.with(csrf())
				.with(user("testEmployee").roles("MEMBER"))
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(requestResetPasswordDTO)))
			.andExpect(status().isOk())
			.andExpect(content().string("비밀번호 재설정 링크를 이메일로 전송했습니다."));

		// then
		verify(employeeCommandService).sendResetPasswordLink(requestResetPasswordDTO.getCode(),
			requestResetPasswordDTO.getEmail());
	}

	@Test
	void 비밀번호_재설정_확인_성공() throws Exception {

		// given
		RequestConfirmResetPasswordDTO requestConfirmResetPasswordDTO = new RequestConfirmResetPasswordDTO();
		requestConfirmResetPasswordDTO.setToken("reset-token-uuid");
		requestConfirmResetPasswordDTO.setNewPassword("newPass123!");

		// when
		mockMvc.perform(MockMvcRequestBuilders.post("/employee/password-resets/confirm")
				.with(csrf())
				.with(user("testEmployee").roles("MEMBER"))
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(requestConfirmResetPasswordDTO)))
			.andExpect(status().isOk())
			.andExpect(content().string("비밀번호가 성공적으로 변경되었습니다."));

		// then
		verify(employeeCommandService).confirmResetPassword(requestConfirmResetPasswordDTO.getToken(),
			requestConfirmResetPasswordDTO.getNewPassword());
	}

	@Test
	void 비밀번호_변경_성공() throws Exception {

		// given
		RequestChangePasswordDTO requestChangePasswordDTO = new RequestChangePasswordDTO();
		requestChangePasswordDTO.setCurrentPassword("oldPass123!");
		requestChangePasswordDTO.setNewPassword("newPass123!");

		// when
		mockMvc.perform(MockMvcRequestBuilders.post("/employee/password-change")
			.with(csrf())
			.with(user("testEmployee").roles("MEMBER"))
			.contentType(MediaType.APPLICATION_JSON)
			.content(objectMapper.writeValueAsString(requestChangePasswordDTO)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.message").value("비밀번호가 변경되었습니다."));

		// then
		verify(employeeCommandService).changePassword(eq(MOCK_EMPLOYEE_ID),
			argThat(actual -> actual.getCurrentPassword().equals("oldPass123!")
				&& actual.getNewPassword().equals("newPass123!")));
	}

	@Test
	void 프로필_파일_변경_성공() throws Exception {

		// given
		UpdateProfileFileDTO updateProfileFileDTO = new UpdateProfileFileDTO(1);

		// when
		mockMvc.perform(MockMvcRequestBuilders.patch("/employee/mypage/profile")
				.with(csrf())
				.with(user("testEmployee").roles("MEMBER"))
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(updateProfileFileDTO)))
			.andExpect(status().isOk())
			.andExpect(content().string("프로필이 성공적으로 변경되었습니다."));

		// then
		verify(employeeCommandService).updateProfile(MOCK_EMPLOYEE_ID, updateProfileFileDTO.getFileId());
	}

	@Test
	void 프로필_경로_변경_성공() throws Exception {

		// given
		UpdateProfilePathDTO updateProfilePathDTO = new UpdateProfilePathDTO();
		updateProfilePathDTO.setPath("http://www.saladerp.com/upload/profile/test.png");

		// when
		mockMvc.perform(MockMvcRequestBuilders.patch("/employee/mypage/profile-path")
			.with(csrf())
			.with(user("testEmployee").roles("MEMBER"))
			.contentType(MediaType.APPLICATION_JSON)
			.content(objectMapper.writeValueAsString(updateProfilePathDTO)))
			.andExpect(status().isOk())
			.andExpect(content().string("프로필 경로가 성공적으로 수정되었습니다."));

		// then
		verify(employeeCommandService).updateProfilePath(MOCK_EMPLOYEE_ID, updateProfilePathDTO.getPath());

	}
}
