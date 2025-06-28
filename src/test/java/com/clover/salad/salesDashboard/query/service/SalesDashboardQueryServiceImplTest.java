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
import com.clover.salad.salesDashboard.query.dto.SalesTeamAmountResponseDTO;
import com.clover.salad.salesDashboard.query.dto.SalesTeamRatioRawDTO;
import com.clover.salad.salesDashboard.query.dto.SalesTeamRatioResponseDTO;
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
	void 전체_매출_조회_기간_월() {

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
	void 전체_매출_조회_기간_전월() {

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
		try (MockedStatic<LocalDate> mock = mockStatic(LocalDate.class, CALLS_REAL_METHODS)) {
			LocalDate now = LocalDate.of(2025, 6, 25);
			mock.when(LocalDate::now).thenReturn(now);

			int endYear = now.getYear();
			int startYear = endYear - 9;

			List<SalesYearlyTrendResponseDTO> mockResult = List.of(
				new SalesYearlyTrendResponseDTO(2016, 5000),
				new SalesYearlyTrendResponseDTO(2017, 6000)
			);

			when(salesDashboardQueryMapper.selectYearlySalesRange(startYear, endYear)).thenReturn(mockResult);

			// when
			List<SalesYearlyTrendResponseDTO> result = service.getYearlySalesTrend();

			// then
			assertThat(result).hasSize(2);
			assertThat(result.get(0).getYear()).isEqualTo(2016);
			assertThat(result.get(0).getTotalAmount()).isEqualTo(5000);
			assertThat(result.get(1).getYear()).isEqualTo(2017);
			assertThat(result.get(1).getTotalAmount()).isEqualTo(6000);

			verify(salesDashboardQueryMapper).selectYearlySalesRange(startYear, endYear);
		}
	}

	@Test
	void 팀별_매출_비중_조회_기간_연() {

		// given
		try (MockedStatic<LocalDate> mock = mockStatic(LocalDate.class, CALLS_REAL_METHODS)) {
			LocalDate now = LocalDate.of(2025, 6, 25);
			LocalDate startDate = now.withDayOfYear(1);

			mock.when(LocalDate::now).thenReturn(now);

			SalesTeamRatioRawDTO team1 = mock(SalesTeamRatioRawDTO.class);
			when(team1.getTeamName()).thenReturn("영업1팀");
			when(team1.getTeamAmount()).thenReturn(3000);

			SalesTeamRatioRawDTO team2 = mock(SalesTeamRatioRawDTO.class);
			when(team2.getTeamName()).thenReturn("영업2팀");
			when(team2.getTeamAmount()).thenReturn(7000);

			List<SalesTeamRatioRawDTO> rawList = List.of(team1, team2);

			when(salesDashboardQueryMapper.selectTeamSalesInPeriod(eq(startDate), eq(now))).thenReturn(rawList);

			// when
			List<SalesTeamRatioResponseDTO> result = service.getSalesTeamRatioByPeriod("year");

			// then
			assertThat(result).hasSize(2);
			assertThat(result.get(0).getTeamName()).isEqualTo("영업1팀");
			assertThat(result.get(0).getTeamAmount()).isEqualTo(3000);
			assertThat(result.get(0).getRatio()).isEqualTo(30.0);

			assertThat(result.get(1).getTeamName()).isEqualTo("영업2팀");
			assertThat(result.get(1).getTeamAmount()).isEqualTo(7000);
			assertThat(result.get(1).getRatio()).isEqualTo(70.0);

			verify(salesDashboardQueryMapper).selectTeamSalesInPeriod(eq(startDate), eq(now));

		}
	}

	@Test
	void 팀별_매출_비중_조회_월단위() {

		// given
		int year = 2025;
		int month = 6;
		LocalDate start = LocalDate.of(2025, 6, 1);
		LocalDate end = start.withDayOfMonth(start.lengthOfMonth());

		SalesTeamRatioRawDTO team1 = mock(SalesTeamRatioRawDTO.class);
		when(team1.getTeamName()).thenReturn("영업1팀");
		when(team1.getTeamAmount()).thenReturn(3000);

		SalesTeamRatioRawDTO team2 = mock(SalesTeamRatioRawDTO.class);
		when(team2.getTeamName()).thenReturn("영업2팀");
		when(team2.getTeamAmount()).thenReturn(7000);

		List<SalesTeamRatioRawDTO> rawList = List.of(team1, team2);

		when(salesDashboardQueryMapper.selectTeamSalesInPeriod(start, end)).thenReturn(rawList);

		// when
		List<SalesTeamRatioResponseDTO> result = service.getMonthlyTeamSalesRatio(year, month);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getTeamName()).isEqualTo("영업1팀");
		assertThat(result.get(0).getTeamAmount()).isEqualTo(3000);
		assertThat(result.get(0).getRatio()).isEqualTo(30.0);

		assertThat(result.get(1).getTeamName()).isEqualTo("영업2팀");
		assertThat(result.get(1).getTeamAmount()).isEqualTo(7000);
		assertThat(result.get(1).getRatio()).isEqualTo(70.0);

		verify(salesDashboardQueryMapper).selectTeamSalesInPeriod(eq(start), eq(end));
	}

	@Test
	void 분기별_매출_비중_조회() {

		// given
		int year = 2025;
		int quarter = 2;
		LocalDate start = LocalDate.of(2025, 4, 1);
		LocalDate end = LocalDate.of(2025, 6, 30);

		SalesTeamRatioRawDTO team1 = mock(SalesTeamRatioRawDTO.class);
		when(team1.getTeamName()).thenReturn("영업1팀");
		when(team1.getTeamAmount()).thenReturn(2500);

		SalesTeamRatioRawDTO team2 = mock(SalesTeamRatioRawDTO.class);
		when(team2.getTeamName()).thenReturn("영업2팀");
		when(team2.getTeamAmount()).thenReturn(7500);

		List<SalesTeamRatioRawDTO> rawList = List.of(team1, team2);

		when(salesDashboardQueryMapper.selectTeamSalesInPeriod(eq(start), eq(end))).thenReturn(rawList);

		// when
		List<SalesTeamRatioResponseDTO> result = service.getQuarterlyTeamSalesRatio(year, quarter);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getTeamName()).isEqualTo("영업1팀");
		assertThat(result.get(0).getTeamAmount()).isEqualTo(2500);
		assertThat(result.get(0).getRatio()).isEqualTo(25.0);

		assertThat(result.get(1).getTeamName()).isEqualTo("영업2팀");
		assertThat(result.get(1).getTeamAmount()).isEqualTo(7500);
		assertThat(result.get(1).getRatio()).isEqualTo(75.0);

		verify(salesDashboardQueryMapper).selectTeamSalesInPeriod(eq(start), eq(end));
	}

	@Test
	void 팀별_매출_비중_조회_분기단위() {

		// given
		int year = 2025;
		int quarter = 2;
		LocalDate start = LocalDate.of(2025, 4, 1);
		LocalDate end = LocalDate.of(2025, 6, 30);

		SalesTeamRatioRawDTO team1 = mock(SalesTeamRatioRawDTO.class);
		when(team1.getTeamName()).thenReturn("영업1팀");
		when(team1.getTeamAmount()).thenReturn(2500);

		SalesTeamRatioRawDTO team2 = mock(SalesTeamRatioRawDTO.class);
		when(team2.getTeamName()).thenReturn("영업2팀");
		when(team2.getTeamAmount()).thenReturn(7500);

		List<SalesTeamRatioRawDTO> rawList = List.of(team1, team2);

		when(salesDashboardQueryMapper.selectTeamSalesInPeriod(eq(start), eq(end))).thenReturn(rawList);

		// when
		List<SalesTeamRatioResponseDTO> result = service.getQuarterlyTeamSalesRatio(year, quarter);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getTeamName()).isEqualTo("영업1팀");
		assertThat(result.get(0).getTeamAmount()).isEqualTo(2500);
		assertThat(result.get(0).getRatio()).isEqualTo(25.0);

		assertThat(result.get(1).getTeamName()).isEqualTo("영업2팀");
		assertThat(result.get(1).getTeamAmount()).isEqualTo(7500);
		assertThat(result.get(1).getRatio()).isEqualTo(75.0);

		verify(salesDashboardQueryMapper).selectTeamSalesInPeriod(eq(start), eq(end));
	}

	@Test
	void 팀별_매출_비중_조회_연단위() {

		// given
		int year = 2024;
		LocalDate start = LocalDate.of(2024, 1, 1);
		LocalDate end = LocalDate.of(2024, 12, 31);

		SalesTeamRatioRawDTO team1 = mock(SalesTeamRatioRawDTO.class);
		when(team1.getTeamName()).thenReturn("영업1팀");
		when(team1.getTeamAmount()).thenReturn(4000);

		SalesTeamRatioRawDTO team2 = mock(SalesTeamRatioRawDTO.class);
		when(team2.getTeamName()).thenReturn("영업2팀");
		when(team2.getTeamAmount()).thenReturn(6000);

		List<SalesTeamRatioRawDTO> rawList = List.of(team1, team2);

		when(salesDashboardQueryMapper.selectTeamSalesInPeriod(eq(start), eq(end))).thenReturn(rawList);

		// when
		List<SalesTeamRatioResponseDTO> result = service.getYearlyTeamSalesRatio(year);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getTeamName()).isEqualTo("영업1팀");
		assertThat(result.get(0).getTeamAmount()).isEqualTo(4000);
		assertThat(result.get(0).getRatio()).isEqualTo(40.0);

		assertThat(result.get(1).getTeamName()).isEqualTo("영업2팀");
		assertThat(result.get(1).getTeamAmount()).isEqualTo(6000);
		assertThat(result.get(1).getRatio()).isEqualTo(60.0);

		verify(salesDashboardQueryMapper).selectTeamSalesInPeriod(eq(start), eq(end));
	}

	@Test
	void 팀별_매출_총액_조회_월단위() {

		// given
		int year = 2025;
		int month = 6;
		LocalDate start = LocalDate.of(year, month, 1);
		LocalDate end = start.withDayOfMonth(start.lengthOfMonth());

		List<SalesTeamAmountResponseDTO> mockResult = List.of(
			new SalesTeamAmountResponseDTO("영업1팀", 1000),
			new SalesTeamAmountResponseDTO("영업2팀", 2000)
		);

		when(salesDashboardQueryMapper.selectTeamSalesAmountInRange(eq(start), eq(end))).thenReturn(mockResult);

		// when
		List<SalesTeamAmountResponseDTO> result = service.getTeamSalesAmountByMonth(year, month);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getTeamName()).isEqualTo("영업1팀");
		assertThat(result.get(0).getTeamAmount()).isEqualTo(1000);
		assertThat(result.get(1).getTeamName()).isEqualTo("영업2팀");
		assertThat(result.get(1).getTeamAmount()).isEqualTo(2000);

		verify(salesDashboardQueryMapper).selectTeamSalesAmountInRange(eq(start), eq(end));
	}

	@Test
	void 팀별_매출_총액_조회_분기단위() {

		// given
		int year = 2025;
		int month = 2;
		LocalDate start = LocalDate.of(2025, 4, 1);
		LocalDate end = LocalDate.of(2025, 6, 30);

		List<SalesTeamAmountResponseDTO> mockResult = List.of(
			new SalesTeamAmountResponseDTO("영업1팀", 1000),
			new SalesTeamAmountResponseDTO("영업2팀", 2000)
		);

		when(salesDashboardQueryMapper.selectTeamSalesAmountInRange(eq(start), eq(end))).thenReturn(mockResult);

		// when
		List<SalesTeamAmountResponseDTO> result = service.getTeamSalesAmountByQuarter(year, month);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getTeamName()).isEqualTo("영업1팀");
		assertThat(result.get(0).getTeamAmount()).isEqualTo(1000);
		assertThat(result.get(1).getTeamName()).isEqualTo("영업2팀");
		assertThat(result.get(1).getTeamAmount()).isEqualTo(2000);

		verify(salesDashboardQueryMapper).selectTeamSalesAmountInRange(eq(start), eq(end));
	}

	@Test
	void 팀별_매출_총액_조회_연단위() {

		// given
		int year = 2025;
		LocalDate start = LocalDate.of(2025, 1, 1);
		LocalDate end = LocalDate.of(2025, 12, 31);

		List<SalesTeamAmountResponseDTO> mockResult = List.of(
			new SalesTeamAmountResponseDTO("영업1팀", 1000),
			new SalesTeamAmountResponseDTO("영업2팀", 2000)
		);

		when(salesDashboardQueryMapper.selectTeamSalesAmountInRange(eq(start), eq(end))).thenReturn(mockResult);

		// when
		List<SalesTeamAmountResponseDTO> result = service.getTeamSalesAmountByYear(year);

		// then
		assertThat(result).hasSize(2);
		assertThat(result.get(0).getTeamName()).isEqualTo("영업1팀");
		assertThat(result.get(0).getTeamAmount()).isEqualTo(1000);
		assertThat(result.get(1).getTeamName()).isEqualTo("영업2팀");
		assertThat(result.get(1).getTeamAmount()).isEqualTo(2000);

		verify(salesDashboardQueryMapper).selectTeamSalesAmountInRange(eq(start), eq(end));
	}
}
