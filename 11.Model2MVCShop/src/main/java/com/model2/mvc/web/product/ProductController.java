package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;



@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//@RequestMapping("/addProductView.do")
	//public String addProductView() throws Exception {
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {
		System.out.println("/addProductView");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	//@RequestMapping("/addProduct.do")
	//public String addProduct( @ModelAttribute("product") Product product) throws Exception {
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, @RequestParam("fileImage") MultipartFile multipartFile) throws Exception {
		System.out.println("/addProduct");
		//Business Logic
		String fileName = multipartFile.getOriginalFilename();
		File file = new File("C:\\Users\\Bit\\git\\Final11\\11.Model2MVCShop\\WebContent\\images\\uploadFiles\\" + fileName);

		multipartFile.transferTo(file); 
		
		//Business Logic
		product.setFileName(fileName);
		productService.insertProduct(product);
		product.setProTranCode("0");
		
		return "forward:/product/addProduct.jsp";
	}
	
	//@RequestMapping("/getProduct.do")
	//public String getProduct( @RequestParam("prodNo") int prodNo , Model model, HttpServletRequest request, HttpServletResponse response ) throws Exception {
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , @CookieValue(value="history", required=false) String history, Model model, HttpServletRequest request, HttpServletResponse response ) throws Exception {
		
		System.out.println("/getProduct");
		//Business Logic
		Product product = productService.findProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		if(history == null || history.length() == 0) {
			history = prodNo + "";
		}else {
			if(history.indexOf(prodNo+"") == -1) {
				history = prodNo+"," + history;
			}
		}
		
		Cookie cookie = new Cookie("history",history);
		cookie.setMaxAge(-1);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		return "forward:/product/getProduct.jsp";
	}

	@RequestMapping(value="deleteProduct", method=RequestMethod.POST)
	public String deleteProduct( @RequestParam(value = "deleteProduct", required = false) String deleteProduct,	 Model model ) throws Exception {
		System.out.println("/deleteProduct");
		System.out.println("deleteProduct: "+deleteProduct);
		//Business Logic
		List<Integer> prodNos = new ArrayList<Integer>();
		String[] prodNoStr = deleteProduct.split(",");
		for (String value:prodNoStr) {
			prodNos.add(Integer.parseInt(value));
		}
		
		productService.deleteProduct(prodNos);
		
		return "redirect:/product/listProduct?menu=manage";
	}
	
	//@RequestMapping("/updateProductView.do")
	//public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{
		System.out.println("/updateProductView");
		//Business Logic
		Product product = productService.findProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
	//@RequestMapping("/updateProduct.do")
	//public String updateProduct( @ModelAttribute("product") Product product , Model model) throws Exception{
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product , Model model, @RequestParam("fileImage") MultipartFile multipartFile) throws Exception{
		System.out.println("/updateProduct");
		//Business Logic
		String fileName = multipartFile.getOriginalFilename();
		File file = new File("C:\\Users\\Bit\\git\\Final11\\11.Model2MVCShop\\WebContent\\images\\uploadFiles\\" + fileName);

		multipartFile.transferTo(file); 
		
		//Business Logic
		product.setFileName(fileName);
		productService.updateProduct(product);
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo();
	}
	
	//@RequestMapping("/listProduct.do")
	//public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
	@RequestMapping(value = "listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model, 
								HttpServletRequest request, HttpServletResponse response,
								@CookieValue(value="history", required=false) String history ) throws Exception{
		
		System.out.println("/listProduct");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		

		request.setCharacterEncoding("euc-kr");
		response.setCharacterEncoding("euc-kr");
		
		List<Product> cookieResult = new ArrayList<Product>();
		
			//Cookie[] cookies = request.getCookies();
			if (history != null) {
				String[] pieces = history.split(",");
				for (int i = 0; i < pieces.length; i++) { 
					Product product = productService.findProduct(Integer.parseInt(pieces[i]));
					cookieResult.add(product);
				}
			}
		
		// Model 과 View 연결
		System.out.println("cookieResult"+cookieResult);

		model.addAttribute("cookieResult",cookieResult);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
}
