package com.clover.salad.sales.query.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.sales.query.dto.SalesQueryRequestDTO;
import com.clover.salad.sales.query.dto.SalesQueryResponseDTO;
import com.clover.salad.sales.query.mapper.SalesQueryMapper;

@ExtendWith(MockitoExtension.class)
class SalesQueryServiceImplTest {

	@Mock
	private SalesQueryMapper salesQueryMapper;

	@InjectMocks
	private SalesQueryServiceImpl salesQueryServiceImpl;

	@Test
	void 매출_조건_검색_성공() {
		// given
		SalesQueryRequestDTO dto = new SalesQueryRequestDTO();
		dto.setDepartment("영업1팀");

		SalesQueryResponseDTO mockResult = new SalesQueryResponseDTO(
			1, null, "영업1팀", "홍길동",
			10000, "C-2501-0001"
		);

		when(salesQueryMapper.selectSalesByCondition(any()))
			.thenReturn(Collections.singletonList(mockResult));

		// when
		List<SalesQueryResponseDTO> result = salesQueryServiceImpl.searchSales(dto);

		// then
		assertEquals(1, result.size());
		assertEquals("영업1팀", result.get(0).getDepartment());
	}
}
