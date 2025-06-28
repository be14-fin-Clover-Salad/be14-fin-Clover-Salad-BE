package com.clover.salad.salesDashboard.query.service;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.salesDashboard.query.dto.SalesMonthlyTrendResponseDTO;
import com.clover.salad.salesDashboard.query.dto.SalesQuarterlyTrendResponseDTO;
import com.clover.salad.salesDashboard.query.dto.SalesTotalRequestDTO;
import com.clover.salad.salesDashboard.query.dto.SalesTotalResponseDTO;
import com.clover.salad.salesDashboard.query.dto.SalesYearlyTrendResponseDTO;
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


		try (MockedStatic<LocalDate> mock = mockStatic(LocalDate.class)) {
			mock.when(LocalDate::now).thenReturn(now);
			mock.when(() -> LocalDate.of(2025, 6, 25)).thenCallRealMethod();
			mock.when(() -> now.withDayOfMonth(1)).thenReturn(startDate);

			when(salesDashboardQueryMapper.selectTotalSalesByDateRange(
				startDate.toString(), now.toString())).thenReturn(12345);

			// when
			SalesTotalResponseDTO result = service.getTotalSalesByPeriod(requestDTO);

			// then
			assertThat(result.getPeriod()).isEqualTo("month");
			assertThat(result.getStartDate()).isEqualTo(startDate);
			assertThat(result.getEndDate()).isEqualTo(now);
			assertThat(result.getTotalAmount()).isEqualTo(12345);
		}
	}

	@Test
	void 전체_매출_조회_전월단위() {

		// given
		String period = "lastmonth";
		SalesTotalRequestDTO requestDTO = new SalesTotalRequestDTO(period);

		try (MockedStatic<LocalDate> mock = mockStatic(LocalDate.class, CALLS_REAL_METHODS)) {
			LocalDate now = LocalDate.of(2025, 6, 25);
			LocalDate firstDayOfThisMonth = LocalDate.of(2025, 6, 1);
			LocalDate lastMonthEnd = firstDayOfThisMonth.minusDays(1);
			LocalDate startDate = LocalDate.of(2025, 5, 1);

			mock.when(LocalDate::now).thenReturn(now);
			mock.when(() -> LocalDate.of(2025, 6, 1)).thenReturn(firstDayOfThisMonth);
			mock.when(() -> LocalDate.of(2025, 5, 1)).thenReturn(startDate);

			when(salesDashboardQueryMapper.selectTotalSalesByDateRange(
				startDate.toString(), lastMonthEnd.toString())).thenReturn(67890);

			// when
			SalesTotalResponseDTO result = service.getTotalSalesByPeriod(requestDTO);

			// then
			assertThat(result.getPeriod()).isEqualTo("lastmonth");
			assertThat(result.getStartDate()).isEqualTo(startDate);
			assertThat(result.getEndDate()).isEqualTo(lastMonthEnd);
			assertThat(result.getTotalAmount()).isEqualTo(67890);

			verify(salesDashboardQueryMapper).selectTotalSalesByDateRange(
				startDate.toString(), lastMonthEnd.toString());
		}

	}

	@Test
	void 월별_매출_추이_조회() {

		// given
		int year = 2025;
		List<SalesMonthlyTrendResponseDTO> mockResult = List.of(
			new SalesMonthlyTrendResponseDTO(2025, 1, 1000),
			new SalesMonthlyTrendResponseDTO(2025, 2, 2000)
		);

		when(salesDashboardQueryMapper.selectMonthlySalesByYear(year)).thenReturn(mockResult);

		// when
		List<SalesMonthlyTrendResponseDTO> result = service.getMonthlySalesTrend(year);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getYear()).isEqualTo(2025);
		assertThat(result.get(0).getMonth()).isEqualTo(1);
		assertThat(result.get(0).getTotalAmount()).isEqualTo(1000);
		assertThat(result.get(1).getMonth()).isEqualTo(2);
		assertThat(result.get(1).getTotalAmount()).isEqualTo(2000);

		verify(salesDashboardQueryMapper).selectMonthlySalesByYear(year);
	}

	@Test
	void 분기별_매출_추이_조회() {

		// given
		int year = 2025;
		List<SalesQuarterlyTrendResponseDTO> mockResult = List.of(
			new SalesQuarterlyTrendResponseDTO(2025, 1, 3000),
			new SalesQuarterlyTrendResponseDTO(2025, 2, 4000)
		);

		when(salesDashboardQueryMapper.selectQuarterlySalesByYear(year)).thenReturn(mockResult);

		// when
		List<SalesQuarterlyTrendResponseDTO> result = service.getQuarterlySalesTrend(year);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getYear()).isEqualTo(2025);
		assertThat(result.get(0).getQuarter()).isEqualTo(1);
		assertThat(result.get(0).getTotalAmount()).isEqualTo(3000);
		assertThat(result.get(1).getYear()).isEqualTo(2025);
		assertThat(result.get(1).getQuarter()).isEqualTo(2);
		assertThat(result.get(1).getTotalAmount()).isEqualTo(4000);

		verify(salesDashboardQueryMapper).selectQuarterlySalesByYear(year);
	}

	@Test
	void 연도별_매출_추이_조회() {

		// given
		try (MockedStatic<LocalDate> mock = mockStatic(LocalDate.class)) {
			LocalDate now = LocalDate.of(2025, 6, 25);
			int endYear = now.getYear();
			int startYear = endYear - 9;

			mock.when(LocalDate::now).thenReturn(now);

			List<SalesYearlyTrendResponseDTO> mockResult = List.of(
				new SalesYearlyTrendResponseDTO(2016, 6)
			)
		}
	}
}
