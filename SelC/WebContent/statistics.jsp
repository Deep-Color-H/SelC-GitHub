<%@page import="SelCVO.ScheduleVO"%>
<%@page import="SelCVO.CmtVO"%>
<%@page import="SelCVO.BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Create YourSelf, SelC : Selcer 통계</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>
</head>
<body>
<div id="gnb"></div>
<br><br><br>
<script type="text/javascript">
	function tab_menu(num){
		 var f = $('#myTab').find('li');
		 for ( var i = 0; i < f.length; i++ ) { 
			  if ( i == num) { 
				   f.eq(i).addClass('active');
				   $('#myTab' + i ).show();
			  } else {
				   f.eq(i).removeClass('active');   
				   $('#myTab' + i ).hide();
			  }
		 }
	}
</script>
<div class="container" style="font-family: 고도 B">
  <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
    <ul id="myTab" class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
      	<a href="#loc" role="tab" id="loc-tab" data-toggle="tab" aria-controls="loc" aria-expanded="true" onclick='tab_menu(0)' ><h3>&nbsp; 주거지 기준 통계 &nbsp;</h3></a>
      </li>
      <li role="presentation">
      	<a href="#sloc" role="tab" id="sloc-tab" data-toggle="tab" aria-controls="sloc" onclick='tab_menu(1)'><h3>&nbsp; 활동지역 기준 통계 &nbsp;</h3></a>
      </li>
      <li role="presentation">
      	<a href="#age" role="tab" id="age-tab" data-toggle="tab" aria-controls="age" onclick='tab_menu(2)'><h3>&nbsp; 나이 기준 통계 &nbsp;</h3> </a>
      </li>
    </ul>
    <div id="myTabContent" class="tab-content">
      <div role="tabpanel"  id="myTab0" aria-labelledBy="loc-tab" >
      	<br>
      	<table class="table-bordered text-center" width="100%">
      		<tr height="50px">
      			<td width="20%" rowspan="2">
      				강남구
      			</td>
      			<td width="26%">
      				지역 내 인기순위
      			</td>
      			<td width="26%">
      				선호 거리 그래프
      			</td>
      			<td width="26%">
      				선호 금액 그래프
      			</td>
      		</tr>
      		<tr height="200px">
      			<td width="26%">
      				1위 : 언어 영역<br>
      				2위: 컴퓨터 영역<br>
      				3위: 운동 영역<br>
      			</td>
      			<td width="26%">
      				그래프가 들어갑니다.
      			</td>
      			<td width="26%">
      				그래프가 들어갑니다.
      			</td>
      		</tr>
      		<tr height="50px">
      			<td width="20%" rowspan="2"  colspan="2" style="border-bottom-color: white; border-left-color: white">
      				
      			</td>
      			<td width="26%">
      				자기계발 평균 시작시간
      			</td>
      			<td width="26%">
      				자기계발 평균 종료시간
      			</td>
      		</tr>
      		<tr height="200px">
      			<td width="26%">
      				00:00<br>
      				(00%)
      			</td>
      			<td width="26%">
      				00:00<br>
      				(00%)
      			</td>
      		</tr>
      	</table>

      </div>
      <div role="tabpanel"  id="myTab1" aria-labelledBy="sloc-tab" style="display: none;">
              	<br>
      	<table class="table-bordered text-center" width="100%">
      		<tr height="50px">
      			<td width="20%" rowspan="2">
      				강남구
      			</td>
      			<td width="26%">
      				지역 내 인기순위
      			</td>
      			<td width="26%">
      				선호 거리 그래프
      			</td>
      			<td width="26%">
      				선호 금액 그래프
      			</td>
      		</tr>
      		<tr height="200px">
      			<td width="26%">
      				1위 : 언어 영역<br>
      				2위: 컴퓨터 영역<br>
      				3위: 운동 영역<br>
      			</td>
      			<td width="26%">
      				그래프가 들어갑니다.
      			</td>
      			<td width="26%">
      				그래프가 들어갑니다.
      			</td>
      		</tr>
      		<tr height="50px">
      			<td width="20%" rowspan="2"  colspan="2" style="border-bottom-color: white; border-left-color: white">
      				
      			</td>
      			<td width="26%">
      				자기계발 평균 시작시간
      			</td>
      			<td width="26%">
      				자기계발 평균 종료시간
      			</td>
      		</tr>
      		<tr height="200px">
      			<td width="26%">
      				00:00<br>
      				(00%)
      			</td>
      			<td width="26%">
      				00:00<br>
      				(00%)
      			</td>
      		</tr>
      	</table>
      </div>
      <div role="tabpanel" id="myTab2" aria-labelledBy="age-tab" style="display: none;">
              	<br>
      	<table class="table-bordered text-center" width="100%">
      		<tr height="50px">
      			<td width="33%">
      				20대 초반
      			</td>
      			<td width="34%">
      				20대 후반
      			</td>
      			<td width="33%">
      				30대
      			</td>
      		</tr>
      		<tr height="200px">
      			<td width="33%">
      				그래프가 들어갑니다.
      			</td>
      			<td width="34%">
      				그래프가 들어갑니다.
      			</td>
      			<td width="33%">
      				그래프가 들어갑니다.
      			</td>
      		</tr>
      	</table>
      </div>
    </div>
  </div>
</div>
<div id="footer"></div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#gnb").load("gnb.jsp");
			$("#footer").load("footer.jsp");
		});
	</script>
</body>
</html>