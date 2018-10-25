package SelCDB.spring.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import SelCVO.LoginVO;

@Service("LoginValidator")
public class LoginValidator implements Validator{

	@Override
	public boolean supports(Class<?> arg0) {
		return false;
	}

	@Override
	public void validate(Object obj, Errors errors) {
		LoginVO lvo = (LoginVO)obj;
		String em = lvo.getMem();
		Pattern EmailPattern = Pattern.compile("^[0-9a-zA-Z]+([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]+([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$");
		Matcher m = EmailPattern.matcher(em);
		if(!m.find()) {
			errors.rejectValue("mem", "emailForm", "이메일 형식에 맞지 않습니다.");
		}
	}
}
