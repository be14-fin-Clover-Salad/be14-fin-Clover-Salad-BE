package com.clover.salad.contract.command.service.parser;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

@DisplayName("PdfParsingStrategyRouter 단위 테스트")
class PdfParsingStrategyRouterTest {

	@Mock
	private DefaultTemplateParser defaultTemplateParser;

	private PdfParsingStrategyRouter router;

	@BeforeEach
	void setUp() {
		MockitoAnnotations.openMocks(this);
		router = new PdfParsingStrategyRouter(List.of(defaultTemplateParser));
		router.init();
	}

	@Test
	@DisplayName("init() 호출 시 DefaultTemplateParser가 templateId=1에 등록")
	void init_registersDefaultTemplateParser() throws Exception {
		Map<Integer, PdfContractParsingStrategy> strategies =
			(Map<Integer, PdfContractParsingStrategy>)
				TestUtils.getField(router, "strategies");

		assertTrue(strategies.containsKey(1), "templateId 1이 전략에 등록");
		assertEquals(defaultTemplateParser, strategies.get(1), "등록된 전략이 DefaultTemplateParser여야 한다");
	}

	@Test
	@DisplayName("getStrategy()는 등록된 전략을 반환")
	void getStrategy_returnsRegisteredStrategy() {
		PdfContractParsingStrategy strategy = router.getStrategy(1);

		assertNotNull(strategy, "전략은 null이 아니어야 한다");
		assertEquals(defaultTemplateParser, strategy, "templateId 1에 대해 등록된 전략을 반환해야 한다");
	}

	@Test
	@DisplayName("존재하지 않는 templateId로 호출 시 예외가 발생")
	void getStrategy_invalidTemplateId_throws() {
		IllegalArgumentException ex = assertThrows(IllegalArgumentException.class, () -> {
			router.getStrategy(999);
		});

		assertTrue(ex.getMessage().contains("템플릿 ID 999에 대한 파싱 전략이 존재하지 않습니다."),
			"적절한 예외 메시지를 포함해야 한다");
	}

	static class TestUtils {
		@SuppressWarnings("unchecked")
		static <T> T getField(Object target, String fieldName) throws Exception {
			var field = target.getClass().getDeclaredField(fieldName);
			field.setAccessible(true);
			return (T) field.get(target);
		}
	}
}
