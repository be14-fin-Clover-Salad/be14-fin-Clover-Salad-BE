package com.clover.salad.common.file.service;

import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.common.file.enums.FileUploadType;
import com.clover.salad.common.file.repository.FileUploadRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(org.mockito.junit.jupiter.MockitoExtension.class)
@DisplayName("LocalFileStorageService 서비스 단위 테스트")
class LocalFileStorageServiceTest {

	@Mock
	private FileUploadRepository fileUploadRepository;

	@InjectMocks
	private LocalFileStorageService localFileStorageService;

	@TempDir
	Path tempDir;

	private String uploadDir;
	private FileUploadEntity dummyEntity;

	@BeforeEach
	void setUp() {
		uploadDir = tempDir.toString();
		setPrivateField(localFileStorageService, "uploadDir", uploadDir);

		dummyEntity = FileUploadEntity.builder()
			.originFile("테스트.pdf")
			.renameFile("uuid_테스트.pdf")
			.path(uploadDir)
			.type(FileUploadType.CONTRACT)
			.build();
		dummyEntity.setId(1);
	}

	@Test
	@DisplayName("멀티파트 파일 저장/DB 저장 정상 동작")
	void store_Success() throws IOException {
		// given
		MultipartFile multipartFile = mock(MultipartFile.class);
		String original = "sample.pdf";
		String randomRename = UUID.randomUUID() + "_" + original;

		when(multipartFile.getOriginalFilename()).thenReturn(original);

		// 파일 전송 확인
		doAnswer(invocation -> {
			File file = invocation.getArgument(0);
			assertThat(file.getParent()).isEqualTo(uploadDir);
			return null;
		}).when(multipartFile).transferTo(any(File.class));

		when(fileUploadRepository.save(any(FileUploadEntity.class)))
			.thenReturn(dummyEntity);

		// when
		FileUploadEntity result = localFileStorageService.store(multipartFile, "CONTRACT");

		// then
		assertThat(result).isSameAs(dummyEntity);
		verify(multipartFile).transferTo(any(File.class));
		verify(fileUploadRepository).save(any(FileUploadEntity.class));
	}

	@Test
	@DisplayName("존재하지 않는 타입 전달 시 Enum 예외")
	void store_InvalidType_ThrowsException() {
		// given
		MultipartFile multipartFile = mock(MultipartFile.class);
		when(multipartFile.getOriginalFilename()).thenReturn("abc.pdf");

		// when, then
		assertThatThrownBy(() -> localFileStorageService.store(multipartFile, "NOT_EXIST"))
			.isInstanceOf(IllegalArgumentException.class); // valueOf에서 발생
	}

	@Test
	@DisplayName("파일 전송 실패 시 IOException 예외")
	void store_IOException_Throws() throws IOException {
		// given
		MultipartFile multipartFile = mock(MultipartFile.class);
		when(multipartFile.getOriginalFilename()).thenReturn("err.pdf");
		doThrow(new IOException("전송 실패")).when(multipartFile).transferTo(any(File.class));

		// when, then
		assertThatThrownBy(() -> localFileStorageService.store(multipartFile, "CONTRACT"))
			.isInstanceOf(IOException.class)
			.hasMessageContaining("전송 실패");
	}

	//리플렉션
	private static void setPrivateField(Object target, String fieldName, Object value) {
		try {
			java.lang.reflect.Field field = target.getClass().getDeclaredField(fieldName);
			field.setAccessible(true);
			field.set(target, value);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
