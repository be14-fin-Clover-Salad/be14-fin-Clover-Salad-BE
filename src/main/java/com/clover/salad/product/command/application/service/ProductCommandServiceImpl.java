package com.clover.salad.product.command.application.service;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.clover.salad.common.file.entity.FileUploadEntity;
import com.clover.salad.common.file.enums.FileUploadType;
import com.clover.salad.common.file.service.FileStorageService;
import com.clover.salad.common.file.service.FileUploadService;
import com.clover.salad.product.command.application.dto.ProductDTO;
import com.clover.salad.product.command.application.dto.ProductImageDTO;
import com.clover.salad.product.command.domain.aggregate.entity.Product;
import com.clover.salad.product.command.domain.repository.ProductRepository;
import com.clover.salad.security.SecurityUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductCommandServiceImpl implements ProductCommandService {
	private final ProductRepository productRepository;
	private final FileUploadService fileUploadService;
	
	@Override
	public void registerProduct(ProductDTO productDTO) {
		Product product = new Product();
		productDTOToProduct(productDTO, product);
		productRepository.save(product);
	}
	
	@Override
	public void updateProduct(int productId, ProductDTO productDTO) {
		validateAdmin();

		Product product = productRepository.findById(productId).orElseThrow();
		productDTOToProduct(productDTO, product);
		productRepository.save(product);
	}
	
	@Override
	public String deleteProduct(int productId) {
		validateAdmin();

		Product product = productRepository.findById(productId).orElseThrow();
		product.setDeleted(true);
		productRepository.save(product);
		return product.getName();
	}

	@Override
	public ProductImageDTO uploadProductImage(MultipartFile file, FileUploadType type) throws IOException {
		log.info("[ProductCommandService] 파일 업로드 요청 - type={}, originalFilename={}", type, file.getOriginalFilename());

		FileUploadEntity upload = fileUploadService.uploadAndSave(file, type);

		log.info("[ProductCommandService] 업로드 완료 - id={}, renameFile={}, url={}",
			upload.getId(), upload.getRenameFile(), upload.getPath());

		return ProductImageDTO.builder()
			.fileUploadId(upload.getId())
			.fileName(upload.getRenameFile())
			.fileUrl(upload.getPath())
			.build();
	}
	
	private void productDTOToProduct(ProductDTO productDTO, Product product) {
		product.setCategory(productDTO.getCategory());
		product.setName(productDTO.getName());
		product.setSerialNumber(productDTO.getSerialNumber());
		product.setProductCode(productDTO.getProductCode());
		product.setCompany(productDTO.getCompany());
		product.setOriginCost(productDTO.getOriginCost());
		product.setRentalCost(productDTO.getRentalCost());
		product.setDescription(productDTO.getDescription());
		product.setFileUploadId(productDTO.getFileUploadId());
	}

	private void validateAdmin() {
		if (!SecurityUtil.hasRole("ROLE_ADMIN")) {
			throw new SecurityException("관리자만 상품을 수정 또는 삭제할 수 있습니다.");
		}
	}
}
