<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>

<script language="javascript">

function ok_sign(){
	
	opener.document.form.mem.value= document.form.mem.value;
	opener.document.form.ok_sign.value = document.form.mem.value;
	close();
}

</script>

<body>
	<div
		class="col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4  login-form">
		<form id="id_form_signup" method="post" action="toSignin.do"
			runat="server" name="form">

			<div class="form-group">
				<label for="email">*이메일 주소</label> 
				<input
					class="input-lg form-control" id="email" name="mem"
					type="email" value="${mem}" required readonly="readonly"/> 
				<span class="help-block" > </span>
			</div>
			
			<div class="form-group ">
				<input type="button" onClick="ok_sign();" value="사용하기" class="btn" />
			</div>
		</form>

	</div>

</body>
</html>