package com.clover.salad.product.query.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.clover.salad.common.exception.NotFoundException;
import com.clover.salad.product.command.application.dto.ProductDTO;
import com.clover.salad.product.command.application.dto.SearchTermDTO;
import com.clover.salad.product.query.mapper.ProductMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductQueryServiceImpl implements ProductQueryService {
	private final ProductMapper productMapper;
	
	@Override
	public ProductDTO searchProductById(int productId) {
		ProductDTO product = productMapper.selectProductById(productId);
		if (product != null) {
			return product;
		} else {
			throw new NotFoundException("상품 검색 실패");
		}
	}
	
	@Override
	public List<ProductDTO> searchProductList(SearchTermDTO searchTerm) {
		return productMapper.selectProductList(searchTerm);
	}
}
