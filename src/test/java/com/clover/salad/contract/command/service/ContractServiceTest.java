package com.clover.salad.contract.command.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import com.clover.salad.contract.command.dto.*;
import com.clover.salad.contract.command.entity.*;
import com.clover.salad.contract.command.repository.*;
import com.clover.salad.contract.common.ContractStatus;
import com.clover.salad.customer.command.application.dto.*;
import com.clover.salad.customer.command.application.service.CustomerCommandService;
import com.clover.salad.customer.command.domain.aggregate.entity.Customer;
import com.clover.salad.customer.command.domain.repository.CustomerRepository;
import com.clover.salad.employee.command.domain.aggregate.entity.EmployeeEntity;
import com.clover.salad.employee.command.domain.repository.EmployeeRepository;
import com.clover.salad.product.command.domain.aggregate.entity.Product;
import com.clover.salad.product.command.domain.repository.ProductRepository;
import com.clover.salad.security.SecurityUtil;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.*;

@DisplayName("ContractService 단위 테스트")
class ContractServiceTest {

	@Mock
	private ContractRepository contractRepository;
	@Mock
	private ProductRepository productRepository;
	@Mock
	private ContractProductRepository contractProductRepository;
	@Mock
	private ContractFileHistoryRepository contractFileHistoryRepository;
	@Mock
	private CustomerCommandService customerCommandService;
	@Mock
	private CustomerRepository customerRepository;
	@Mock
	private EmployeeRepository employeeRepository;

	@InjectMocks
	private ContractService contractService;

	private AutoCloseable closeable;

	private CustomerDTO customerDTO;
	private ContractDTO contractDTO;
	private ProductDTO productDTO1;
	private ProductDTO productDTO2;
	private ContractUploadRequestDTO uploadRequestDTO;

	@BeforeEach
	void setUp() {
		closeable = MockitoAnnotations.openMocks(this);

		customerDTO = CustomerDTO.builder()
			.name("홍길동")
			.birthdate("1990-01-01")
			.phone("01012345678")
			.address("서울시 강남구")
			.email("hong@example.com")
			.customerType(null)
			.build();

		contractDTO = ContractDTO.builder()
			.startDate(LocalDate.of(2024, 1, 1))
			.endDate(LocalDate.of(2024, 12, 31))
			.amount(100000)
			.bankName("국민은행")
			.bankAccount("1234567890")
			.depositOwner("홍길동")
			.relationship("본인")
			.paymentEmail("pay@example.com")
			.paymentDay(25)
			.build();

		productDTO1 = ProductDTO.builder()
			.productName("공기청정기")
			.quantity(1)
			.modelName("AC1000")
			.manufacturer("삼성")
			.build();

		productDTO2 = ProductDTO.builder()
			.productName("냉장고")
			.quantity(2)
			.modelName("RF3000")
			.manufacturer("LG")
			.build();

		uploadRequestDTO = ContractUploadRequestDTO.builder()
			.customer(customerDTO)
			.contract(contractDTO)
			.products(List.of(productDTO1, productDTO2))
			.documentOrigin(null)
			.build();
	}

	@Test
	@DisplayName("신규 고객 등록 후 계약 저장 정상 처리")
	void registerContract_newCustomer() {
		// 신규 고객 조회시 Optional.empty() (최초 한 번만)
		when(customerRepository.findTopByNameAndBirthdateAndPhoneOrderByRegisterAtDesc(
			anyString(), anyString(), anyString()))
			.thenReturn(Optional.empty())
			.thenReturn(Optional.of(mock(Customer.class))); // 이후 조회 시 신규 고객 리턴

		// customerCommandService.registerCustomer 호출 시 동작만 확인용
		doAnswer(invocation -> null)
			.when(customerCommandService).registerCustomer(any(), eq(true));

		int fakeEmployeeId = 456;
		try (MockedStatic<SecurityUtil> securityMock = Mockito.mockStatic(SecurityUtil.class)) {
			securityMock.when(SecurityUtil::getEmployeeId).thenReturn(fakeEmployeeId);

			EmployeeEntity emp = mock(EmployeeEntity.class);
			when(employeeRepository.findById(fakeEmployeeId)).thenReturn(Optional.of(emp));

			ArgumentCaptor<ContractEntity> contractCaptor = ArgumentCaptor.forClass(ContractEntity.class);
			ContractEntity savedContract = mock(ContractEntity.class);
			when(contractRepository.save(contractCaptor.capture())).thenReturn(savedContract);

			Product prod1 = mock(Product.class);
			Product prod2 = mock(Product.class);
			when(productRepository.findByNameAndSerialNumber(productDTO1.getProductName(), productDTO1.getModelName()))
				.thenReturn(Optional.of(prod1));
			when(productRepository.findByNameAndSerialNumber(productDTO2.getProductName(), productDTO2.getModelName()))
				.thenReturn(Optional.of(prod2));
			when(contractProductRepository.save(any())).thenAnswer(i -> i.getArgument(0));

			ContractEntity result = contractService.registerContract(uploadRequestDTO);

			// 신규 고객 등록 호출 검증
			verify(customerCommandService, times(1)).registerCustomer(any(CustomerCreateRequest.class), eq(true));
			verify(customerCommandService, never()).updateCustomer(anyInt(), any(), anyBoolean());

			verify(employeeRepository, times(1)).findById(fakeEmployeeId);
			verify(contractRepository, times(1)).save(any(ContractEntity.class));
			verify(contractProductRepository, times(2)).save(any(ContractProductEntity.class));

			assertSame(savedContract, result);

			String code = contractCaptor.getValue().getCode();
			assertTrue(code.startsWith("C-"), "계약 코드는 C-로 시작해야 한다");
		}
	}

	@Test
	@DisplayName("기존 고객 있을 때 고객 업데이트 후 계약 저장")
	void registerContract_existingCustomer() {
		Customer existingCustomer = mock(Customer.class);
		when(existingCustomer.getId()).thenReturn(999);
		when(customerRepository.findTopByNameAndBirthdateAndPhoneOrderByRegisterAtDesc(
			anyString(), anyString(), anyString())).thenReturn(Optional.of(existingCustomer));

		int fakeEmployeeId = 111;
		try (MockedStatic<SecurityUtil> securityMock = Mockito.mockStatic(SecurityUtil.class)) {
			securityMock.when(SecurityUtil::getEmployeeId).thenReturn(fakeEmployeeId);

			EmployeeEntity emp = mock(EmployeeEntity.class);
			when(employeeRepository.findById(fakeEmployeeId)).thenReturn(Optional.of(emp));

			ContractEntity savedContract = mock(ContractEntity.class);
			when(contractRepository.save(any(ContractEntity.class))).thenReturn(savedContract);

			Product prod1 = mock(Product.class);
			Product prod2 = mock(Product.class);
			when(productRepository.findByNameAndSerialNumber(productDTO1.getProductName(), productDTO1.getModelName()))
				.thenReturn(Optional.of(prod1));
			when(productRepository.findByNameAndSerialNumber(productDTO2.getProductName(), productDTO2.getModelName()))
				.thenReturn(Optional.of(prod2));

			when(contractProductRepository.save(any())).thenAnswer(i -> i.getArgument(0));

			ContractEntity result = contractService.registerContract(uploadRequestDTO);

			verify(customerCommandService, never()).registerCustomer(any(), anyBoolean());
			verify(customerCommandService, times(1)).updateCustomer(eq(existingCustomer.getId()), any(), eq(true));

			verify(contractRepository).save(any(ContractEntity.class));
			verify(contractProductRepository, times(2)).save(any(ContractProductEntity.class));

			assertSame(savedContract, result);
		}
	}

	@Test
	@DisplayName("validate()는 존재하지 않는 상품이면 예외 발생")
	void validate_nonexistentProduct_throws() {
		ProductDTO validProduct = productDTO1;
		ProductDTO invalidProduct = ProductDTO.builder()
			.productName("없는상품")
			.modelName("XYZ123")
			.quantity(1)
			.build();

		ContractUploadRequestDTO dto = ContractUploadRequestDTO.builder()
			.customer(customerDTO)
			.contract(contractDTO)
			.products(List.of(validProduct, invalidProduct))
			.build();

		when(productRepository.findByNameAndSerialNumber(validProduct.getProductName(), validProduct.getModelName()))
			.thenReturn(Optional.of(mock(Product.class)));

		when(productRepository.findByNameAndSerialNumber(invalidProduct.getProductName(), invalidProduct.getModelName()))
			.thenReturn(Optional.empty());

		IllegalArgumentException ex = assertThrows(IllegalArgumentException.class,
			() -> contractService.validate(dto));

		assertTrue(ex.getMessage().contains("존재하지 않는 상품입니다"));
	}

	@Test
	@DisplayName("markContractDeleted()는 상태 변경 후 반환")
	void markContractDeleted_changesStatus() {
		ContractEntity contract = new ContractEntity();
		contract.setId(123);
		contract.setStatus(ContractStatus.PENDING);
		contract.setDeleted(false);

		when(contractRepository.findById(123)).thenReturn(Optional.of(contract));

		ContractEntity result = contractService.markContractDeleted(123);

		assertEquals(ContractStatus.INVALID, result.getStatus());
		assertTrue(result.isDeleted());
	}

	@Test
	@DisplayName("markContractDeleted() 계약 없으면 예외")
	void markContractDeleted_noContract_throws() {
		when(contractRepository.findById(anyInt())).thenReturn(Optional.empty());

		assertThrows(IllegalArgumentException.class, () -> contractService.markContractDeleted(999));
	}

	@Test
	@DisplayName("getNextVersion()는 히스토리 조회 후 버전 +1 반환")
	void getNextVersion_returnsNext() {
		int replacedId = 5;
		int rootId = 3;

		ContractFileHistory rootHistory = mock(ContractFileHistory.class);
		ContractEntity replacedContract = mock(ContractEntity.class);

		when(rootHistory.getReplacedContract()).thenReturn(null);
		when(rootHistory.getContract()).thenReturn(replacedContract);
		when(replacedContract.getId()).thenReturn(rootId);

		when(contractFileHistoryRepository.findByContract_Id(replacedId)).thenReturn(Optional.of(rootHistory));

		when(contractFileHistoryRepository.findByContract_Id(rootId)).thenReturn(Optional.of(rootHistory));

		when(contractFileHistoryRepository.findMaxVersionByReplacedContractId(rootId)).thenReturn(Optional.of(7));

		int nextVersion = contractService.getNextVersion(replacedId);
		assertEquals(1, nextVersion);
	}

	@Test
	@DisplayName("updateEtcOnly()는 etc 필드 업데이트 후 DTO 반환")
	void updateEtcOnly_updatesAndReturns() {
		ContractEntity contract = new ContractEntity();
		contract.setId(100);
		contract.setEtc("기존내용");

		when(contractRepository.findById(100)).thenReturn(Optional.of(contract));
		when(contractRepository.save(any())).thenReturn(contract);

		ContractUpdateResponseDTO res = contractService.updateEtcOnly(100, "새로운메모");

		assertEquals(100, res.getId());
		assertEquals("새로운메모", res.getEtc());
		assertEquals("새로운메모", contract.getEtc());
	}

	@Test
	@DisplayName("updateEtcOnly() 계약 없으면 예외 발생")
	void updateEtcOnly_noContract_throws() {
		when(contractRepository.findById(anyInt())).thenReturn(Optional.empty());

		assertThrows(IllegalArgumentException.class, () -> contractService.updateEtcOnly(999, "메모"));
	}

	@Test
	@DisplayName("deleteContract()는 삭제 플래그 설정 후 DTO 반환")
	void deleteContract_setsDeletedTrue() {
		ContractEntity contract = new ContractEntity();
		contract.setId(200);
		contract.setDeleted(false);

		when(contractRepository.findById(200)).thenReturn(Optional.of(contract));
		when(contractRepository.save(any())).thenReturn(contract);

		ContractDeleteResponseDTO res = contractService.deleteContract(200);

		assertEquals(200, res.getId());
		assertTrue(res.isDeleted());
		assertTrue(contract.isDeleted());
	}

	@Test
	@DisplayName("deleteContract() 계약 없으면 예외 발생")
	void deleteContract_noContract_throws() {
		when(contractRepository.findById(anyInt())).thenReturn(Optional.empty());

		assertThrows(IllegalArgumentException.class, () -> contractService.deleteContract(999));
	}
}
