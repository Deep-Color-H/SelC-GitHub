<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="SelCVO.SigninVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Create YourSelf, SelC : 회원 정보 수정</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>
<style>
label, input {
	display: block;
}

input.text {
	margin-bottom: 12px;
	width: 95%;
	padding: .4em;
}

fieldset {
	padding: 0;
	border: 0;
	margin-top: 25px;
}

h1 {
	font-size: 1.2em;
	margin: .6em 0;
}

div#users-contain {
	width: 350px;
	margin: 20px 0;
}

div#users-contain table {
	margin: 1em 0;
	border-collapse: collapse;
	width: 100%;
}

div#users-contain table td, div#users-contain table th {
	border: 1px solid #eee;
	padding: .6em 10px;
	text-align: left;
}

.ui-dialog .ui-state-error {
	padding: .3em;
}

.validateTips {
	border: 1px solid transparent;
	padding: 0.3em;
}

.ui-widget-overlay {
	opacity: 0.5;
	filter: Alpha(Opacity = 50);
	background-color: black;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		var dialog, form,
		
		// From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
		emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
				name = $("#name"), 
				nicname = $("#nicname"), 
				addr = $("#addr"), 
				email = $("#email"), 
				password = $("#password"),
				datepicker = $("#datepicker"),
		allFields = $([]).add( name ).add( nicname ).add( addr ).add( email ).add( password ).add( datepicker ), 
		tips = $( ".validateTips");

		function updateTips(t) {
			tips.text(t)
			.addClass("ui-state-highlight");
			setTimeout(function() {
				tips.removeClass("ui-state-highlight", 1500);
			}, 500);
		}

		function checkLength( o, n, min, max ) {
		      if ( o.val().length > max || o.val().length < min ) {
		        o.addClass( "ui-state-error" );
		        updateTips( "Length of " + n + " must be between " +
		          min + " and " + max + "." );
		        return false;
		      } else {
		        return true;
		      }
		    }

		function checkRegexp(o, regexp, n) {
			if (!(regexp.test(o.val()))) {
				o.addClass("ui-state-error");
				updateTips(n);
				return false;
			} else {
				return true;
			}
		} 
		
		

		function updateUser() {
			var valid = true;
			allFields.removeClass("ui-state-error");
			
			/* valid = valid && checkLength(name, "name", 3, 16); */
			/* valid = valid && checkLength(email, "email", 6, 80); */
			/* valid = valid && checkLength(password, "password", 5, 16); */
			/* valid = valid && checkLength(nicname, "nicname", 3, 80); */
			/* valid = valid && checkLength(addr, "addr", 0, 80); */
			/* valid = valid && checkLength(birth, "birth", 1, 80); */
			/* valid = valid && checkLength(emailpermit, "emailpermit", 0, 80); */

			/* valid = valid
					&& checkRegexp(
							name,
							/^[a-z]([0-9a-z_\s])+$/i,
							"Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter."); */
			/* valid = valid
					&& checkRegexp(email, emailRegex, "eg. ui@jquery.com");
			valid = valid
					&& checkRegexp(password, /^([0-9a-zA-Z])+$/,
							"Password field only allow : a-z 0-9"); */

			
			if ( valid ) {
				$("#users tbody").empty();
				$("#users tbody").append(
						"<tr>" + 
						"<td>" + "<span class='text-nowrap'>"  + name.val() + "</span>" + "</td>" +
						"<td>" + "<span class='text-nowrap'>" + nicname.val() + "</span>" + "</td>" +  
						"<td>" + "<span class='text-nowrap'>"  + addr.val() + "</span>" + "</td>" + 
						"<td>" + email.val() + "</td>" +
						"<td>"  + "<span class='text-nowrap'>" +  datepicker.val() + "</span>" + "</td>" +
								+ "</tr>");
				
				$("#mnick").val(nicname.val());
				$("#maddr").val(addr.val());
				$("#mage").val(datepicker.val());
				$("#mpw").val(password.val());
				
				dialog.dialog("close");

				/* update & select 회원정보 수정 프로시져 발샐 시점 */
			}
			return valid;
		}

		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 400,
			width : 350,
			modal : true,
			buttons : {
				"수정하기" : function(){
					form.submit();
				},
				"취소하기" : function() {
					dialog.dialog("close");
				}
			},
			close : function() {
				form[0].reset();
				allFields.removeClass("ui-state-error");
			}
		});

		form = dialog.find("form").on("submit", function(event) {
			event.preventDefault();
			/* addUser(); */
			updateUser();
		});
		
		$("#updateBtn").button().on("click", function() {
			dialog.dialog("open");
		});
	});
	
	function del_mem(){
		document.location.href="toWithdraw.do?mid=" + ${viewlist.mid};
	}
	
</script>


<!-- 주소 팝업창 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script language="javascript">
	function goPopup() {
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
		var pop = window.open("jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}

	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
			roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
			detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
			buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo, entX, entY) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.form.addr.value = roadFullAddr;
	}
</script>


<!-- 생년월일 -->
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
			yearRange : "1960:2000"
		});

	});
</script>  

<!-- 테이블 스타일 -->
<style type="text/css">
th {
	background-color: #1f4889;
	color: white;
}

td {
	size: auto auto;
}

.nowrap {
	white-space: nowrap;
}

 .center-block{
 	display: block;
 	margin-left: auto;
 	margin-right: auto;
 }
 .element{
 	.center-block();
 }
 
 
</style>


<script>
	$(document).ready(function() {
		$("#gnb1").load("gnb.jsp");
		$("#footer").load("footer.jsp");
	});
	
</script>

<!-- 프로필 사진 불러오기 및 미리보기 스크립트 -->
<link rel="stylesheet"href="//code.jquery.com/jquery-3.3.1.min.js">

<script type="text/javascript">
function getThumbnailPrivew(input, targetId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            var element = window.document.getElementById(targetId);
            element.setAttribute("src", e.target.result);
            
        }
        reader.readAsDataURL(input.files[0]);
    }	
    ResizeImage();
}

function getMessage() {
	if(<%=request.getAttribute("message")!=null%>) {
		alertify.success('<%=request.getAttribute("message")%>');
	}
};
</script>




</head>

<body class="text-center" onload="getMessage()">


<h5 id="gnb1" class="w-25 p-3"></h5>


<div class="container">

	<div id="dialog-form" title="회원정보를 수정합니다." class="container">
		<p class="validateTips">All form fields are required.</p>

		
			<!-- select로 값 받아서 value를 바꾸어 view 처리 할 부분 -->
		<fieldset>
			<form name="form1" method="POST">
				
				<label for="nicname">Nic-Name</label> 
				<input type="text" name="mnick" id="nicname" value="${viewlist.mnick}" class="text ui-widget-content ui-corner-all">
				<label for="addr">Addr</label> 
				<input type="button" onclick="goPopup()" name="maddr" id="addr" value="${viewlist.maddr}" class="text ui-widget-content ui-corner-all"> 
				<input type="hidden" name="email" id="email" value="${viewlist.mem}" class="text ui-widget-content ui-corner-all">
				<div class="form-group ">
					<label for="age">생년 월일</label> 
					<input id="datepicker" name="datepicker" class="input-lg form-control" type="button" value="${viewlist.mage}" />
					<span class="help-block"> </span>
				<input type="hidden" name="name" id="name" value="${viewlist.mname}" class="text ui-widget-content ui-corner-all">
				<input type="hidden" name="mid" value="${viewlist.mid}">
					
				</div>
					
				<label
					for="password">Password</label> 
				<input type="password"
					name="mpw" id="password" value="${viewlist.mpw }"
					class="text ui-widget-content ui-corner-all">
					
					
				<!-- Allow form submission with keyboard without duplicating the dialog button -->
				<!--style="position: absolute; top: -1000px"-->
			</form>
		</fieldset>
	</div>


	<div id="users-contain" class="row">
		<div class="col-md-6">
			<div class="form-group" id="users">
			<form action="UserUpdate.do" method="post" modelAttribute="update" enctype="multipart/form-data">
				
				<input type='hidden' value='${viewlist.mnick}' name='mnick' id='mnick' />
				<input type='hidden' value='${viewlist.maddr}' name='maddr' id='maddr'/>
				<input type='hidden' value='${viewlist.mage}' name='mage' id='mage'/>
				<input type='hidden' value='${viewlist.mpw}' name='mpw' id='mpw'/>
						
				<div>
				
				<c:choose>
						<c:when test="${viewlist.mpfimg eq null}">
							<img src="img/profile_image.jpg" width="150" height="150" class="img-upfile img-circle" id="avatar_image">
						</c:when>
						<c:otherwise>
							<img src='/ProfilePic/${viewlist.mpfimg}' width="150" height="150" class="img-upfile img-circle" id="avatar_image">
						</c:otherwise>
						</c:choose>
						<label class="custom-file">
							<input type="file" path="mpfimg_org" class="btn custom-file-input" name="mpfimg_org" id="imageFile" accept=".bmp, .gif, .jpg, .png" onclick="ResizeImage();" onchange="getThumbnailPrivew(this, 'avatar_image');">
							<input type="hidden" name="mpfimg" id="mpfimg" value="${viewlist.mpfimg}"/>
						<span class="custom-file-control"></span>
						</label>
				</div>
				<div class="checkbox">		
      				<c:choose>
      				
      				<c:when test="${viewlist.mchemail eq 'Y'}">
      					<label>
      					<input type="checkbox" name="mchemail" value="Y" checked="checked" style="float: right;">E-mail 수신동의</label>
      				</c:when>
      				
      				<c:otherwise>
	      				<label>
	      				<input type="checkbox" name="mchemail" value="Y" style="float: right;">E-mail 수신동의</label>
      				</c:otherwise>
      				
      				</c:choose>
      				
      				<input type="hidden" value="${viewlist.mem}" name="mem">
      				<div class="container text-center">
      				<button type="button" id="updateBtn" class="btn btn-primary" 
      					style="padding: 6px 12px; border-radius: 4px; border-color: #2e6da4; 
      							background-color: #337ab7; color:white; font-family:고도 M;
      							display: inline-block; font-size: 14px; font-weight: 400; height:33px;
      							    touch-action: manipulation; cursor: pointer; user-select: none;">
      				세부사항 수정하기</button>
      				<button onclick='submit' class='btn btn-primary' style="font-family:고도 M">수정완료</button>
      				<button id="withdraw-user" type="button" onclick="del_mem()" class="btn btn-danger" style="font-family:고도 M">회원탈퇴하기</button>
      				</div>
    			</div>	
				</form><span class="help-block"></span>
					
			</div>
		</div>
		<!-- --------------------------------------수정 부분 div id 수정 -->
		<div class="col-md-6" id="users">
		
			<table id="users" class="table table-hover">
				<thead>
					<tr>
						<th>Name</th>
						<th>Nic-Name</th>
						<th>Addr</th>
						<th>Email</th>
						<th>Birth</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<!-- select로 값 받아서 내용을 바꾸어 view 처리 할 부분 -->
						<td><span class="text-nowrap">${viewlist.mname} </span></td>
						<td><span class="text-nowrap">${viewlist.mnick}</span></td>
						<td><span class="text-nowrap">${viewlist.maddr}</span></td>
						<td><span class="text-nowrap">${viewlist.mem}</span></td>
						<td><span class="text-nowrap">${viewlist.mage}</span></td>
					</tr>
				</tbody>
			</table>
			
			</div>
		</div>
		<!-- --------------------------------------수정 부분 -->
		
			
				
</div>
<!-- 				<button id="update-user" class="btn btn-secondary">update user</button> -->
<!-- 				<span class="help-block"></span> -->
<!-- 			<button id="withdraw-user" type="button" onclick="del_mem()" class="btn btn-danger">회원탈퇴하기</button> -->
			<br><br><br><br><br><br><br><br><br><br>
<div id="footer"></div>	
</body>
</html>