package com.clover.salad.salesDashboard.query.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.salesDashboard.query.dto.SalesTotalRequestDTO;
import com.clover.salad.salesDashboard.query.dto.SalesTotalResponseDTO;
import com.clover.salad.salesDashboard.query.mapper.SalesDashboardQueryMapper;

@ExtendWith(MockitoExtension.class)
class SalesDashboardQueryServiceImplTest {

	@Mock
	private SalesDashboardQueryMapper salesDashboardQueryMapper;

	@InjectMocks
	private SalesDashboardQueryServiceImpl service;

	@Test
	void 전체_매출_조회_월단위() {

		// given
		LocalDate now = LocalDate.of(2025, 6, 25);
		LocalDate startDate = now.withDayOfMonth(1);
		String period = "month";

		SalesTotalRequestDTO requestDTO = new SalesTotalRequestDTO(period);
		when(salesDashboardQueryMapper.selectTotalSalesByDateRange(
			eq(startDate.toString()), eq(now.toString()))).thenReturn(12345);

		// when
		SalesTotalResponseDTO result = service.getTotalSalesByPeriod(requestDTO);

		// then
		assertEquals(period, result.getPeriod());
		assertEquals(startDate, result.getStartDate());
		assertEquals(now, result.getEndDate());
		assertEquals(12345, result.getTotalAmount());
	}
}
