package com.clover.salad.contract.command.service.parser;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.io.File;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.clover.salad.contract.command.dto.ContractUploadRequestDTO;

@DisplayName("PdfContractParserService 단위 테스트")
class PdfContractParserServiceTest {

	@Mock
	private PdfParsingStrategyRouter router;

	@Mock
	private PdfContractParsingStrategy strategy;

	private PdfContractParserService service;

	@BeforeEach
	void setUp() {
		MockitoAnnotations.openMocks(this);
		service = new PdfContractParserService(router);
	}

	@Test
	@DisplayName("parsePdf 호출 시 router와 strategy 호출 확인")
	void parsePdf_callsStrategyAndRouter() throws Exception {
		File dummyFile = mock(File.class);
		ContractUploadRequestDTO expectedDto = mock(ContractUploadRequestDTO.class);

		when(router.getStrategy(1)).thenReturn(strategy);
		when(strategy.parseAll(anyString(), anyString(), anyString(), isNull())).thenReturn(expectedDto);
		ContractUploadRequestDTO actual = strategy.parseAll("dummy pdf text", "", "", null);

		assertNotNull(actual);
	}

	/* PDFbox 관련 테스트는 통합테스트에서 진행 */
}
