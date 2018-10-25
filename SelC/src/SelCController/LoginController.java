package SelCController;

import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import SelCDB.spring.BIZ.SpringBiz;
import SelCDB.spring.Validator.LoginValidator;
import SelCFunction.MailController;
import SelCVO.LoginVO;
import SelCVO.SigninVO;

@Controller
public class LoginController {

	@Autowired
	SpringBiz biz;
	
	@Autowired
	LoginValidator loginvalid;
	
	@RequestMapping("/toLogin.do")
	public String toLogin() {
		return "login/login";
	}
	
	@RequestMapping(value = "/login.do", method=RequestMethod.POST)
	public ModelAndView login(@ModelAttribute LoginVO loginvo, BindingResult errors, HttpSession session) {
		
		/* Email Validate, Email 형식에 맞지 않으면 다시 로그인창으로 보낸다.
		 * 
		 */
		loginvalid.validate(loginvo, errors);
		if(errors.hasErrors()) {
			return new ModelAndView("login/login","message",errors.getFieldError("mem").getDefaultMessage());
		}
		/* biz는 loginvo 객체에 있는 로그인과 비밀번호를 가지고 DB에 조회하여 
		 * 로그인 실패시 "false"를, 로그인 성공시, loginvo의 email 객체를 리턴한다.
		 * 이를 Idcode로 저장하여 로그인 여부를 확인한다.
		 */
		String res = biz.Login(loginvo);
		if(res.equals("false")) {
			return new ModelAndView("login/login","message","로그인에 실패했습니다.<br> 다시 시도해주시기 바랍니다.");
		}
		session.setAttribute("Idcode",res);
		return new ModelAndView("forward:toMain.do","message","어서오세요. <br>여러분과 같이 걷는 Self-Creator, SelC입니다.");
	}
	
	@RequestMapping("/toFindPassword.do")
	public String toFindPassword() {
		return "login/findPassword";
	}

	/** 자바 메일 발송 
	 * @throws MessagingException 
	 * @throws AddressException **/
	@RequestMapping(value = "/FindPassword.do")
	public String findPassword(@RequestParam("mem") String mem) throws AddressException, MessagingException {
		if(biz.searchEmail(mem)) {
			LoginVO chpw = biz.setTempPW(mem);
			MailController.mailSender(chpw);
		}
		return "login/findPassword_res";
	}
	
	@RequestMapping(value="/toMain.do")
    public ModelAndView toMain() {
        
        Map res = biz.main_view_list();
        return new ModelAndView("Main/Main","res",res);
    }
	
	@RequestMapping(value="/toLogout.do")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		return new ModelAndView("redirect:toMain.do");
	}
	

}


