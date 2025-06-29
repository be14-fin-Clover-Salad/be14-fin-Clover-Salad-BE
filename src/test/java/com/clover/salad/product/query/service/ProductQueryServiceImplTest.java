package com.clover.salad.product.query.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.List;

import com.clover.salad.common.exception.NotFoundException;
import com.clover.salad.product.command.application.dto.ProductDTO;
import com.clover.salad.product.command.application.dto.SearchTermDTO;
import com.clover.salad.product.query.mapper.ProductMapper;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class ProductQueryServiceImplTest {

    @InjectMocks
    private ProductQueryServiceImpl productQueryService;

    @Mock
    private ProductMapper productMapper;

    @Test
    void testSearchProductById_Found() {
        // given
        int productId = 1;
        ProductDTO productDTO = new ProductDTO();
        productDTO.setName("Test Product");
        when(productMapper.selectProductById(productId)).thenReturn(productDTO);

        // when
        ProductDTO result = productQueryService.searchProductById(productId);

        // then
        assertNotNull(result);
        assertEquals("Test Product", result.getName());
        verify(productMapper).selectProductById(productId);
    }

    @Test
    void testSearchProductById_NotFound() {
        // given
        int productId = 99;
        when(productMapper.selectProductById(productId)).thenReturn(null);

        // when & then
        NotFoundException exception = assertThrows(NotFoundException.class, () -> {
            productQueryService.searchProductById(productId);
        });
        assertEquals("상품 검색 실패", exception.getMessage());
        verify(productMapper).selectProductById(productId);
    }

    @Test
    void testSearchProductList() {
        // given
        SearchTermDTO searchTerm = new SearchTermDTO();
        when(productMapper.selectProductList(searchTerm)).thenReturn(List.of(new ProductDTO(), new ProductDTO()));

        // when
        List<ProductDTO> result = productQueryService.searchProductList(searchTerm);

        // then
        assertNotNull(result);
        assertEquals(2, result.size());
        verify(productMapper).selectProductList(searchTerm);
    }
}
