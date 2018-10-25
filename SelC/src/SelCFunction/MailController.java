package SelCFunction;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import SelCVO.LoginVO;

public class MailController {

	public static void mailSender(LoginVO chpw) throws AddressException, MessagingException {
		// ���̹��� ��� smtp.naver.com �� �Է��մϴ�.
		// Google�� ��� smtp.gmail.com �� �Է��մϴ�.
		String host = "smtp.naver.com";
		
		final String username = "kyuinkyuin";       //���̹� ���̵� �Է����ּ���. @naver.com�� �Է����� ���ñ���.
		final String password = "sks86218621";   //���̹� �̸��� ��й�ȣ�� �Է����ּ���.
		int port=465; //��Ʈ��ȣ
		 
		// ���� ����
		String recipient = chpw.getMem();    //�޴� ����� �����ּҸ� �Է����ּ���. // �Ű����ڷ� ���� ����
		String temp_pw = chpw.getMpw();
		String subject = chpw.getMem()+"��, SelC���� �ӽú�й�ȣ�� �߱��߽��ϴ�."; 					  //���� ���� �Է����ּ���.
		String body = ""; //���� ���� �Է����ּ���.
		
		body += "<div align='center' style='border:1px solid black; font-family:verdana'>"
				+ "<h3 style='color: blue;'>" 
				+ recipient + "�Կ��� �߱޵� �ӽú�й�ȣ�� " + temp_pw + "�Դϴ�. �ݵ�� ��й�ȣ�� �Է����ּ���.</h3><br/><br/>"
				+ "<input type=button value=\"�α����������� �̵�\""
				+ "class=\"btn btn-primary btn-block\"" + "onclick=\"toSignin.do\"/>" + "</div>";
		 
		Properties props = System.getProperties(); // ������ ��� ���� ��ü ����
		 
		// SMTP ���� ���� ����
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		   
		//Session ����
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un=username;
			String pw=password;
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true); //for debug
		   
		Message mimeMessage = new MimeMessage(session); //MimeMessage ����
		mimeMessage.setFrom(new InternetAddress("kyuinkyuin@naver.com")); //�߽��� ���� , ������ ����� �̸����ּҸ� �ѹ� �� �Է��մϴ�. �̶��� �̸��� Ǯ �ּҸ� �� �ۼ����ּ���.
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //�����ڼ��� //.TO �ܿ� .CC(����) .BCC(��������) �� ����
		mimeMessage.setSubject(subject);  //�������
		mimeMessage.setContent(body, "text/html; charset=EUC-KR");

		Transport.send(mimeMessage); //javax.mail.Transport.send() �̿�
		
		
	}
}
