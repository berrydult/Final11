package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductService {
	
	//��ǰ ���
	public void insertProduct(Product product) throws Exception;
	
	//��ǰ ã��
	public Product findProduct(int prodNo) throws Exception;
	
	//��ǰ����Ʈ ��������
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	//��ǰ���� ����
	public void updateProduct(Product product) throws Exception;
	
	//��ǰ���� ����
	public void deleteProduct(List<Integer> prodNos) throws Exception;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception;
}
