<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="SelCVO.ScheduleVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create YourSelf, SelC : 스케쥴게시판 글쓰기</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>

<!-- 부트스트랩링크 -->

<!--[if lt IE 9]> 
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script> 
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script> 
<![endif]-->
<%
	HashMap<String, Object> ScheduleMap = (HashMap<String, Object>)request.getAttribute("ScheduleMap");
	HashMap<String, ScheduleVO> ScheduleList = (HashMap<String, ScheduleVO>) ScheduleMap.get("ScheduleList");
	ArrayList<String> StitleList = (ArrayList<String>)ScheduleMap.get("STitleList"); 
	session.setAttribute("ScheduleList",ScheduleList);
%>
<script>
	function makeScheduleDiv() {
		var stitle = $("#schedule option:selected").val();
		$.ajax({
			type:"POST",
			url:"make_SCHEDULE.do",
			data: { 'stitle' : stitle },
			dataType:'html',
			error:function() {
				alert("통신실패");
			},
			success:function(data) {
				$("#viewSchedule").html(data);
			}
		});
	}
	
	function post() {
		if($('#btitle').val()==null || $('#btitle').val()=="" ){
   			alertify.error("제목을 입력해주세요.")
   			return false;
		} else if($('#schedule option:selected').val()==null || $('#schedule option:selected').val()=="" ){
			alertify.error("공유하실 스케쥴을 선택해주세요.")
   			return false;
		} else if($('#bctx').val()==null || $('#bctx').val()=="" ){
			alertify.error("내용을 작성해주세요.")
   			return false;
   	 } else {
   		 return 1;
   	 }
	}
</script>
</head>
<body>
<c:set var="StitleList" value="<%=StitleList%>"/>
<div id="gnb"></div>


	<!-- jQuery. 부트스트랩의 자바스크립트 플러그인이 필요. -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<div class="panel panel-default" style="font-family: 고도 B;">
		<div class="panel-heading" width="400px">
			<h2 class="container"> 게시판 글쓰기</h2>
		</div>


		<div class="panel-body">
			<!-- 패널 사용-->
			<div class="container">
				<form action="<%=request.getContextPath()%>/postBoard_Schedule.do" method="POST" modelAttribute ="BoardVO">
					<form role="form">
						<input type="hidden" value="BOARD_SCHEDULE" name="bcatid" id="bcatid">
						<div class="row">
							<div class="col-md-6">
								<!-- 컨테이너안에 그리드시스템 사용 -->
								<!-- 제목  -->
								<div class="form-group">
									<label for="subject">제목 </label> <input type="text"
										class="form-control" name="btitle" id="btitle"
										placeholder="Enter Title">
								</div>
							</div>
						</div>
						<!-- 스케쥴 선택 // -->
						<div> 
							<label for="subject">스케쥴 선택</label> 
							<select class="form-control" name="schedule" id="schedule" placeholder="스케쥴을 선택해주세요"
							        onchange="makeScheduleDiv()"> 
								<option ></option> 
								<%
								for(String title : StitleList) {
									if(title!=null) {%>
								<option ><%=title%></option> 
								<%} }%>
							</select> 
						</div>
						<span class="help-block"></span>
						<div>
						<label for="subject">보여질 스케쥴</label> 
						<div class="form-control"  style="border-radius: 5px;height:240px; padding:10px; vertical-align:middel;">
							<div id="viewSchedule"></div>
						</div>
						</div>
						<span class="help-block"></span>
						
						<!-- 내용 -->
						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" rows="10" name="bctx"
								id="bctx"></textarea>
						</div>


						<!-- 하단 버튼 -->
						<div class="center-block" style='width: 200px'>
							<input type="submit" class="btn btn-primary" value="등록" onclick="return post()"> 
							<input type="reset" class="btn btn-primary" value="다시쓰기"> 
							<!-- 현재페이지 1단계 뒤로감 -->
							<input type="button" class="btn btn-primary" value="뒤로" onclick="history.back(1)">
						</div>
					</form>
				</form>
			</div>
		</div>
	</div>
	<div id="footer"></div>	
		<script>
		$(document).ready(function() {
			$("#gnb").load("gnb.jsp");
			$("#footer").load("footer.jsp");
		});
	</script>
</body>
</html>