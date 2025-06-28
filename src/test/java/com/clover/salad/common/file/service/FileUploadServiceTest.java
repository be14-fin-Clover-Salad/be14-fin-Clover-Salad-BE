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

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(org.mockito.junit.jupiter.MockitoExtension.class)
@DisplayName("FileUploadService 서비스 계층 단위 테스트")
class FileUploadServiceTest {

	@Mock
	private S3Uploader s3Uploader;
	@Mock
	private S3PathResolver pathResolver;
	@Mock
	private FileUploadRepository fileUploadRepository;

	@InjectMocks
	private FileUploadService fileUploadService;

	private FileUploadEntity dummyEntity;

	@BeforeEach
	void setUp() {
		dummyEntity = FileUploadEntity.builder()
			.originFile("원본.pdf")
			.renameFile("랜덤.pdf")
			.path("uploads/test/랜덤.pdf")
			.type(FileUploadType.CONTRACT)
			.build();
		dummyEntity.setId(10);
	}

	@Test
	@DisplayName("파일 업로드 및 DB 저장")
	void uploadAndSaveMultipart_Success(@TempDir Path tempDir) throws IOException {
		// given
		MultipartFile mockMultipart = mock(MultipartFile.class);
		String originFile = "origin.pdf";
		String renamedFile = "uuid_" + originFile;
		FileUploadType type = FileUploadType.CONTRACT;

		doNothing().when(mockMultipart).transferTo(any(File.class));
		when(mockMultipart.getOriginalFilename()).thenReturn(originFile);
		when(pathResolver.resolve(eq(type), anyString())).thenReturn("resolved/path/" + renamedFile);
		when(s3Uploader.upload(any(File.class), anyString())).thenReturn("s3-url/path/" + renamedFile);

		when(fileUploadRepository.save(any(FileUploadEntity.class)))
			.thenAnswer(inv -> {
				FileUploadEntity e = inv.getArgument(0);
				e.setId(123); // Integer 타입으로 맞춤
				return e;
			});

		// when
		FileUploadEntity result = fileUploadService.uploadAndSave(mockMultipart, type);

		// then
		assertThat(result.getOriginFile()).isEqualTo(originFile);
		assertThat(result.getType()).isEqualTo(type);
		assertThat(result.getPath()).contains("s3-url/path/");
		assertThat(result.getRenameFile()).contains(originFile);
		assertThat(result.getId()).isEqualTo(123);

		verify(mockMultipart).transferTo(any(File.class));
		verify(s3Uploader).upload(any(File.class), anyString());
		verify(fileUploadRepository).save(any(FileUploadEntity.class));
	}

	@Test
	@DisplayName("직접 파일 업로드 및 DB 저장")
	void uploadAndSaveFile_Success(@TempDir Path tempDir) {
		// given
		File dummyFile = tempDir.resolve("hello.pdf").toFile();
		String originalFilename = "hello.pdf";
		String renamed = "uuid_" + originalFilename;
		FileUploadType type = FileUploadType.CONTRACT;

		when(pathResolver.resolve(eq(type), anyString())).thenReturn("resolved/path/" + renamed);
		when(s3Uploader.upload(eq(dummyFile), eq("resolved/path/" + renamed))).thenReturn("s3-url/path/" + renamed);
		when(fileUploadRepository.save(any(FileUploadEntity.class))).thenReturn(dummyEntity);

		// when
		FileUploadEntity saved = fileUploadService.uploadAndSave(dummyFile, originalFilename, type);

		// then
		assertThat(saved).isSameAs(dummyEntity);

		verify(pathResolver).resolve(eq(type), anyString());
		verify(s3Uploader).upload(eq(dummyFile), eq("resolved/path/" + renamed));
		verify(fileUploadRepository).save(any(FileUploadEntity.class));
	}

	@Test
	@DisplayName("S3 파일 삭제시 S3Uploader 호출")
	void deleteFromS3_InvokesS3Uploader() {
		// given
		String key = "some/path/to/file.pdf";

		// when
		fileUploadService.deleteFromS3(key);

		// then
		verify(s3Uploader).delete(key);
	}

	@Test
	@DisplayName("파일 업로드에서 IOException 발생 시 예외")
	void uploadAndSaveMultipart_IOException_Throws(@TempDir Path tempDir) throws IOException {
		// given
		MultipartFile mockMultipart = mock(MultipartFile.class);
		when(mockMultipart.getOriginalFilename()).thenReturn("fail.pdf");
		doThrow(new IOException("전송 실패")).when(mockMultipart).transferTo(any(File.class));

		// when, then
		assertThatThrownBy(() -> fileUploadService.uploadAndSave(mockMultipart, FileUploadType.CONTRACT))
			.isInstanceOf(IOException.class)
			.hasMessageContaining("전송 실패");
	}
}
