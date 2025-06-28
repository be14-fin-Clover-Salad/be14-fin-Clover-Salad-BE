package com.clover.salad.sales.command.application.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.clover.salad.sales.command.application.dto.SalesCommandDTO;
import com.clover.salad.sales.command.domain.aggregate.entity.SalesEntity;
import com.clover.salad.sales.command.domain.repository.SalesRepository;

class SalesCommandServiceImplTest {

	@Mock
	private SalesRepository salesRepository;

	@InjectMocks
	private SalesCommandServiceImpl salesCommandServiceImpl;

	public SalesCommandServiceImplTest() {
		MockitoAnnotations.openMocks(this);
	}

	@Test
	void 매출_생성_성공() {

		// given
		SalesCommandDTO salesCommandDTO = new SalesCommandDTO();
		salesCommandDTO.setSalesDate(LocalDate.now());
		salesCommandDTO.setDepartment("영업1팀");
		salesCommandDTO.setEmployeeName("홍길동");
		salesCommandDTO.setAmount(10000);
		salesCommandDTO.setContractId(1);

		SalesEntity salesEntity = SalesEntity.builder()
			.id(1)
			.salesDate(salesCommandDTO.getSalesDate())
			.department(salesCommandDTO.getDepartment())
			.employeeName(salesCommandDTO.getEmployeeName())
			.amount(salesCommandDTO.getAmount())
			.contractId(salesCommandDTO.getContractId())
			.isDeleted(false)
			.build();

		when(salesRepository.save(any(SalesEntity.class))).thenReturn(salesEntity);

		// when
		int resultId = salesCommandServiceImpl.createSales(salesCommandDTO);

		// then
		assertEquals(1, resultId);
		verify(salesRepository).save(any(SalesEntity.class));
	}

	@Test
	void 매출_삭제_성공() {

		// given
		int id = 1;
		SalesEntity salesEntity = SalesEntity.builder()
			.id(id)
			.isDeleted(false)
			.build();

		when(salesRepository.findById(id)).thenReturn(Optional.of(salesEntity));

		// when
		salesCommandServiceImpl.deleteSales(id);

		// then
		assertTrue(salesEntity.isDeleted());
		verify(salesRepository).save(salesEntity);

	}
}
