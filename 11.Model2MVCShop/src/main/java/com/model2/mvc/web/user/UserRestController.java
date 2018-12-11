package com.model2.mvc.web.user;

import java.io.FileNotFoundException;
import java.net.URISyntaxException;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음

	@Resource(name= "mailSender")
	private JavaMailSender mailSender;
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping( value= "json/callBack", method=RequestMethod.POST)
	public String  callBack(@RequestBody User user, HttpSession session)  throws Exception{
		System.out.println("/user/json/callBack : POST");
		user.setPassword("asdfg");
		/*if(userService.getUser(user.getUserId()) == null) {
			user.setPassword("패스워드");
			userService.addUser(user);
		}*/
		
		//User dbUser = userService.getUser(user.getUserId());
		
		if(userService.getUser(user.getUserId())!=null) {
			session.setAttribute("user", user);
		}else if(userService.getUser(user.getUserId())==null){
			userService.addUser(user);
			session.setAttribute("user", user);
		}
		
		return "naverLogin";
	}
	
	@RequestMapping(value = "json/mailSender/{email}", method=RequestMethod.GET)
	public void sendMail(@PathVariable String email, HttpSession session)
			throws Exception {
		
		String from = "maximum.pjy@gmail.com";
		String to = email+".com";
		String authNum = RandomNum();

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper 
             = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom(from);
			messageHelper.setTo(to);
			messageHelper.setSubject("박정연 님의 문의메일");
			messageHelper.setText("인증번호 : "+authNum);
			session.setAttribute("authNum", authNum);
			
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();

		}
	}
	
	@RequestMapping(value = "json/checkAuth/{userAuth}", method=RequestMethod.GET)
	public String checkAuth(@PathVariable String userAuth, HttpSession session) throws Exception{
		String authNum = (String)session.getAttribute("authNum");
		
		if(authNum.equals(userAuth)) {
			return "ok";
		}else {
			return "wrong";
		}
		
	}
	
	 public String RandomNum(){
			StringBuffer buffer = new StringBuffer();
			for(int i =0; i<6; i++) {
				int n = (int)(Math.random()*10);
				buffer.append(n);
			}
			return buffer.toString();
		}
	
}