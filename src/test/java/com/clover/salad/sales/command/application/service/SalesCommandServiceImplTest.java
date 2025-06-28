package com.clover.salad.sales.command.application.service;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

import com.clover.salad.contract.command.entity.ContractEntity;
import com.clover.salad.contract.command.repository.ContractRepository;
import com.clover.salad.sales.command.application.dto.SalesCommandDTO;
import com.clover.salad.sales.command.domain.aggregate.entity.SalesEntity;
import com.clover.salad.sales.command.domain.repository.SalesRepository;

@ExtendWith(MockitoExtension.class)
class SalesCommandServiceImplTest {

	@Mock
	private SalesRepository salesRepository;

	@Mock
	private ContractRepository contractRepository;

	@InjectMocks
	private SalesCommandServiceImpl salesCommandServiceImpl;

	@Test
	void 매출_등록_성공() {

		// given
		SalesCommandDTO dto = new SalesCommandDTO();
		dto.setSalesDate(LocalDate.now());
		dto.setDepartment("영업1팀");
		dto.setEmployeeName("홍길동");
		dto.setAmount(10000);
		dto.setContractId(1);

		when(contractRepository.existsById(1)).thenReturn(true);
		when(salesRepository.save(any(SalesEntity.class)))
			.thenReturn(SalesEntity.builder().id(1).build());

		// when
		int resultId = salesCommandServiceImpl.createSales(dto);

		// then
		assertEquals(1, resultId);
		verify(salesRepository).save(any(SalesEntity.class));
	}

	@Test
	public void 매출_등록_실패_계약없음() {

		// given
		SalesCommandDTO dto = new SalesCommandDTO();
		dto.setContractId(999);

		when(contractRepository.existsById(999)).thenReturn(false);

		// when // then
		assertThatThrownBy(() -> salesCommandServiceImpl.createSales(dto))
			.isInstanceOf(IllegalArgumentException.class)
			.hasMessage("해당 계약은 존재하지 않습니다.");
	}

	@Test
	void 매출_삭제_성공() {

		// given
		SalesEntity salesEntity = SalesEntity.builder()
			.id(1)
			.isDeleted(false)
			.build();

		when(salesRepository.findById(1)).thenReturn(Optional.of(salesEntity));
		when(salesRepository.save(any(SalesEntity.class))).thenReturn(salesEntity);

		// when
		salesCommandServiceImpl.deleteSales(1);

		// then
		assertTrue(salesEntity.isDeleted());
		verify(salesRepository).save(salesEntity);

	}

	@Test
	public void 매출_삭제_실패_존재하지않는ID() {

		// given
		when(salesRepository.findById(999)).thenReturn(Optional.empty());

		// when // then
		assertThatThrownBy(() -> salesCommandServiceImpl.deleteSales(999))
			.isInstanceOf(RuntimeException.class)
			.hasMessage("존재하지 않는 매출입니다.");
	}
}
