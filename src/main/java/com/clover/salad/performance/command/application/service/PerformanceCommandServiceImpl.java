package com.clover.salad.performance.command.application.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.modelmapper.Converter;
import org.modelmapper.ModelMapper;
import org.modelmapper.spi.DestinationSetter;
import org.modelmapper.spi.SourceGetter;
import org.springframework.stereotype.Service;

import com.clover.salad.common.exception.EmployeeNotFoundException;
import com.clover.salad.consult.query.dto.ConsultQueryDTO;
import com.clover.salad.consult.query.service.ConsultQueryService;
import com.clover.salad.contract.command.entity.ContractProductEntity;
import com.clover.salad.contract.command.repository.ContractProductRepository;
import com.clover.salad.contract.common.ContractStatus;
import com.clover.salad.contract.query.dto.ContractDTO;
import com.clover.salad.contract.query.dto.ContractSearchDTO;
import com.clover.salad.contract.query.service.ContractService;
import com.clover.salad.customer.query.dto.CustomerQueryDTO;
import com.clover.salad.customer.query.service.CustomerQueryService;
import com.clover.salad.employee.command.domain.repository.DepartmentRepository;
import com.clover.salad.employee.query.dto.EmployeeSearchRequestDTO;
import com.clover.salad.employee.query.dto.EmployeeSearchResponseDTO;
import com.clover.salad.employee.query.service.EmployeeQueryService;
import com.clover.salad.performance.command.application.dto.DepartmentPerformanceDTO;
import com.clover.salad.performance.command.application.dto.EmployeePerformanceDTO;
import com.clover.salad.performance.command.domain.aggregate.entity.DepartmentPerformance;
import com.clover.salad.performance.command.domain.aggregate.entity.EmployeePerformance;
import com.clover.salad.performance.command.domain.repository.DepartmentPerformanceRepository;
import com.clover.salad.performance.command.domain.repository.EmployeePerformanceRepository;
import com.clover.salad.performance.query.service.PerformanceQueryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PerformanceCommandServiceImpl implements PerformanceCommandService {

	private final EmployeePerformanceRepository employeePerformanceRepository;
	private final EmployeeQueryService employeeQueryService;
	private final ContractService contractService;
	private final CustomerQueryService customerQueryService;
	private final DepartmentRepository departmentRepository;
	private final DepartmentPerformanceRepository departmentPerformanceRepository;
	private final PerformanceQueryService performanceQueryService;
	private final ContractProductRepository contractProductRepository;
	private final ModelMapper modelMapper;
	private final ConsultQueryService consultQueryService;
	
	@Override
	public void refreshEmployeePerformance(String employeeCode, int targetDate) {
		int employeeId = getEmployeeByCode(employeeCode).getId();

		YearMonth yearMonth = YearMonth.of(targetDate / 100, targetDate % 100);
		YearMonth yearBeforeMonth = yearMonth.minusMonths(1);
		LocalDate endDateStart = yearMonth.atDay(1);
		LocalDate startDateEnd = yearMonth.atEndOfMonth();
		LocalDate lastMonthStartDateEnd = yearBeforeMonth.atEndOfMonth();

		EmployeePerformance currentEP = employeePerformanceRepository.findByEmployeeIdAndTargetDate(employeeId, targetDate);

		/* 계약 조회를 위한 검색 조건 생성 */
		ContractSearchDTO lastMonthContractSearchDTO = ContractSearchDTO.builder()
			.employeeId(employeeId)
			.status(ContractStatus.IN_CONTRACT.getLabel())
			.endDateStart(endDateStart)
			.startDateEnd(lastMonthStartDateEnd)
			.build();

		List<ContractDTO> lastMonthContractDTOList = contractService.searchContracts(employeeId, lastMonthContractSearchDTO);
		
		ContractSearchDTO terminatedContractSearchDTO = ContractSearchDTO.builder()
			.employeeId(employeeId)
			.status(ContractStatus.TERMINATED.getLabel())
			.endDateStart(endDateStart)
			.startDateEnd(lastMonthStartDateEnd)
			.build();
		
		List<ContractDTO> terminatedContractDTOList = contractService.searchContracts(employeeId, terminatedContractSearchDTO);
		
		ContractSearchDTO currentContractSearchDTO = ContractSearchDTO.builder()
			.employeeId(employeeId)
			.status(ContractStatus.IN_CONTRACT.getLabel())
			.endDateStart(endDateStart)
			.startDateEnd(startDateEnd)
			.build();

		List<ContractDTO> currentContractDTOList = contractService.searchContracts(employeeId, currentContractSearchDTO);

		int rentalProductCount = 0;

		/* totalRentalCount 저번 달부터 있던 '계약중' 계약 수 + '중도해지' 계약 수 */
		int totalRentalCount = lastMonthContractDTOList.size() + terminatedContractDTOList.size();

		/* rentalRetentionCount 저번 달부터 있던 '계약중' 계약 수 */
		int rentalRetentionCount = lastMonthContractDTOList.size();

		/* 총 계약 금액을 저장할 변수 */
		long totalRentalAmount = 0L;

		/* 새로운 고객을 중복없이 저장하기 위한 Set */
		Set<Integer> newCustomerIdSet = new HashSet<>();

		for (ContractDTO contractDTO : currentContractDTOList) {
			/* rentalProductCount 렌탈 상품 수 */
			List<ContractProductEntity> cpEntityList = contractProductRepository.findByContractId(contractDTO.getId());
			for (ContractProductEntity cpEntity : cpEntityList) {
				rentalProductCount += cpEntity.getQuantity();
			}
			
			/* newCustomerCount 신규 고객 수: 리스트로 만들고 id 개수를 세는 로직 */
			int currentCustomerId = contractDTO.getCustomerId();
			CustomerQueryDTO currentCustomer = customerQueryService.findCurrentOnly(currentCustomerId);
			if (currentCustomer.getRegisterAt().isAfter(endDateStart)
			 || currentCustomer.getRegisterAt().isEqual(endDateStart)) {
				newCustomerIdSet.add(currentCustomerId);
			}
			/* totalRentalAmount 총 렌탈 금액 */
			totalRentalAmount += contractDTO.getAmount();
		}
		
		/* customerFeedbackScore 피드백 점수 총합 */
		int customerFeedbackScore = 0;
		
		/* customerFeedbackCount 피드백 한 사람 수 */
		int customerFeedbackCount = 0;
		
		List<ConsultQueryDTO> consultList = consultQueryService.findCurrentOnly(employeeId);
		for (ConsultQueryDTO consultDTO : consultList) {
			LocalDateTime consultTime = LocalDateTime.parse(consultDTO.getConsultAt(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			if (consultDTO.getFeedbackScore() != null
			 && consultTime.isAfter(endDateStart.atStartOfDay())
			 && consultTime.isEqual(endDateStart.atStartOfDay())
			) {
				customerFeedbackScore += consultDTO.getFeedbackScore();
				customerFeedbackCount++;
			}
		}
		
		EmployeePerformanceDTO epDTO = EmployeePerformanceDTO.builder()
			.employeeId(employeeId)
			.targetDate(targetDate)
			.rentalProductCount(rentalProductCount)
			.rentalRetentionCount(rentalRetentionCount)
			.totalRentalCount(totalRentalCount)
			.newCustomerCount(newCustomerIdSet.size())
			.totalRentalAmount(totalRentalAmount)
			.customerFeedbackScore(customerFeedbackScore)
			.customerFeedbackCount(customerFeedbackCount)
			.build();
		
		/* 조회 시 없으면 새로 만들기, 있으면 업데이트하기 */
		mapIntToDividedDoubleAndIgnoreId(
			EmployeePerformanceDTO.class,
			EmployeePerformance.class,
			EmployeePerformanceDTO::getCustomerFeedbackScore,
			EmployeePerformance::setCustomerFeedbackScore,
			EmployeePerformance::setId
		);
		if (currentEP == null) {
			log.info("사원 코드 {}의 개인 실적 생성: {}", employeeCode, targetDate);
			EmployeePerformance newEP = modelMapper.map(epDTO, EmployeePerformance.class);
			employeePerformanceRepository.save(newEP);
		} else {
			log.info("사원 코드 {}의 개인 실적 갱신: {}", employeeCode, targetDate);
			modelMapper.map(epDTO, currentEP);
			employeePerformanceRepository.save(currentEP);
		}
	}

	@Override
	public void refreshDepartmentPerformance(String deptName, int targetDate) {
		int deptId = departmentRepository.findByName(deptName).getId();

		DepartmentPerformance currentDP = departmentPerformanceRepository.findByDepartmentIdAndTargetDate(deptId, targetDate);

		int dpRentalProductCount = 0;
		int dpRentalRetentionCount = 0;
		int dpTotalRentalCount = 0;
		int dpNewCustomerCount = 0;
		long dpTotalRentalAmount = 0L;
		int dpCustomerFeedbackScore = 0;
		int dpCustomerFeedbackCount = 0;

		List<EmployeePerformanceDTO> employeePerformanceDTOList =
			performanceQueryService.searchEmployeePerformanceByTargetDateAndDepartmentId(targetDate, deptId);
		for (EmployeePerformanceDTO epDTO : employeePerformanceDTOList) {
			dpRentalProductCount += epDTO.getRentalProductCount();
			dpRentalRetentionCount += epDTO.getRentalRetentionCount();
			dpTotalRentalCount += epDTO.getTotalRentalCount();
			dpNewCustomerCount += epDTO.getNewCustomerCount();
			dpTotalRentalAmount += epDTO.getTotalRentalAmount();
			dpCustomerFeedbackScore += epDTO.getCustomerFeedbackScore();
			dpCustomerFeedbackCount += epDTO.getCustomerFeedbackCount();
		}
		DepartmentPerformanceDTO dpDTO = DepartmentPerformanceDTO.builder()
			.departmentId(deptId)
			.targetDate(targetDate)
			.rentalProductCount(dpRentalProductCount)
			.rentalRetentionCount(dpRentalRetentionCount)
			.totalRentalCount(dpTotalRentalCount)
			.newCustomerCount(dpNewCustomerCount)
			.totalRentalAmount(dpTotalRentalAmount)
			.customerFeedbackScore(dpCustomerFeedbackScore)
			.customerFeedbackCount(dpCustomerFeedbackCount)
			.build();

		/* 조회 시 없으면 새로 만들기, 있으면 업데이트하기 */
		mapIntToDividedDoubleAndIgnoreId(
			DepartmentPerformanceDTO.class,
			DepartmentPerformance.class,
			DepartmentPerformanceDTO::getCustomerFeedbackScore,
			DepartmentPerformance::setCustomerFeedbackScore,
			DepartmentPerformance::setId
		);
		if (currentDP == null) {
			log.info("{} 팀 실적 생성: {}", deptName, targetDate);
			DepartmentPerformance newDP = modelMapper.map(dpDTO, DepartmentPerformance.class);
			departmentPerformanceRepository.save(newDP);
		} else {
			log.info("{} 팀 실적 갱신: {}", deptName, targetDate);
			modelMapper.map(dpDTO, currentDP);
			departmentPerformanceRepository.save(currentDP);
		}
	}

	public <S, D> void mapIntToDividedDoubleAndIgnoreId(
		Class<S> sourceClass,
		Class<D> destClass,
		SourceGetter<S> sourceGetter,
		DestinationSetter<D, Double> destSetter,
		DestinationSetter<D, Integer> idSetter
	) {
		/*
		 * dto에서는 10을 곱해 int 값으로 사용하던 customerFeedbackScore를
		 * entity를 통해 DB에 넣을 때 10으로 나누기
		 * */
		Converter<Integer, Double> converter = ctx -> {
			Integer source = ctx.getSource();
			return (source == null) ? null : source / 10.0;
		};

		modelMapper.typeMap(sourceClass, destClass)
			.addMappings(m -> m.using(converter).map(sourceGetter, destSetter))
			.addMappings(mapper -> mapper.skip(idSetter));
	}

	private EmployeeSearchResponseDTO getEmployeeByCode(String employeeCode) throws EmployeeNotFoundException {
		EmployeeSearchRequestDTO searchDTO = new EmployeeSearchRequestDTO();
		searchDTO.setCode(employeeCode);
		List<EmployeeSearchResponseDTO> employeeList = employeeQueryService.searchEmployees(searchDTO);
		if (employeeList.isEmpty()) throw new EmployeeNotFoundException();
		return employeeList.get(0);
	}
}
