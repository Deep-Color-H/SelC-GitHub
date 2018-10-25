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
		
		/* Email Validate, Email ���Ŀ� ���� ������ �ٽ� �α���â���� ������.
		 * 
		 */
		loginvalid.validate(loginvo, errors);
		if(errors.hasErrors()) {
			return new ModelAndView("login/login","message",errors.getFieldError("mem").getDefaultMessage());
		}
		/* biz�� loginvo ��ü�� �ִ� �α��ΰ� ��й�ȣ�� ������ DB�� ��ȸ�Ͽ� 
		 * �α��� ���н� "false"��, �α��� ������, loginvo�� email ��ü�� �����Ѵ�.
		 * �̸� Idcode�� �����Ͽ� �α��� ���θ� Ȯ���Ѵ�.
		 */
		String res = biz.Login(loginvo);
		if(res.equals("false")) {
			return new ModelAndView("login/login","message","�α��ο� �����߽��ϴ�.<br> �ٽ� �õ����ֽñ� �ٶ��ϴ�.");
		}
		session.setAttribute("Idcode",res);
		return new ModelAndView("forward:toMain.do","message","�������. <br>�����а� ���� �ȴ� Self-Creator, SelC�Դϴ�.");
	}
	
	@RequestMapping("/toFindPassword.do")
	public String toFindPassword() {
		return "login/findPassword";
	}

	/** �ڹ� ���� �߼� 
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


