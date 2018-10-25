<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Create YourSelf, SelC : 비밀번호 찾기</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>
<!-- 스타일 -->
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

	// 18-07-12 수정
	function checkValue() {
		if (!document.findPw.mem.value) {
			alertify.error("아이디를 입력하세요.");
			return false;
		} else {
			alertify.success("임시비밀번호가 발급됩니다.")
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
			
			<h2 class="form-signin-heading">찾으실 이메일을 입력해주세요.</h2> <br>
			<h4 class="form-signin-body">아래 비밀번호 찾기를 누르시면 해당 이메일의 비밀번호를 임시비밀번호로 변경 후 이를 등록하신 메일로 보내드립니다.</h4>
			<input type="text" class="input-lg form-control" 
								name="mem" placeholder="이메일 주소"> <br>
			<input type="button" class="btn btn-large btn-primary btn-block" 
								onclick="goSubmit()" value="임시비밀번호 발급받기" />
		</form>
	</div>
	<div id="footer"></div>	
</body>
</html>