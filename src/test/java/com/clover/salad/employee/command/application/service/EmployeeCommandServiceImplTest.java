package com.clover.salad.employee.command.application.service;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.Duration;
import java.util.Optional;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.clover.salad.common.exception.InvalidCurrentPasswordException;
import com.clover.salad.common.exception.InvalidEmailFormatException;
import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.common.file.repository.FileUploadRepository;
import com.clover.salad.employee.command.application.dto.EmployeeUpdateDTO;
import com.clover.salad.employee.command.application.dto.RequestChangePasswordDTO;
import com.clover.salad.employee.command.domain.aggregate.entity.EmployeeEntity;
import com.clover.salad.employee.command.domain.repository.EmployeeRepository;
import com.clover.salad.employee.query.mapper.EmployeeMapper;
import com.clover.salad.employee.query.service.EmployeeQueryService;

import jakarta.mail.internet.MimeMessage;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class EmployeeCommandServiceImplTest {

	@Mock
	private EmployeeRepository employeeRepository;

	@Mock
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Mock
	private RedisTemplate<String, String> redisTemplate;

	@Mock
	private JavaMailSender mailSender;

	@Mock
	private PasswordEncoder passwordEncoder;

	@Mock
	private EmployeeMapper employeeMapper;

	@Mock
	private FileUploadRepository fileUploadRepository;

	private EmployeeCommandServiceImpl employeeCommandServiceImpl;

	@BeforeEach
	void setup() {
		employeeCommandServiceImpl = new EmployeeCommandServiceImpl(
			employeeRepository,
			bcryptPasswordEncoder,
			redisTemplate,
			mailSender,
			passwordEncoder,
			employeeMapper,
			fileUploadRepository
		);
	}

	@Test
	public void 비밀번호_재설정_성공() {

		// given
		String token = "abc-123";
		String redisKey = "reset_token:" + token;
		String email = "test@test.com";
		String newPassword = "new123";
		String encodedPassword = "encoded123";

		ValueOperations<String, String> valueOperations = mock(ValueOperations.class);
		when(redisTemplate.opsForValue()).thenReturn(valueOperations);
		when(valueOperations.get(redisKey)).thenReturn(email);

		EmployeeEntity employee = new EmployeeEntity();
		employee.setEmail(email);

		when(employeeRepository.findByEmail(email)).thenReturn(Optional.of(employee));

		// 여기서 bCryptPasswordEncoder 사용
		when(bcryptPasswordEncoder.encode(newPassword)).thenReturn(encodedPassword);

		// when
		employeeCommandServiceImpl.confirmResetPassword(token, newPassword);

		// then
		assertThat(employee.getPassword()).isEqualTo(encodedPassword);
		verify(employeeRepository).save(employee);
		verify(redisTemplate).delete(redisKey);
	}

	@Test
	public void 사원정보_수정_성공() {
		// given
		int employeeId = 1;

		EmployeeEntity employee = new EmployeeEntity();
		employee.setId(employeeId);

		EmployeeUpdateDTO dto = new EmployeeUpdateDTO();
		dto.setName("홍길동");
		dto.setEmail("hong@example.com");
		dto.setPhone("010-1234-5678");

		when(employeeRepository.findById(employeeId)).thenReturn(Optional.of(employee));

		// when
		employeeCommandServiceImpl.updateEmployee(employeeId, dto);

		// then
		assertThat(employee.getName()).isEqualTo("홍길동");
		assertThat(employee.getEmail()).isEqualTo("hong@example.com");
		assertThat(employee.getPhone()).isEqualTo("010-1234-5678");

		verify(employeeRepository).save(employee);
	}

	@Test
	public void 사원정보_수정_이메일형식_오류_예외발생() {
		// given
		int employeeId = 1;

		EmployeeEntity employee = new EmployeeEntity();
		employee.setId(employeeId);

		EmployeeUpdateDTO dto = new EmployeeUpdateDTO();
		dto.setEmail("invalid-email");

		when(employeeRepository.findById(employeeId)).thenReturn(Optional.of(employee));

		// when, then
		assertThatThrownBy(() -> employeeCommandServiceImpl.updateEmployee(employeeId, dto))
			.isInstanceOf(InvalidEmailFormatException.class);
	}

	@Test
	public void 비밀번호_변경_성공() {
		// given
		int employeeId = 1;
		RequestChangePasswordDTO dto = new RequestChangePasswordDTO();
		dto.setCurrentPassword("old123");
		dto.setNewPassword("new123");

		EmployeeEntity employee = new EmployeeEntity();
		employee.setId(employeeId);
		employee.setPassword("HASHED_OLD");

		when(employeeRepository.findById(employeeId)).thenReturn(Optional.of(employee));

		when(passwordEncoder.matches(anyString(), anyString())).thenAnswer(invocation -> {
			String raw = invocation.getArgument(0);
			String encoded = invocation.getArgument(1);
			System.out.println(">>> matches: raw=" + raw + ", encoded=" + encoded);
			return raw.equals("old123") && encoded.equals("HASHED_OLD");
		});

		when(passwordEncoder.encode("new123")).thenReturn("ENCODED");

		// when
		employeeCommandServiceImpl.changePassword(employeeId, dto);

		// then
		assertThat(employee.getPassword()).isEqualTo("ENCODED");
		verify(employeeRepository).save(employee);
	}

	@Test
	public void 비밀번호_변경_현재비밀번호_불일치_예외() {
		// given
		int employeeId = 1;

		RequestChangePasswordDTO dto = new RequestChangePasswordDTO();
		dto.setCurrentPassword("wrongPassword");
		dto.setNewPassword("newPassword");

		EmployeeEntity employee = new EmployeeEntity();
		employee.setPassword("HASHED_PASSWORD");

		when(employeeRepository.findById(employeeId)).thenReturn(Optional.of(employee));
		when(passwordEncoder.matches("wrongPassword", "HASHED_PASSWORD"))
			.thenReturn(false);

		// when, then
		assertThatThrownBy(() -> employeeCommandServiceImpl.changePassword(employeeId, dto))
			.isInstanceOf(InvalidCurrentPasswordException.class);
	}

	@Test
	public void 프로필_경로_수정_성공() {
		// given
		int employeeId = 1;
		int profileId = 10;
		String newPath = "/profile/new.png";

		EmployeeEntity employee = new EmployeeEntity();
		employee.setId(employeeId);
		employee.setProfile(profileId);

		FileUploadEntity file = mock(FileUploadEntity.class);

		when(employeeRepository.findById(employeeId)).thenReturn(Optional.of(employee));
		when(fileUploadRepository.findById(profileId)).thenReturn(Optional.of(file));

		// when
		employeeCommandServiceImpl.updateProfilePath(employeeId, newPath);

		// then
		verify(file).setPath(newPath);
		verify(fileUploadRepository).save(file);
	}

	@Test
	public void 프로필_파일ID_수정_성공() {
		// given
		int employeeId = 1;
		int fileId = 100;

		EmployeeEntity employee = new EmployeeEntity();
		employee.setId(employeeId);

		when(employeeRepository.findById(employeeId)).thenReturn(Optional.of(employee));

		// when
		employeeCommandServiceImpl.updateProfile(employeeId, fileId);

		// then
		assertThat(employee.getProfile()).isEqualTo(fileId);
		verify(employeeRepository).save(employee);
	}





}
