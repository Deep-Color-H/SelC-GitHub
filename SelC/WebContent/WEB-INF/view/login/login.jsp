<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Create YourSelf, SelC : �α���</title>
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
	max-width: 400px;
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
	
	function init() {
		if(<%=request.getAttribute("message")!=null%>)
			alertify.error("<%=request.getAttribute("message")%>");
		if (<%=session.getAttribute("Idcode")!=null%>) {
			alertify.error("�̹� �α����� �Ǿ��ֽ��ϴ�.");
			document.location.href="../SelC";
		}
	}

	// 18-07-12 ����
	function checkValue() {
		if (!document.userInfo.mid.value) {
			alert("���̵� �Է��ϼ���.");
			return false;
		} else if (!document.userInfo.mpw.value) {
			alert("��й�ȣ�� �Է��ϼ���.");
			return false;
		} else {
			return true;
		}

	}

	function toSignin() {
		document.location.href = "toSignin.do";
	}
</script>

</head>

<body onload="init()">
	<h5 id="gnb1" style="" class="w-25 p-3"></h5>

	<div
		class="col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4  login-form">
		<form class="form-signin"
			action="<%=request.getContextPath()%>/login.do" method="post"
			onsubmit="return checkValue()" name="userInfo" method="post">
			<h2 class="form-signin-heading">�α����ϼ���</h2>
			<input type="text" class="input-lg form-control" name="mem"
				placeholder="�̸��� �ּ�"> <input type="password"
				class="input-lg form-control" name="mpw" placeholder="��ȣ"> <br>
			<button class="btn btn-large btn-primary btn-block" type="submit">�α���</button>
			<br> <input type="button"
				class="btn btn-large btn-primary btn-block" onclick="toSignin()"
				value="ȸ������" /> <br>
			<p>
				<a href="<%=request.getContextPath()%>/toFindPassword.do">��й�ȣ ã��</a>
			</p>

		</form>
	</div>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<div id="footer"></div>	
</body>
</html>