<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
body {
	margin : 30px auto 30px;
}
</style>
</head>

<script language="javascript">
function init(){
		
	document.form.email.value = window.opener.document.form.email.value;
}

</script>

<body onload="init();">

	<div
		class="col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4  login-form">
		<form id="id_form_signup" method="post" runat="server" name="form" action="checkEmail.do">

			<div class="form-group ">
				<label for="email">*�̸��� �ּ�</label> <input
					class="input-lg form-control" id="email" name="mem"
					placeholder="�̸��� �ּ�" type="email" value="" required /> <span
					class="help-block"> </span>
			</div>

			<div class="form-group ">
				<input type="submit" value="�ߺ�Ȯ��"	class="btn btn-primary btn-block"  />
				<!-- �̸��� �ߺ� Ȯ�� �ϴ� .do �ۼ��ؾ��ؿ� -->
			</div>
		</form>

	</div>

</body>
</html>