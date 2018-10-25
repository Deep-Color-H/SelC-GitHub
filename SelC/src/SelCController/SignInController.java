package SelCController;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import SelCDB.spring.BIZ.SpringBiz;
import SelCDB.spring.Validator.SigninValidator;
import SelCVO.SigninVO;

@Controller
public class SignInController {

	@Autowired
	SpringBiz biz;
	
	@Autowired
	SigninValidator valid;

	@RequestMapping("/toSignin.do")
	public String toSignin(@ModelAttribute SigninVO signinvo) {
		return "login/signin";
	}
	
	/*
	 * biz.searchEmail(email) : email�� �� ����Ʈ�� ������(�̹� �ߺ��� ���̵� ������) false, �ߺ��� ���̵�
	 * ������ true�� ������. �ߺ��� ���̵� ������ �ٽ� ���̵� �Է��� �� �ִ� â(SignIn_CLOS)�� ������ �׷��� �ʴٸ� ���̵�
	 * ������ �ٸ� ������ �Է��� �� �ִ� (SignIn_OPEN)���� ������.
	 */
	@RequestMapping(value = "/checkEmail.do", method = RequestMethod.POST)
	public ModelAndView checkIds(@RequestParam("mem") String mem) {
		
		/* biz.searchEmail : email�� ������ true, ������ false�� ����Ѵ� 
		 */
		if (biz.searchEmail(mem)) {
			return new ModelAndView("popcheckEmail","alert","�ߺ�");
		}

		return new ModelAndView("popcheckEmail_success","mem",mem);
	}

	@RequestMapping(value = "/SignIn.do", method = RequestMethod.POST)
	public ModelAndView signIn(@ModelAttribute("signinvo") SigninVO signinvo, HttpSession session) {
		// 1. Member table�� ���� �� id�� �޾ƿ´�.
		int res = biz.insertMember(signinvo);
		
		// 2. ���� ��
		if (res > 0) {
			// 3. Session�� Idcode�� Email ����
			session.setAttribute("Idcode", signinvo.getMid());
			// 4. ����â����
			return new ModelAndView("redirect:toMain.do", "res", res);
		}
		// 5. ���� �� �ٽ� ȸ������ ĭ���� ��������.
		ModelAndView mav_fail = new ModelAndView("toSignin.do");
		// 6. ������ ������ fail_message�� ��Ƽ� ���� ������.
		mav_fail.addObject("fail_message", "ȸ�����Կ� �����߽��ϴ�.");
		// 7. ����ڰ� �ٽ� �Է��� �ʿ䰡 ������ ��ü�� ���� ������..
		mav_fail.addObject("signinvo", signinvo);
		return mav_fail;
	}
	/*			<input type='text' value='" + nicname.val() +"' name='mnick' >" +
						"<input type='text' value='" + addr.val() +"' name='maddr' >" +
						"<input type='text' value='" + datepicker.val() +"' name='mage' >" +
						"<input type='text' value='' name='mchemail' >" +
						"<input type='text' value='" + password.val() +"' name='mpw' >" +
						"<button onclick='submit' class='btn btn-primary'> �����Ϸ� </button>"*/
	
	@RequestMapping(value = "/UserUpdate.do", method=RequestMethod.POST)
    public ModelAndView UserUpdate(@ModelAttribute("update") SigninVO signinvo, HttpSession session) {
		signinvo.setMid((String)session.getAttribute("Idcode"));
		int res = biz.updateUser(signinvo);
        
        if(res < 0) {
            return new ModelAndView("forward:toUserModify.do?mid=" + signinvo.getMid(),"message", "���� �����Ͽ����ϴ�. �Է������� Ȯ�����ּ���.");
        }else {
            return new ModelAndView("forward:toUserModify.do?mid=" + signinvo.getMid(),"message", "���� �����Ͽ����ϴ�.");
        }
    
    }
    
	@RequestMapping("/toUserModify.do")
    public ModelAndView ModifyView(@RequestParam("mid") int mid, @ModelAttribute("signinvo") SigninVO signinvo) {
        
        SigninVO res = biz.ModifyView(mid);
        
        return new ModelAndView("login/user_modify_final", "viewlist", res);
    }
	
//    "login/user_modify" return ���� �׽�Ʈ�� ���ؼ� �����Ǿ� ����
    @RequestMapping(value = "/toWithdraw.do")
    public ModelAndView Withdraw(HttpSession session) {
        String mid = (String) session.getAttribute("Idcode");
        String res = biz.deleteMember(mid);
        session.invalidate();
        return new ModelAndView("redirect:toMain.do", "mname", res);
        
    }
	
}
