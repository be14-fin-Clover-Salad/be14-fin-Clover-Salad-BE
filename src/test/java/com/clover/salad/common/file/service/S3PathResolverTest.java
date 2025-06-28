package com.clover.salad.common.file.service;

import com.clover.salad.common.file.enums.FileUploadType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("S3PathResolver 서비스 단위 테스트")
class S3PathResolverTest {

	private S3PathResolver s3PathResolver;

	@BeforeEach
	void setUp() {
		// 실제 컴포넌트 객체 생성
		s3PathResolver = new S3PathResolver();
	}

	@Test
	@DisplayName("CONTRACT 타입에 대해 prefix가 contract/ 로 시작")
	void resolve_contractType() {
		// given
		FileUploadType type = FileUploadType.CONTRACT;
		String renamedFile = "file.pdf";

		// when
		String result = s3PathResolver.resolve(type, renamedFile);

		// then
		assertThat(result).isEqualTo("contract/file.pdf");
	}

	@Test
	@DisplayName("PRODUCT 타입에 대해 prefix가 product/ 로 시작")
	void resolve_productType() {
		// given
		FileUploadType type = FileUploadType.PRODUCT;
		String renamedFile = "file.png";

		// when
		String result = s3PathResolver.resolve(type, renamedFile);

		// then
		assertThat(result).isEqualTo("product/file.png");
	}

	@Test
	@DisplayName("PROFILE 타입에 대해 prefix가 employee/ 로 시작")
	void resolve_profileType() {
		// given
		FileUploadType type = FileUploadType.PROFILE;
		String renamedFile = "image.jpg";

		// when
		String result = s3PathResolver.resolve(type, renamedFile);

		// then
		assertThat(result).isEqualTo("employee/image.jpg");
	}

	@Test
	@DisplayName("DOCUMENT_TEMPLATE 타입에 대해 prefix가 contractTemplate/ 로 시작")
	void resolve_documentTemplateType() {
		// given
		FileUploadType type = FileUploadType.DOCUMENT_TEMPLATE;
		String renamedFile = "template.docx";

		// when
		String result = s3PathResolver.resolve(type, renamedFile);

		// then
		assertThat(result).isEqualTo("contractTemplate/template.docx");
	}
}
