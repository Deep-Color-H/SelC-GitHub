<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Create YourSelf, SelC : ��й�ȣ ã��</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- alert â -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>
<!-- ��Ÿ�� -->
<style type="text/css">
.form-signin {
	max-width: 900px;
	padding: 10px 29px 29px;
	margin: 0 auto 30px;
	background-color: #fff;
	border: 1px solid #e5e5e5;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	padding: 19px 29px 29px;
}

.form-signin .form-signin-heading {
	font-size: 25px;
	font-weight: 500;
	letter-spacing: -0.9px;
	text-align: center;
	color: #4d4d4d;
	margin: 10px auto;
	margin-bottom: 20px;
}

.form-signin .form-signin-body {
	font-size: 18px;
	font-weight: 500;
	letter-spacing: -0.9px;
	text-align: center;
	color: #4d4d4d;
	margin: 10px auto;
	margin-bottom: 20px;
}

.form-signin input[type="text"], .form-signin input[type="password"] {
	font-size: 16px;
	height: auto;
	margin-bottom: 15px;
	padding: 7px 9px;
}
</style>
<link href="/css/bootstrap-responsive.css" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script>
	$(document).ready(function() {
		$("#gnb1").load("gnb.jsp");
		$("#footer").load("footer.jsp");
	});
	$(document)(function() {
		if (session.getAttribute("Idcode") != null) {

		}
	});

	// 18-07-12 ����
	function checkValue() {
		if (!document.findPw.mem.value) {
			alertify.error("���̵� �Է��ϼ���.");
			return false;
		} else {
			alertify.success("�ӽú�й�ȣ�� �߱޵˴ϴ�.")
			return true;
		}

	}
	
	function goSubmit() {
        $("#findPw").submit();
    }
	

</script>
</head>
<body>
	<h5 id="gnb1" style="" class="w-25 p-3"></h5>

	<div
		class="col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4  login-form">
		<form class="form-signin" id="findPw" name="findPw"
			action="<%=request.getContextPath()%>/FindPassword.do"
			method="post"		 onsubmit="return checkValue();">
			
			<h2 class="form-signin-heading">ã���� �̸����� �Է����ּ���.</h2> <br>
			<h4 class="form-signin-body">�Ʒ� ��й�ȣ ã�⸦ �����ø� �ش� �̸����� ��й�ȣ�� �ӽú�й�ȣ�� ���� �� �̸� ����Ͻ� ���Ϸ� �����帳�ϴ�.</h4>
			<input type="text" class="input-lg form-control" 
								name="mem" placeholder="�̸��� �ּ�"> <br>
			<input type="button" class="btn btn-large btn-primary btn-block" 
								onclick="goSubmit()" value="�ӽú�й�ȣ �߱޹ޱ�" />
		</form>
	</div>
	<div id="footer"></div>	
</body>
</html>