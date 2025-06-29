package com.clover.salad.product.command.application.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.io.IOException;
import java.util.Optional;

import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.common.file.enums.FileUploadType;
import com.clover.salad.common.file.service.FileUploadService;
import com.clover.salad.product.command.application.dto.ProductDTO;
import com.clover.salad.product.command.application.dto.ProductImageDTO;
import com.clover.salad.product.command.domain.aggregate.entity.Product;
import com.clover.salad.product.command.domain.repository.ProductRepository;
import com.clover.salad.security.SecurityUtil;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.multipart.MultipartFile;

@ExtendWith(MockitoExtension.class)
class ProductCommandServiceImplTest {
	
	private final ProductDTO sampleProductDTO = new ProductDTO();
	@InjectMocks
	private ProductCommandServiceImpl productCommandService;
	@Mock
	private ProductRepository productRepository;
	@Mock
	private FileUploadService fileUploadService;
	@Spy
	private Product product = new Product();
	
	@BeforeEach
	void setUp() {
		ProductDTO sampleProductDTO = new ProductDTO();
		sampleProductDTO.setCategory("카테고리");
		sampleProductDTO.setName("상품명");
		sampleProductDTO.setSerialNumber("S1234");
		sampleProductDTO.setProductCode("P001");
		sampleProductDTO.setCompany("회사");
		sampleProductDTO.setOriginCost(1000);
		sampleProductDTO.setRentalCost(200);
		sampleProductDTO.setDescription("설명");
		sampleProductDTO.setFileUploadId(1);
	}
	
	@Test
	void testRegisterProduct_Success() {
		// when
		productCommandService.registerProduct(sampleProductDTO);
		
		// then
		verify(productRepository).save(any(Product.class));
	}
	
	@Test
	void testUpdateProduct_Success() {
		// given
		try (MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
			mockedSecurityUtil.when(() -> SecurityUtil.hasRole("ROLE_ADMIN")).thenReturn(true);
			when(productRepository.findById(1)).thenReturn(Optional.of(product));
			
			// when
			productCommandService.updateProduct(1, sampleProductDTO);
			
			// then
			verify(productRepository).save(product);
		}
	}
	
	@Test
	void testUpdateProduct_NotAdmin_ShouldThrow() {
		try (MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
			mockedSecurityUtil.when(() -> SecurityUtil.hasRole("ROLE_ADMIN")).thenReturn(false);
			
			assertThrows(SecurityException.class, () -> productCommandService.updateProduct(1, sampleProductDTO));
		}
	}
	
	@Test
	void testDeleteProduct_Success() {
	    try (MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
	        mockedSecurityUtil.when(() -> SecurityUtil.hasRole("ROLE_ADMIN")).thenReturn(true);  // << 관리자 권한 true 로 변경
	        
	        Product product = new Product();
	        product.setName("테스트상품");
	        when(productRepository.findById(1)).thenReturn(Optional.of(product));
	        
	        // when
	        String result = productCommandService.deleteProduct(1);
	        
	        // then
	        verify(productRepository).save(product);
	        assertTrue(product.isDeleted());
	        assertEquals("테스트상품", result);
	    }
	}
	
	@Test
	void testDeleteProduct_NotAdmin_ShouldThrow() {
		// given
		try (MockedStatic<SecurityUtil> mockedSecurityUtil = mockStatic(SecurityUtil.class)) {
			mockedSecurityUtil.when(() -> SecurityUtil.hasRole("ROLE_ADMIN")).thenReturn(false);
			
			// then
			assertThrows(SecurityException.class, () ->
				productCommandService.deleteProduct(1)
			);
		}
	}
	
	@Test
	void testUploadProductImage_Success() throws IOException {
		// given
		MultipartFile file = mock(MultipartFile.class);
		FileUploadEntity upload = mock(FileUploadEntity.class);
		when(upload.getId()).thenReturn(1);
		when(upload.getRenameFile()).thenReturn("renamed.jpg");
		when(upload.getPath()).thenReturn("/images/renamed.jpg");
		
		when(file.getOriginalFilename()).thenReturn("original.jpg");
		when(fileUploadService.uploadAndSave(file, FileUploadType.PRODUCT))
			.thenReturn(upload);
		
		// when
		ProductImageDTO result = productCommandService.uploadProductImage(file, FileUploadType.PRODUCT);
		
		// then
		assertEquals(1, result.getFileUploadId());
		assertEquals("renamed.jpg", result.getFileName());
		assertEquals("/images/renamed.jpg", result.getFileUrl());
	}
}
