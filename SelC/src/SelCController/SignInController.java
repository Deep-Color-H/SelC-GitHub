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
	 * biz.searchEmail(email) : email로 된 리스트가 있으면(이미 중복된 아이디가 있으면) false, 중복된 아이디가
	 * 없으면 true를 보낸다. 중복된 아이디가 있으면 다시 아이디만 입력할 수 있는 창(SignIn_CLOS)로 보내고 그렇지 않다면 아이디를
	 * 가지고 다른 내용을 입력할 수 있는 (SignIn_OPEN)으로 보낸다.
	 */
	@RequestMapping(value = "/checkEmail.do", method = RequestMethod.POST)
	public ModelAndView checkIds(@RequestParam("mem") String mem) {
		
		/* biz.searchEmail : email이 있으면 true, 없으면 false를 출력한다 
		 */
		if (biz.searchEmail(mem)) {
			return new ModelAndView("popcheckEmail","alert","중복");
		}

		return new ModelAndView("popcheckEmail_success","mem",mem);
	}

	@RequestMapping(value = "/SignIn.do", method = RequestMethod.POST)
	public ModelAndView signIn(@ModelAttribute("signinvo") SigninVO signinvo, HttpSession session) {
		// 1. Member table에 삽입 후 id를 받아온다.
		int res = biz.insertMember(signinvo);
		
		// 2. 성공 시
		if (res > 0) {
			// 3. Session의 Idcode에 Email 저장
			session.setAttribute("Idcode", signinvo.getMid());
			// 4. 메인창으로
			return new ModelAndView("redirect:toMain.do", "res", res);
		}
		// 5. 실패 시 다시 회원가입 칸으로 가져간다.
		ModelAndView mav_fail = new ModelAndView("toSignin.do");
		// 6. 실패한 원인을 fail_message에 담아서 같이 보낸다.
		mav_fail.addObject("fail_message", "회원가입에 실패했습니다.");
		// 7. 사용자가 다시 입력할 필요가 없도록 객체를 같이 보낸다..
		mav_fail.addObject("signinvo", signinvo);
		return mav_fail;
	}
	/*			<input type='text' value='" + nicname.val() +"' name='mnick' >" +
						"<input type='text' value='" + addr.val() +"' name='maddr' >" +
						"<input type='text' value='" + datepicker.val() +"' name='mage' >" +
						"<input type='text' value='' name='mchemail' >" +
						"<input type='text' value='" + password.val() +"' name='mpw' >" +
						"<button onclick='submit' class='btn btn-primary'> 수정완료 </button>"*/
	
	@RequestMapping(value = "/UserUpdate.do", method=RequestMethod.POST)
    public ModelAndView UserUpdate(@ModelAttribute("update") SigninVO signinvo, HttpSession session) {
		signinvo.setMid((String)session.getAttribute("Idcode"));
		int res = biz.updateUser(signinvo);
        
        if(res < 0) {
            return new ModelAndView("forward:toUserModify.do?mid=" + signinvo.getMid(),"message", "수정 실패하였습니다. 입력정보를 확인해주세요.");
        }else {
            return new ModelAndView("forward:toUserModify.do?mid=" + signinvo.getMid(),"message", "수정 성공하였습니다.");
        }
    
    }
    
	@RequestMapping("/toUserModify.do")
    public ModelAndView ModifyView(@RequestParam("mid") int mid, @ModelAttribute("signinvo") SigninVO signinvo) {
        
        SigninVO res = biz.ModifyView(mid);
        
        return new ModelAndView("login/user_modify_final", "viewlist", res);
    }
	
//    "login/user_modify" return 내용 테스트를 위해서 수정되어 있음
    @RequestMapping(value = "/toWithdraw.do")
    public ModelAndView Withdraw(HttpSession session) {
        String mid = (String) session.getAttribute("Idcode");
        String res = biz.deleteMember(mid);
        session.invalidate();
        return new ModelAndView("redirect:toMain.do", "mname", res);
        
    }
	
}
