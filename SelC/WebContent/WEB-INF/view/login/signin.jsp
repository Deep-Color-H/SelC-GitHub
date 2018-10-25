<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>Create YourSelf, SelC : 회원가입</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<style>
h1 {
	font-size: 30px;
	font-weight: 500;
	letter-spacing: -0.9px;
	text-align: center;
	color: #4d4d4d;
	margin: 50px auto;
}

h6 {
	font-size: 25px;
	font-weight: 500;
	letter-spacing: -0.9px;
	text-align: center;
	color: #4d4d4d;
	margin: 10px auto;
	margin-bottom: 20px;
}

.or {
	margin: 35px 0;
	text-align: center;
	font-size: 20px;
	font-weight: 500;
	color: #909090;
}

.login-form {
	border: solid 1px #e1e3e2;
	border-radius: 4px;
	padding: 30px 20px 20px;
}

.login-form label {
	font-size: 14px;
	color: #4d4d4d;
	font-weight: 500;
	margin-bottom: 10px;
}

.checkbox label {
	font-size: 14px;
	color: #909090;
}

.btn-primary {
	font-size: 16px;
	padding: 16px 0;
	background-color: #4092f1;
	margin-top: 35px;
}

.btn-fb {
	font-size: 16px;
	padding: 16px 0;
	background-color: #4c66a3;
	border: 0;
}

p.allow {
	margin-top: 10px;
	margin-bottom: 50px;
	text-align: center;
	font-size: 14px;
	color: #909090;
}

.fb-wrap {
	padding-left: 10px;
	padding-right: 10px;
}

.checkbox a {
	color: #909090;
	text-decoration: underline;
}
</style>

<script>
	// 키를 누르면 checkvalue 실행
	document.onkeydown = checkvalue

	// checkvalue 기능
	function checkvalue() {

		// a 텍스트 필드와 b 텍스트 필드 중 하나라도 값이 있을 때
		if (id_form_signup.password1.value || id_form_signup.password2.value) {

			// 두 필드의 값이 서로 다를 때
			if (id_form_signup.password1.value != id_form_signup.password2.value) {

				// status 필드에 일치하지 않는다는 문장 출력
				id_form_signup.status.value = "[ 일치하지 않습니다 ]";

				// 그에 맞게 길이 수정
				id_form_signup.status.style.width = 120;
				id_form_signup.status.style.color = "red";

				// 두 필드의 값이 동일 할 때
			} else {

				// status 필드에 일치한다는 문장 출력
				id_form_signup.status.value = "";

				// 역시 그에 맞게 길이 수정
				id_form_signup.status.style.width = 83;
				id_form_signup.status.style.color = "blue";
			}

			// a 텍스트 필드와 b 텍스트 필드 두 개 모두 아무값이 없을 때
		} else {

			// 아무것도 입력이 안 되어 있으므로 비밀번호를 입력해 달라는 메세지를 status 필드에 출력 함
			id_form_signup.status.value = "";
			//id_form_signup.status.value = "비밀번호를 입력하세요";
			id_form_signup.status.style.color = "blue";

			// 그에 맞게 길이 수정
			id_form_signup.status.style.width = 170;
		}

		// 반복 실행
		setTimeout("checkvalue()", 0);
	}
</script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$("#gnb1").load("gnb.jsp");
		$("#footer").load("footer.jsp");
	});
</script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$.datepicker.setDefaults({
		dateFormat : 'yymmdd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
				'9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		showMonthAfterYear : true,
		yearSuffix : '년'
	});

	$(function() {
		$("#datepicker").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : "1960:2010"
		});
	});
</script> 



<!-- 주소 찾기 api -->

<script language="javascript">
	function goPopup() {
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
		var pop = window.open("jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}
	
/* 	function go_alert() {
		alert(${fail_message});
		
	}
 */
	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
			roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
			detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
			buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo, entX, entY) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.form.maddr.value = roadFullAddr;
	}
</script>

<script type="text/javascript">
	
	function goCheckEmail(){
		var pop = window.open("popcheckEmail.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
	}
	
	
	function compare_info(){
		// a 텍스트 필드와 b 텍스트 필드 중 하나라도 값이 있을 때
		
		var check_point_email = false;
		var check_point_psw = false;
		 if (id_form_signup.mem.value || id_form_signup.ok_sign.value) {

			// 두 필드의 값이 서로 다를 때
			if (id_form_signup.mem.value != id_form_signup.ok_sign.value) {

				alert('이메일 입력이 변경되었습니다. 다시 중복확인 해주세요');
				
				check_point_email = false;
			}else{
				check_point_email = true;
			}

			// a 텍스트 필드와 b 텍스트 필드 두 개 모두 아무값이 없을 때
		} else {
			alert('이메일 중복확인 해주세요');
			check_point_email = false;
		} 
		
		// a 텍스트 필드와 b 텍스트 필드 중 하나라도 값이 있을 때
		if (id_form_signup.password1.value || id_form_signup.password2.value) {

			// 두 필드의 값이 서로 다를 때
			if (id_form_signup.password1.value != id_form_signup.password2.value) {
				
				alert('비밀번호가 일치 하지 않습니다.');
				check_point_psw = false;
			} else {
				check_point_psw = true;
			}
		}
		
		
		return check_point_email == true && check_point_psw == true ? true : false;
	}
	
</script>


</head>

<body>

	<h5 id="gnb1" class="w-25 p-3"></h5>

	<div
		class="col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4  login-form">
		<h6>회원가입</h6>
		<form id="id_form_signup" method="post"
			action="<%=request.getContextPath()%>/SignIn.do"
			enctype="multipart/form-data" modelAttribute="signinvo"
			runat="server" name="form" onsubmit="return compare_info()">

			<div class="form-group ">
				<label for="email">*이메일 주소</label> <input
					class="input-lg form-control" id="email" name="mem"
					placeholder="이메일 주소" type="email" required /> <span
					class="help-block"> </span>
			</div>

			<div class="form-group ">
				<input type="button" onClick="goCheckEmail();" value="중복확인"
					class="btn" /><br>
			</div>

			<input type="hidden" id="ok_sign" />

			<div class="form-group ">
				<label for="password1">*비밀번호</label> <input
					class="input-lg form-control" id="password1" name="mpw"
					placeholder="암호" type="password" required /> <span
					class="help-block"> </span>
			</div>

			<div class="form-group ">
				<label for="password1">비밀번호 확인</label> <input
					class="input-lg form-control" id="password2" name="mpw2"
					placeholder="암호" type="password" required /> <span
					class="help-block"> </span>
			</div>

			<input type="text" name="status"
				style="border: 0; color: blue; font size: 12px 굴림; width: 160"
				readonly onfocus="this.blur();"> <br> <br>

			<div class="form-group ">
				<label for="firstname">*이름</label> <input
					class="input-lg form-control" id="firstname" name="mname"
					placeholder="이름" type="text" required /> <span class="help-block">
				</span>
			</div>

			<div class="form-group ">
				<label for="nicname">*닉네임</label> <input
					class="input-lg form-control" id="nic_name" name="mnick"
					placeholder="닉네임" type="text" required /> <span class="help-block">
				</span>
			</div>

			<div class="form-group ">
				<label for="datepicker">생년월일</label> 
				<input id="datepicker" name="mage" class="input-lg form-control" type="text"/> <span
					class="help-block"> </span>
			</div>
			<!-- 이미지 디폴트 경로 설정 해야해여 value -->
			<div class="form-group ">
				<label for="imgInp">프로필 사진</label> <input
					class="input-lg form-control" id="img" name="mpfimg_org"
					path="mpfimg_org" placeholder="image.png" type="file" value="file_path" /> <span
					class="help-block"> </span>
			</div>

			<div class="form-group ">
				<label for="addr">주소</label><br> <input type="button"
					onClick="goPopup();" value="주소 찾기" class="btn" /><span
					class="help-block"> </span>

				<div id="callBackDiv">
					<input type="text" id="maddr" class="input-lg form-control"
						name="maddr" placeholder="도로명주소 전체" readonly="readonly" />
				</div>
				<span class="help-block"> </span>
			</div>


			<ul class="list-group">
				<li class="list-group-item">이메일 수신 동의
					<div class="material-switch pull-right">
						<input type="checkbox" id="emailpermit" value="Y" name="mchemail"> <label
							for="someSwitchOptionPrimary" class="label-primary"></label>
					</div>
				</li>
			</ul>

			<div class="form-group">
				<p>
					MWM의 <a href="/terms/usage" target="_blank">이용약관</a> 및 <a
						href="/terms/privacy" target="_blank">개인정보취급방침</a>에 동의합니다.
				</p>
			</div>

			<button type="submit" id="id_usersignup"
				class="btn btn-primary btn-block">무료 가입</button>

		</form>
	</div>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<div id="footer"></div>	
</body>
</html>