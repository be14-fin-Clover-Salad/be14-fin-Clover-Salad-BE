package com.clover.salad.contract.document.service;

import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.common.file.enums.FileUploadType;
import com.clover.salad.common.file.repository.FileUploadRepository;
import com.clover.salad.common.file.service.FileUploadService;
import com.clover.salad.contract.document.entity.DocumentOrigin;
import com.clover.salad.contract.document.entity.DocumentTemplate;
import com.clover.salad.contract.document.repository.DocumentOriginRepository;
import com.clover.salad.contract.document.repository.DocumentTemplateRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("계약서 원본 서비스 계층 테스트")
class DocumentOriginServiceTest {

	@Mock
	private FileUploadService fileUploadService;
	@Mock
	private DocumentOriginRepository originRepo;
	@Mock
	private FileUploadRepository uploadRepo;
	@Mock
	private DocumentTemplateRepository templateRepo;

	@InjectMocks                                      // 의존성 주입 Mock 객체
	private DocumentOriginService service;

	private DocumentTemplate defaultTemplate;         // 기본 템플릿 더미
	private FileUploadEntity dummyUpload;             // 업로드 더미 엔티티

	@BeforeEach
		// 각 시작전 파일 세팅
	void setUp() {
		defaultTemplate = DocumentTemplate.builder()
			.id(1)
			.name("기본 템플릿")
			.version("v1.0")
			.build();

		dummyUpload = FileUploadEntity.builder()
			.originFile("test.pdf")
			.renameFile("test-1234.pdf")
			.path("contract/100.pdf")
			.thumbnailPath(null)
			.type(FileUploadType.CONTRACT)
			.build();
		dummyUpload.setId(100);
	}

	@Test
	@DisplayName("파일 업로드 후 DocumentOrigin 저장 테스트")
	void uploadAndSaveSavesDocumentOrigin(@TempDir Path tempDir) throws IOException {
		// TempDir을 이용해 실제 임시 파일 생성
		Path testFilePath = Files.createFile(tempDir.resolve("test.pdf"));
		File testFile = testFilePath.toFile();

		// given
		when(fileUploadService.uploadAndSave(testFile, "test.pdf", FileUploadType.CONTRACT))
			.thenReturn(dummyUpload);
		when(templateRepo.findById(1)).thenReturn(Optional.of(defaultTemplate));
		when(originRepo.save(any(DocumentOrigin.class))).thenAnswer(inv -> inv.getArgument(0));

		// when
		DocumentOrigin savedOrigin = service.uploadAndSave(testFile, "test.pdf");

		// then
		assertThat(savedOrigin.getFileUpload()).isSameAs(dummyUpload);
		assertThat(savedOrigin.getDocumentTemplate()).isSameAs(defaultTemplate);
		assertThat(savedOrigin.isDeleted()).isFalse();

		/*
		 *  verify 업로드 몇번 되었는지 확인 (여러번 되면 안되기 때문)
		 * */
		verify(fileUploadService).uploadAndSave(testFile, "test.pdf", FileUploadType.CONTRACT);
		verify(templateRepo).findById(1);
		verify(originRepo).save(any(DocumentOrigin.class));
	}

	@Test
	@DisplayName("임시 파일이 존재하지 않으면 예외 처리")
	void uploadAndSaveFileNotExistsThrows(@TempDir Path tempDir) {
		// given
		File missingFile = tempDir.resolve("nope.pdf").toFile();

		// then
		assertThatThrownBy(() -> service.uploadAndSave(missingFile, "nope.pdf"))
			.isInstanceOf(IllegalArgumentException.class)
			.hasMessage("임시 파일이 존재하지 않습니다.");

		verifyNoInteractions(fileUploadService, templateRepo, originRepo);
	}

	@Test
	@DisplayName("기본 템플릿이 없으면 예외 발생")
	void uploadAndSaveNoTemplateThrows(@TempDir Path tempDir) throws IOException {
		File dummyFile = Files.createFile(tempDir.resolve("dummy.pdf")).toFile();

		// given:
		when(fileUploadService.uploadAndSave(dummyFile, "dummy.pdf", FileUploadType.CONTRACT))
			.thenReturn(dummyUpload);
		when(templateRepo.findById(1)).thenReturn(Optional.empty());

		// when, then:
		assertThatThrownBy(() -> service.uploadAndSave(dummyFile, "dummy.pdf"))
			.isInstanceOf(IllegalStateException.class)
			.hasMessage("기본 템플릿이 존재하지 않습니다.");

		// save 호출 X
		verify(originRepo, never()).save(any());
	}

	@Test
	@DisplayName("롤백 시 S3 삭제와 DB 삭제가 호출")
	void rollbackCallsDelete() {
		// given:
		DocumentOrigin origin = DocumentOrigin.builder()
			.fileUpload(dummyUpload)
			.build();

		// when:
		service.rollback(origin);

		/* then:
		 * void 반환이기에 assertThat 확인 없이 내부에서만 처리
		 * */
		verify(fileUploadService).deleteFromS3(dummyUpload.getPath());
		verify(originRepo).delete(origin);
		verify(uploadRepo).delete(dummyUpload);
	}

	@Test
	@DisplayName("롤백 대상이 null 이거나 FileUpload가 null이면 동작 안함 ")
	void rollbackNullOrNoUploadNoInteractions() {
		// when:
		service.rollback(null);
		service.rollback(DocumentOrigin.builder().fileUpload(null).build());

		// then
		verifyNoInteractions(fileUploadService, originRepo, uploadRepo);
	}
}
