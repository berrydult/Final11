package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductService {
	
	//상품 등록
	public void insertProduct(Product product) throws Exception;
	
	//상품 찾기
	public Product findProduct(int prodNo) throws Exception;
	
	//상품리스트 가져오기
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	//상품정보 수정
	public void updateProduct(Product product) throws Exception;
	
	//상품정보 삭제
	public void deleteProduct(List<Integer> prodNos) throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception;
}
