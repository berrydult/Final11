package com.model2.mvc.web.purchase;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
		
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	/*@RequestMapping(value= "json/addPurchase/{prodNo}",method=RequestMethod.GET)
	public Product addPurchaseView(@PathVariable int prodNo) throws Exception{
		
		System.out.println("/purchase/json/addPurchase : GET");
		
		return productService.findProduct(prodNo);
		
	}*/
	
	/*@RequestMapping(value= "json/addPurchase",method=RequestMethod.POST)
	public Purchase addPurchase(@RequestBody Purchase purchase) throws Exception{
		System.out.println("/purchase/json/addPurchase : POST");
		System.out.println("::" + purchase);
		
		purchaseService.addPurchase(purchase); 
		
		return purchase;
	
	}*/
	
	@RequestMapping(value = "json/getPurchase/{tranNo}", method = RequestMethod.GET)
	public Purchase getPurchase(@PathVariable int tranNo) throws Exception {

		System.out.println("/purchase/json/getPurchase : GET");
		System.out.println("::" + tranNo);

		return purchaseService.getPurchase(tranNo);
		
		}
	
	@RequestMapping(value = "json/getPurchase/{prodNo}", method = RequestMethod.GET)
	public Purchase getPurchase2(@PathVariable int prodNo) throws Exception {

		System.out.println("/purchase/json/getPurchase : GET");
		System.out.println("::" + prodNo);

		return purchaseService.getPurchase2(prodNo);
	}
	
	@RequestMapping(value = "json/updatePurchase/{tranNo}", method=RequestMethod.GET)
	public Purchase updatePurchase(@PathVariable int tranNo) throws Exception{
		System.out.println("/purchase/json/updatePurchase : GET");
		System.out.println("tranNo : " + tranNo);
		
		return purchaseService.getPurchase(tranNo);
		
	}
	
	@RequestMapping(value = "json/updatePurchase", method=RequestMethod.POST)
	public Purchase updatePurchase(@RequestBody Purchase purchase) throws Exception{
		System.out.println("/purchase/json/updatePurchase : POST");
		System.out.println("purchase : " + purchase);
		
		purchase.setTranCode("2");
		purchaseService.updatePurchase(purchase);
		
		Purchase purchase01 = purchaseService.getPurchase(purchase.getTranNo());
		
		return purchase01;
	}
	
	@RequestMapping(value = "json/listPurchase", method = RequestMethod.GET)
	public Map<String, Object> purchaseList(@ModelAttribute("search")Search search, @ModelAttribute User user) throws Exception {

		System.out.println("/purchase/json/listPurchase : GET");
		System.out.println("::" + search);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(5);
		
		user.setUserId("user17");
		
		Map<String , Object> map = purchaseService.getPurchaseList(search, user.getUserId());
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 5, 5);
		//map.put("list", map.get("list"));
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping(value = "json/updateTranCode/{tranNo}/{tranCode}", method=RequestMethod.GET)
	public Purchase updateTranCode(@PathVariable String tranCode, @PathVariable int tranNo) throws Exception{
		System.out.println("/purchase/json/updateTranCode : GET");
		System.out.println("tranCode : " + tranCode);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode("2");
		purchaseService.updateTranCode(purchase);
		
		return  purchase;
		
	}
}
