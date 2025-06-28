package com.clover.salad.common.file.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3Utilities;
import software.amazon.awssdk.services.s3.model.*;

import java.io.File;
import java.net.URL;
import java.nio.file.Path;
import java.util.function.Consumer;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("S3Uploader 서비스 단위 테스트")
class S3UploaderTest {

	@Mock
	private S3Client s3Client;

	@Mock
	private S3Utilities s3Utilities;

	@InjectMocks
	private S3Uploader s3Uploader;

	private final String bucket = "test-bucket";

	@BeforeEach
	void setUp() {
		// 필드 강제 세팅 (private 필드 직접 주입)
		ReflectionTestUtils.setField(s3Uploader, "bucket", bucket);
		lenient().when(s3Client.utilities()).thenReturn(s3Utilities);
	}

	@Test
	@DisplayName("파일 업로드 성공 시 S3 URL 반환")
	void upload_success(@TempDir Path tempDir) throws Exception {
		// 임시 테스트 파일 생성
		File tempFile = tempDir.resolve("test-file.txt").toFile();
		assertThat(tempFile.createNewFile()).isTrue();

		String key = "contract/test-file.pdf";
		String expectedUrl = "https://s3.amazonaws.com/" + bucket + "/" + key;

		// S3 putObject 정상 반환
		when(s3Client.putObject(any(PutObjectRequest.class), any(RequestBody.class)))
			.thenReturn(PutObjectResponse.builder().build());

		// S3Utilities getUrl 정상 반환
		when(s3Utilities.getUrl(any(GetUrlRequest.class))).thenReturn(new URL(expectedUrl));

		// 실제 메서드 호출 및 결과 검증
		String actualUrl = s3Uploader.upload(tempFile, key);

		assertThat(actualUrl).isEqualTo(expectedUrl);

		verify(s3Client).putObject(any(PutObjectRequest.class), any(RequestBody.class));
		verify(s3Utilities).getUrl(any(GetUrlRequest.class));
	}

	@Test
	@DisplayName("파일 업로드 중 S3Exception 발생 시 RuntimeException 예외 발생")
	void upload_s3Exception_throws(@TempDir Path tempDir) throws Exception {
		File tempFile = tempDir.resolve("fail-file.txt").toFile();
		assertThat(tempFile.createNewFile()).isTrue();

		String key = "contract/fail-file.pdf";

		// S3 putObject 호출 시 S3Exception 발생 설정
		when(s3Client.putObject(any(PutObjectRequest.class), any(RequestBody.class)))
			.thenThrow(S3Exception.builder().message("S3 error").build());

		// 예외가 RuntimeException으로 래핑되어 던져지는지 검증
		assertThatThrownBy(() -> s3Uploader.upload(tempFile, key))
			.isInstanceOf(RuntimeException.class)
			.hasMessageContaining("파일 업로드 실패")
			.hasCauseInstanceOf(S3Exception.class);

		verify(s3Client).putObject(any(PutObjectRequest.class), any(RequestBody.class));
		verifyNoMoreInteractions(s3Utilities);
	}

	@Test
	@DisplayName("S3 삭제 성공 시 deleteObject 정상 호출")
	void delete_success() {
		String key = "contract/delete-file.pdf";

		// deleteObject는 void 메서드, 모킹 불필요
		s3Uploader.delete(key);

		verify(s3Client).deleteObject(ArgumentMatchers.<Consumer<DeleteObjectRequest.Builder>>any());
	}

	@Test
	@DisplayName("S3 삭제 중 S3Exception 발생 시 로그 경고 후 예외 무시")
	void delete_s3Exception_logsWarning() {
		String key = "contract/delete-fail.pdf";

		// deleteObject 호출 시 예외 던지도록 설정 (Consumer 인자 타입 명시 중요)
		doThrow(S3Exception.builder().message("S3 delete error").build())
			.when(s3Client)
			.deleteObject(ArgumentMatchers.<Consumer<DeleteObjectRequest.Builder>>any());

		// 예외가 발생해도 서비스가 무시하는지 검증
		s3Uploader.delete(key);

		verify(s3Client).deleteObject(ArgumentMatchers.<Consumer<DeleteObjectRequest.Builder>>any());
	}
}
