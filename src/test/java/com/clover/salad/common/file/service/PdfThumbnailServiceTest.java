package com.clover.salad.common.file.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.springframework.test.util.ReflectionTestUtils;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;

import java.io.IOException;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(org.mockito.junit.jupiter.MockitoExtension.class)
@DisplayName("PdfThumbnailService 서비스 단위 테스트")
class PdfThumbnailServiceTest {

	@Mock
	private S3Client s3Client;

	@InjectMocks
	private PdfThumbnailService pdfThumbnailService;

	private final String bucket = "test-bucket";

	@BeforeEach
	void setUp() {
		// bucket 값 강제 세팅
		ReflectionTestUtils.setField(pdfThumbnailService, "bucket", bucket);
	}

	@Test
	@DisplayName("잘못된 URL 형식 전달 시 IOException 예외")
	void generateFirstPageThumbnail_invalidUrl() {
		// given
		String badUrl = ":::://broken";

		// when/then
		assertThatThrownBy(() -> pdfThumbnailService.generateFirstPageThumbnail(badUrl))
			.isInstanceOf(IOException.class)
			.hasMessageContaining("잘못된 PDF URL 형식");
	}

	@Test
	@DisplayName("S3 예외 발생 시 IOException 발생")
	void generateFirstPageThumbnail_s3Exception() throws Exception {
		// given
		String pdfUrl = "https://s3.amazonaws.com/test-bucket/contract/uuid_test.pdf";
		when(s3Client.getObject(any(GetObjectRequest.class))).thenThrow(S3Exception.builder().message("s3 down").build());

		// when/then
		assertThatThrownBy(() -> pdfThumbnailService.generateFirstPageThumbnail(pdfUrl))
			.isInstanceOf(IOException.class)
			.hasMessageContaining("S3에서 PDF를 가져오는 중 오류");
	}

	@Test
	@DisplayName("썸네일 바이트를 S3에 정상 업로드 후 키 반환")
	void uploadThumbnailToS3_success() throws Exception {
		// given
		String pdfUrl = "https://s3.amazonaws.com/test-bucket/contract/uuid_test.pdf";
		byte[] thumbBytes = new byte[]{1,2,3};

		PutObjectResponse putResponse = PutObjectResponse.builder().build();
		when(s3Client.putObject(any(PutObjectRequest.class), any(RequestBody.class))).thenReturn(putResponse);

		// when
		String resultKey = pdfThumbnailService.uploadThumbnailToS3(pdfUrl, thumbBytes);

		// then
		// 버킷명 포함된 키를 기대값으로 변경
		assertThat(resultKey).isEqualTo("test-bucket/contract/uuid_test-thumb.png");
		verify(s3Client).putObject(any(PutObjectRequest.class), any(RequestBody.class));
	}

	@Test
	@DisplayName("uploadThumbnailToS3에서 잘못된 URL 형식 예외 발생")
	void uploadThumbnailToS3_invalidUrl() {
		// given
		String badUrl = "::::bad";
		byte[] bytes = {1,2};

		// when/then
		assertThatThrownBy(() -> pdfThumbnailService.uploadThumbnailToS3(badUrl, bytes))
			.isInstanceOf(IOException.class)
			.hasMessageContaining("잘못된 PDF URL 형식");
	}

	@Test
	@DisplayName("S3 putObject 예외 발생 시 IOException 예외")
	void uploadThumbnailToS3_s3Exception() {
		// given
		String pdfUrl = "https://s3.amazonaws.com/test-bucket/contract/uuid_test.pdf";
		byte[] thumbBytes = new byte[]{1,2,3};

		when(s3Client.putObject(any(PutObjectRequest.class), any(RequestBody.class)))
			.thenThrow(S3Exception.builder().message("s3 err").build());

		// when/then
		assertThatThrownBy(() -> pdfThumbnailService.uploadThumbnailToS3(pdfUrl, thumbBytes))
			.isInstanceOf(IOException.class)
			.hasMessageContaining("S3에 썸네일을 업로드하는 중 오류");
	}

	/* pdf관련 외부 라이브러리는 통합테스트로 진행 */
}
