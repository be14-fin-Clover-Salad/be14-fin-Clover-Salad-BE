package com.clover.salad.contract.command.service.parser;

import static org.junit.jupiter.api.Assertions.*;

import java.lang.reflect.Constructor;
import java.time.LocalDate;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import com.clover.salad.contract.command.dto.ContractDTO;
import com.clover.salad.contract.command.dto.ContractUploadRequestDTO;
import com.clover.salad.contract.command.dto.CustomerDTO;
import com.clover.salad.contract.command.dto.ProductDTO;
import com.clover.salad.contract.document.entity.DocumentOrigin;
import com.clover.salad.contract.document.entity.DocumentTemplate;
import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.customer.command.domain.aggregate.vo.CustomerType;

@DisplayName("DefaultTemplateParser 단위 테스트")
class DefaultTemplateParserTest {

	private DefaultTemplateParser parser;
	private DocumentOrigin dummyOrigin;

	private final String standardRentalText = """
        표준 렌탈 계약서
        Rental Agreement
        계약 시작일 2024-06-04 계약 종료일 2025-12-01
        [계약 조건]
        상품명 수량 모델명 제조사 월 렌탈료 (원) 합계 (원/월)
        휘센 듀얼 에어컨 2in1 2 FQ18DADWE2 LG 46800
        비스포크 큐커 AI 오븐 3 MC32A7035KT LG 12500 131100
        Ÿ 월 렌탈료는 설치일 익월 납기일에 납부합니다.
        Ÿ 상기 금액은 부가세 VAT가 포함된 금액입니다.
        [납부방법]
        예금주 로라 계좌 번호 110491051250
        은행 자동이체
        매월 납입일자 24일 은행명 신한
        본인과의 관계 본인
        추가 정보
        결제 정보 이메일 roora@babymonster.com
        [계약자 정보]
        이름 로라 주소 서울 서초구 반포동
        생년월일 2008-08-05 연락처 0107746992
        이메일 roora@babymonster.com 계약 담당자 강수지
        [요구사항]
        고객요구사항 설치희망일시
        주문확인서 우편물
        """;

	@BeforeEach
	void setUp() {
		parser = new DefaultTemplateParser();

		FileUploadEntity dummyFileUpload = null;
		try {
			Constructor<FileUploadEntity> ctor = FileUploadEntity.class.getDeclaredConstructor();
			ctor.setAccessible(true);
			dummyFileUpload = ctor.newInstance();
			dummyFileUpload.setId(1);
		} catch (Exception e) {
			fail("FileUploadEntity 인스턴스 생성 실패: " + e.getMessage());
		}

		DocumentTemplate dummyDocumentTemplate = new DocumentTemplate();
		dummyDocumentTemplate.setId(1);

		dummyOrigin = DocumentOrigin.builder()
			.fileUpload(dummyFileUpload)
			.documentTemplate(dummyDocumentTemplate)
			.build();
	}

	@Test
	@DisplayName("표준 계약서 텍스트를 기반으로 정상 파싱 테스트")
	void parseAll_standardRentalAgreement() {
		ContractUploadRequestDTO result = parser.parseAll(standardRentalText, "", "", dummyOrigin);

		CustomerDTO customer = result.getCustomer();
		assertEquals("로라", customer.getName(), "고객 이름이 정확히 파싱되어야 한다");
		assertEquals("2008-08-05", customer.getBirthdate(), "생년월일이 정확히 파싱되어야 한다");
		assertEquals("서울 서초구 반포동", customer.getAddress(), "주소가 정확히 파싱되어야 한다");
		assertEquals("0107746992", customer.getPhone(), "전화번호가 하이픈 없이 파싱되어야 한다");
		assertEquals("roora@babymonster.com", customer.getEmail(), "이메일이 정확히 파싱되어야 한다");
		assertEquals(CustomerType.CUSTOMER, customer.getCustomerType(), "고객 유형이 CUSTOMER여야 한다");

		ContractDTO contract = result.getContract();
		assertEquals(LocalDate.of(2024, 6, 4), contract.getStartDate(), "계약 시작일이 정확히 파싱되어야 한다");
		assertEquals(LocalDate.of(2025, 12, 1), contract.getEndDate(), "계약 종료일이 정확히 파싱되어야 한다");
		assertEquals(131100, contract.getAmount(), "계약 금액이 월 렌탈료 합계로 정확히 파싱되어야 한다");
		assertEquals("신한", contract.getBankName(), "은행명이 정확히 파싱되어야 한다");
		assertEquals("110491051250", contract.getBankAccount(), "계좌 번호가 정확히 파싱되어야 한다");
		assertEquals("로라", contract.getDepositOwner(), "예금주가 정확히 파싱되어야 한다");
		assertEquals("본인", contract.getRelationship(), "관계 정보가 정확히 파싱되어야 한다");
		assertEquals("roora@babymonster.com", contract.getPaymentEmail(), "결제 이메일이 정확히 파싱되어야 한다");
		assertEquals(24, contract.getPaymentDay(), "매월 납입일자가 정확히 파싱되어야 한다");

		List<ProductDTO> products = result.getProducts();
		assertEquals(2, products.size(), "상품이 2개 정상 파싱되어야 한다");

		ProductDTO product1 = products.get(0);
		assertEquals("휘센 듀얼 에어컨 2in1", product1.getProductName(), "첫 번째 상품명 정확히 파싱");
		assertEquals(2, product1.getQuantity(), "첫 번째 상품 수량 정확히 파싱");
		assertEquals("FQ18DADWE2", product1.getModelName(), "첫 번째 상품 모델명 정확히 파싱");
		assertEquals("LG", product1.getManufacturer(), "첫 번째 상품 제조사 정확히 파싱");

		ProductDTO product2 = products.get(1);
		assertEquals("비스포크 큐커 AI 오븐", product2.getProductName(), "두 번째 상품명 정확히 파싱");
		assertEquals(3, product2.getQuantity(), "두 번째 상품 수량 정확히 파싱");
		assertEquals("MC32A7035KT", product2.getModelName(), "두 번째 상품 모델명 정확히 파싱");
		assertEquals("LG", product2.getManufacturer(), "두 번째 상품 제조사 정확히 파싱");

		assertSame(dummyOrigin, result.getDocumentOrigin(), "문서 출처 객체가 동일해야 한다");
	}

	@Test
	@DisplayName("상품 정보가 없는 경우 빈 리스트 반환 확인")
	void parseProducts_emptyProducts() {
		String noProductText = """
            이름 김철수
            생년월일 1990-02-15
            주소 부산시 해운대구
            연락처 010-0000-0000
            이메일 kim@example.com
            계약 시작일 2023-03-01 계약 종료일 2023-12-31
            [계약 조건]
            월 렌탈료 0
            [납부방법]
            은행명 하나은행
            계좌 번호 111-222-3333
            예금주 김철수
            본인과의 관계 본인
            결제 정보 이메일 pay2@example.com
            매월 납입일자 15일
            """;

		ContractUploadRequestDTO result = parser.parseAll(noProductText, "", "", dummyOrigin);
		List<ProductDTO> products = result.getProducts();

		assertTrue(products.isEmpty(), "상품 정보가 없으면 빈 리스트여야 한다");
	}

	@Test
	@DisplayName("날짜 형식이 비표준일 때는 날짜 필드가 null일 수 있음")
	void parseAll_invalidDateFormat() {
		String invalidDateText = standardRentalText.replace("2024-06-04", "2024/06/04").replace("2025-12-01", "2025/12/01");

		ContractUploadRequestDTO result = parser.parseAll(invalidDateText, "", "", dummyOrigin);
		ContractDTO contract = result.getContract();

		assertNull(contract.getStartDate(), "비표준 날짜 포맷은 null일 수 있다");
		assertNull(contract.getEndDate(), "비표준 날짜 포맷은 null일 수 있다");
	}

	@Test
	@DisplayName("일부 필드 누락된 텍스트 처리 확인")
	void parseAll_partialFields() {
		String partialText = """
            이름 김민수
            생년월일 1995-10-10
            주소 부산시 해운대구
            연락처 010-9999-8888
            이메일 minsu@example.com
            계약 시작일 2023-04-01 계약 종료일 2023-10-31
            [계약 조건]
            월 렌탈료 30000
            [납부방법]
            은행명 국민은행
            계좌 번호 987-654-3210
            예금주 김민수
            본인과의 관계 본인
            결제 정보 이메일 pay3@example.com
            매월 납입일자 10일
            """;

		ContractUploadRequestDTO result = parser.parseAll(partialText, "", "", dummyOrigin);

		CustomerDTO customer = result.getCustomer();
		assertEquals("김민수", customer.getName(), "이름 정상 파싱");
		assertEquals("부산시 해운대구", customer.getAddress(), "주소 정상 파싱");

		ContractDTO contract = result.getContract();
		assertEquals(30000, contract.getAmount(), "계약 금액 정상 파싱");

		assertTrue(result.getProducts().isEmpty(), "상품 정보가 없으면 빈 리스트");
	}

	@Test
	@DisplayName("멀티라인 상품 정보 정상 파싱 테스트")
	void parseAll_multilineProducts() {
		String multilineProductText = """
            이름 로라
            생년월일 2008-08-05
            주소 서울 서초구 반포동
            연락처 0107746992
            이메일 roora@babymonster.com
            계약 시작일 2024-06-04 계약 종료일 2025-12-01
            [계약 조건]
            상품명 수량 모델명 제조사 월 렌탈료 (원) 합계 (원/월)
            공기청정기 1 AC1000 삼성 45000
            45000
            냉장고 2 RF3000 LG 65000
            [납부방법]
            예금주 로라 계좌 번호 110491051250
            은행 자동이체
            매월 납입일자 24일 은행명 신한
            본인과의 관계 본인
            추가 정보
            결제 정보 이메일 roora@babymonster.com
            """;

		ContractUploadRequestDTO result = parser.parseAll(multilineProductText, "", "", dummyOrigin);
		List<ProductDTO> products = result.getProducts();

		assertEquals(2, products.size(), "멀티라인 상품 정보 2개 정상 파싱");

		ProductDTO product1 = products.get(0);
		assertEquals("공기청정기", product1.getProductName());
		assertEquals(1, product1.getQuantity());
		assertEquals("AC1000", product1.getModelName());
		assertEquals("삼성", product1.getManufacturer());

		ProductDTO product2 = products.get(1);
		assertEquals("냉장고", product2.getProductName());
		assertEquals(2, product2.getQuantity());
		assertEquals("RF3000", product2.getModelName());
		assertEquals("LG", product2.getManufacturer());
	}
}
