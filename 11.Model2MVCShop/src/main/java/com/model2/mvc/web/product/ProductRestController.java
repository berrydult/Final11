package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@RequestMapping(value = "json/addProduct", method = RequestMethod.POST)
	public Product addProduct(@RequestBody Product product) throws Exception {

		System.out.println("/product/json/addProduct : POST");
		System.out.println("::" + product);
		
		productService.insertProduct(product); 
		
		return product;
	}

	@RequestMapping(value = "json/getProduct/{prodNo}", method = RequestMethod.GET)
	public Product getProduct(@PathVariable int prodNo) throws Exception {

		System.out.println("/product/json/getProduct : GET");
		System.out.println("::" + prodNo);

		return productService.findProduct(prodNo);
	}
	
	@RequestMapping(value = "json/updateProduct/{prodNo}", method = RequestMethod.GET)
	public Product updateProduct(@PathVariable int prodNo) throws Exception {

		System.out.println("/product/json/updateProduct : GET");
		System.out.println("::" + prodNo);
		
		Product product = productService.findProduct(prodNo);
		 
		return product;
	}
	
	@RequestMapping(value = "json/updateProduct", method = RequestMethod.POST)
	public Product updateProduct(@RequestBody Product product) throws Exception {

		System.out.println("/product/json/updateProduct : POST");
		System.out.println("::" + product);
		
		productService.updateProduct(product);
		
		Product product1=productService.findProduct(product.getProdNo());
		 
		return product1;
	}
	
	@RequestMapping(value = "json/listProduct", method = RequestMethod.POST)
	public Map getProductList(@RequestBody Search search) throws Exception {

		System.out.println("/product/json/listProduct : POST");
		System.out.println("::" + search);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(5);
		
		Map<String , Object> map = productService.getProductList(search); 
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 5, 5);
		//map.put("list", map.get("list"));
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping(value = "json/listProduct", method = RequestMethod.GET)
	public Map<String, Object> productList(@ModelAttribute("search")Search search) throws Exception {

		System.out.println("/product/json/listProduct : GET");
		System.out.println("::" + search);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(5);
		
		Map<String , Object> map = productService.getProductList(search); 
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 5, 5);
		//map.put("list", map.get("list"));
		map.put("search", search);
		
		return map;
	}
	
}
