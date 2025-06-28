package com.clover.salad.contract.command.facade;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.contract.command.dto.ContractUploadRequestDTO;
import com.clover.salad.contract.command.dto.ContractUploadResponseDTO;
import com.clover.salad.contract.command.entity.ContractEntity;
import com.clover.salad.contract.command.entity.ContractFileHistory;
import com.clover.salad.contract.command.service.ContractService;
import com.clover.salad.contract.command.service.parser.PdfContractParserService;
import com.clover.salad.contract.document.entity.DocumentOrigin;
import com.clover.salad.contract.document.service.DocumentOriginService;
import com.clover.salad.common.file.service.PdfThumbnailService;
import com.clover.salad.common.file.repository.FileUploadRepository;
import com.clover.salad.contract.exception.ContractUploadFailedException;
import com.clover.salad.security.SecurityUtil;

import org.junit.jupiter.api.*;
import org.mockito.*;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

@DisplayName("ContractUploadFacade 단위 테스트")
class ContractUploadFacadeTest {

	@InjectMocks
	private ContractUploadFacade contractUploadFacade;

	@Mock
	private PdfContractParserService pdfContractParserService;

	@Mock
	private ContractService contractService;

	@Mock
	private DocumentOriginService documentOriginService;

	@Mock
	private PdfThumbnailService thumbnailService;

	@Mock
	private FileUploadRepository fileUploadRepository;

	@Mock
	private DocumentOrigin documentOrigin;

	@Mock
	private FileUploadEntity fileUploadEntity;

	@BeforeEach
	void setUp() {
		MockitoAnnotations.openMocks(this);

		try {
			Mockito.mockStatic(SecurityUtil.class).when(SecurityUtil::getEmployeeId).thenReturn(1);
		} catch (Exception ignored) {
		}
	}

	@AfterEach
	void tearDown() {
		try {
			Mockito.clearAllCaches();
			Mockito.framework().clearInlineMocks();
		} catch (Exception ignored) {
		}
	}

	@Test
	@DisplayName("신규 계약 업로드 정상 처리 - Happy Path")
	void handleUpload_success() throws Exception {
		// 파일 및 DTO 세팅
		MultipartFile multipartFile = new MockMultipartFile("file", "contract.pdf", "application/pdf", "dummy content".getBytes());
		ContractUploadRequestDTO parsedDto = mock(ContractUploadRequestDTO.class);
		ContractEntity savedContract = mock(ContractEntity.class);

		when(documentOrigin.getFileUpload()).thenReturn(fileUploadEntity);
		when(fileUploadEntity.getPath()).thenReturn("dummy/path.pdf");

		// Mock 동작 정의
		when(pdfContractParserService.parsePdf(any(File.class))).thenReturn(parsedDto);
		doNothing().when(contractService).validate(parsedDto);
		when(documentOriginService.uploadAndSave(any(File.class), anyString())).thenReturn(documentOrigin);
		when(thumbnailService.generateFirstPageThumbnail(anyString())).thenReturn(new byte[10]);
		when(thumbnailService.uploadThumbnailToS3(anyString(), any(byte[].class))).thenReturn("thumb/path.jpg");
		when(fileUploadRepository.save(any(FileUploadEntity.class))).thenReturn(fileUploadEntity);
		when(contractService.registerContract(parsedDto)).thenReturn(savedContract);
		when(savedContract.getId()).thenReturn(123);

		// 실제 메서드 호출
		ContractUploadResponseDTO response = contractUploadFacade.handleUpload(multipartFile);

		// 결과 검증
		Assertions.assertEquals(123, response.getContractId());
		Assertions.assertEquals("계약 등록 완료", response.getMessage());

		// 내부 호출 verify
		verify(pdfContractParserService).parsePdf(any(File.class));
		verify(contractService).validate(parsedDto);
		verify(documentOriginService).uploadAndSave(any(File.class), anyString());
		verify(thumbnailService).generateFirstPageThumbnail("dummy/path.pdf");
		verify(thumbnailService).uploadThumbnailToS3(eq("dummy/path.pdf"), any(byte[].class));
		verify(fileUploadRepository).save(fileUploadEntity);
		verify(contractService).registerContract(parsedDto);
	}

	@Test
	@DisplayName("계약 업로드 중 파싱 실패 시 예외 발생 및 롤백")
	void handleUpload_parseFails_throwsAndRollback() throws Exception {
		MultipartFile multipartFile = new MockMultipartFile("file", "contract.pdf", "application/pdf", "dummy content".getBytes());

		when(pdfContractParserService.parsePdf(any(File.class))).thenThrow(new RuntimeException("파싱 실패"));
		when(documentOriginService.uploadAndSave(any(File.class), anyString())).thenReturn(documentOrigin);
		doNothing().when(documentOriginService).rollback(documentOrigin);

		ContractUploadFailedException thrown = Assertions.assertThrows(ContractUploadFailedException.class, () -> {
			contractUploadFacade.handleUpload(multipartFile);
		});

		Assertions.assertTrue(thrown.getMessage().contains("계약 등록 실패"));

	}

	@Test
	@DisplayName("기존 계약 재업로드 정상 처리")
	void handleReplace_success() throws Exception {
		MultipartFile multipartFile = new MockMultipartFile("file", "replace.pdf", "application/pdf", "dummy content".getBytes());
		ContractEntity existingContract = mock(ContractEntity.class);
		ContractUploadRequestDTO parsedDto = mock(ContractUploadRequestDTO.class);
		ContractEntity newContract = mock(ContractEntity.class);
		ContractFileHistory history = mock(ContractFileHistory.class);

		// DocumentOrigin 및 FileUploadEntity mock 세팅
		when(documentOrigin.getFileUpload()).thenReturn(fileUploadEntity);
		when(fileUploadEntity.getPath()).thenReturn("dummy/path.pdf");

		// 기존 계약 무효 처리
		when(contractService.markContractDeleted(anyInt())).thenReturn(existingContract);

		// 파싱 및 검증
		when(pdfContractParserService.parsePdf(any(File.class))).thenReturn(parsedDto);
		doNothing().when(contractService).validate(parsedDto);

		// S3 업로드 및 DocumentOrigin 저장
		when(documentOriginService.uploadAndSave(any(File.class), anyString())).thenReturn(documentOrigin);

		// 썸네일 생성 및 업로드
		when(thumbnailService.generateFirstPageThumbnail(anyString())).thenReturn(new byte[10]);
		when(thumbnailService.uploadThumbnailToS3(anyString(), any(byte[].class))).thenReturn("thumb/path.jpg");

		// 썸네일 경로 DB 반영
		when(fileUploadRepository.save(any(FileUploadEntity.class))).thenReturn(fileUploadEntity);

		// 신규 계약 등록
		when(contractService.registerContract(parsedDto)).thenReturn(newContract);
		when(newContract.getId()).thenReturn(10);

		// 버전 히스토리 저장 (void method)
		doNothing().when(contractService).saveContractHistory(any(ContractFileHistory.class));

		ContractUploadResponseDTO response = contractUploadFacade.handleReplace(10, multipartFile, "노트");

		Assertions.assertEquals(10, response.getContractId());
		Assertions.assertEquals("기존 계약 갱신 완료", response.getMessage());

		verify(contractService).markContractDeleted(10);
		verify(contractService).validate(parsedDto);
		verify(contractService).registerContract(parsedDto);
		verify(contractService).saveContractHistory(any(ContractFileHistory.class));
	}

	@Test
	@DisplayName("기존 계약 재업로드 중 신규 계약 등록 실패 시 예외 발생 및 롤백")
	void handleReplace_registerFail_throwsAndRollback() throws Exception {
		MultipartFile multipartFile = new MockMultipartFile("file", "replace.pdf", "application/pdf", "dummy content".getBytes());
		ContractEntity existingContract = mock(ContractEntity.class);
		ContractUploadRequestDTO parsedDto = mock(ContractUploadRequestDTO.class);

		when(contractService.markContractDeleted(anyInt())).thenReturn(existingContract);
		when(pdfContractParserService.parsePdf(any(File.class))).thenReturn(parsedDto);
		doNothing().when(contractService).validate(parsedDto);
		when(documentOriginService.uploadAndSave(any(File.class), anyString())).thenReturn(documentOrigin);
		when(documentOrigin.getFileUpload()).thenReturn(fileUploadEntity);
		when(fileUploadEntity.getPath()).thenReturn("dummy/path.pdf");
		when(thumbnailService.generateFirstPageThumbnail(anyString())).thenReturn(new byte[10]);
		when(thumbnailService.uploadThumbnailToS3(anyString(), any(byte[].class))).thenReturn("thumb/path.jpg");
		when(fileUploadRepository.save(any(FileUploadEntity.class))).thenReturn(fileUploadEntity);

		// 신규 계약 등록 실패로 null 또는 id <=0 반환
		when(contractService.registerContract(parsedDto)).thenReturn(mock(ContractEntity.class));
		when(contractService.registerContract(parsedDto).getId()).thenReturn(0);

		doNothing().when(documentOriginService).rollback(documentOrigin);

		ContractUploadFailedException thrown = Assertions.assertThrows(ContractUploadFailedException.class, () -> {
			contractUploadFacade.handleReplace(10, multipartFile, "노트");
		});

		Assertions.assertTrue(thrown.getMessage().contains("계약 재업로드 실패"));
		verify(documentOriginService).rollback(documentOrigin);
	}
}
