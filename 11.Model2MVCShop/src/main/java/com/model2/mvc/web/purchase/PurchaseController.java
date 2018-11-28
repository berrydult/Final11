package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
		@Value("#{commonProperties['pageUnit']}")
		//@Value("#{commonProperties['pageUnit'] ?: 3}")
		int pageUnit;
		
		@Value("#{commonProperties['pageSize']}")
		//@Value("#{commonProperties['pageSize'] ?: 2}")
		int pageSize;
		
		
		//@RequestMapping("/addPurchaseView.do")
		//public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo) throws Exception{
		@RequestMapping(value= "addPurchase",method=RequestMethod.GET)
		public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo) throws Exception{
			System.out.println("/addPurchaseView.do");
			
			Purchase purchase = purchaseService.getPurchase2(prodNo);
			Product product = productService.findProduct(prodNo);
			
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("purchase",	purchase);
			modelAndView.addObject("product", product);
			modelAndView.setViewName("/purchase/addPurchaseView.jsp");
			
			return modelAndView;
			
		}
		
		@RequestMapping(value= "addPurchase",method=RequestMethod.POST)
		public ModelAndView addPurchase(@RequestParam("buyerId") String buyerId, @RequestParam("prodNo") int prodNo,
											@ModelAttribute("purchase") Purchase purchase) throws Exception{
			System.out.println("/addPurchase.do");
			
			purchase.setBuyer(userService.getUser(buyerId));
			purchase.setPurchaseProd(productService.findProduct(prodNo));
			purchase.setTranCode("1");
			
			purchaseService.addPurchase(purchase);
			
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("purchase",	purchase); 
			modelAndView.setViewName("/purchase/addPurchase.jsp");
			
			return modelAndView;
			
		}
		
		@RequestMapping(value="getPurchase", method=RequestMethod.GET)
		public String getPurchase(@RequestParam("tranNo") int tranNo, Model model)throws Exception {
			System.out.println("/getPurchase.do");
			
			Purchase purchase = purchaseService.getPurchase(tranNo);
			model.addAttribute("purchase", purchase);
			
			return "forward:/purchase/getPurchase.jsp";
		}
		
		
		@RequestMapping(value="listPurchase")
		public String listPurchase(@ModelAttribute("search") Search search , Model model , HttpSession session) throws Exception{
			
			System.out.println("/listPurchase.do");
			
			if(search.getCurrentPage() ==0 ){
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);

			String buyerId = ((User)session.getAttribute("user")).getUserId();
			
			Map<String , Object> map = purchaseService.getPurchaseList(search, buyerId);
			
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			
			// Model 과 View 연결
			model.addAttribute("list", map.get("list"));
			model.addAttribute("resultPage", resultPage);
			model.addAttribute("search", search);
			
			return "forward:/purchase/listPurchase.jsp";
		}
		
		@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
		public String updatePurchase( @ModelAttribute("purchase") Purchase purchase , Model model) throws Exception{

			System.out.println("/updatePurchase.do");
			
			purchase.setTranCode("2");
			purchaseService.updatePurchase(purchase);
			
			return "redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo();
		}
		
		@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
		public String updatePurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception{

			System.out.println("/updatePurchaseView.do");
			//Business Logic
			Purchase purchase = purchaseService.getPurchase(tranNo);
			// Model 과 View 연결
			model.addAttribute("purchase", purchase);
			
			return "forward:/purchase/updatePurchaseView.jsp";
		}
		
		@RequestMapping(value = "updateTranCode", method=RequestMethod.GET)
		public ModelAndView updateTranCode(@RequestParam("tranCode") String tranCode, @RequestParam("tranNo")int tranNo) throws Exception{
			
			System.out.println("/updateTranCode.do");
			
			Purchase purchase = purchaseService.getPurchase(tranNo);
			if(tranCode.equals("2")) {
				purchase.setTranCode("3");
			}
			
			purchaseService.updateTranCode(purchase);
			
			ModelAndView modelAndView = new ModelAndView();
			
			modelAndView.addObject("purchase", purchase);
			modelAndView.setViewName("redirect:/purchase/listPurchase?");
			
			return modelAndView;
			
		}
		
		@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
		public ModelAndView updateTranCodeByProd(@RequestParam("prodNo")int prodNo, @RequestParam("tranCode") String tranCode) throws Exception {
			
			System.out.println("/updateTranCodeByProd.do");
			
			Purchase purchase = purchaseService.getPurchase2(prodNo);
			
			if(tranCode.equals("1")){
				purchase.setTranCode("2");
			}
			
			purchaseService.updateTranCode(purchase);

			ModelAndView modelAndView = new ModelAndView();
			
			modelAndView.addObject("purchase", purchase);
			modelAndView.setViewName("redirect:/product/listProduct?menu=manage");
			
			return modelAndView;
			
		}
}
