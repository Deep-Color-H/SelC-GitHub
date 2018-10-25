<%@page import="java.util.*"%>
<%@page import="SelCVO.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Create Yourself, SelC : 스케쥴 게시판</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>

</head>
<body>
	<c:set var="IdCode" value='<%=session.getAttribute("Idcode")%>' />
	<script>
		function gotoCnt() {
			document.location.href="toScheduleBoard.do?bid="+arguments[0];
		}
		
		function gotoWrite() {
			if(arguments[0]==null){
				alertify.error("로그인이 필요합니다.")
			}else{
				document.location.href="gotoWrite_SCHEDULE.do";
			}
		}
		 function getOptions() {
	            document.getElementById("option").value = $('#srchOptionS').val();
	            if($('#option').val()==null||$('#option').val()=="") {
	                alertify.error("실패!");
	                return false;
	            }
	            return true;
	        }
	</script>
<!-- 가져온 변수들을 Var의 형태로 저장한다. -->
<% 
	Map res = (Map)request.getAttribute("res"); 

	ArrayList<BoardVO> list = (ArrayList<BoardVO>)res.get("rs_list_cur");
	int page_number = (int)res.get("page_number");
	int page_count = (int)res.get("page_count");
	int list_count = (int)res.get("list_count");
	
%>
	
	<c:set var="list" value="<%=list%>"/>
	<c:set var="page_number" value="<%=page_number%>"/>
	<c:set var="page_count" value="<%=page_count%>"/>
	<c:set var="list_count" value="<%=list_count%>"/>
	
<!-- GNB -->
	<div id="gnb1"></div>
<!-- TABLE -->
	<div class="container">
		<img class="img-rounded" src="img/Board/Board_Schedule.png" style="width: 100%; height: auto;"><br />
		<br />
	</div>
	<div class="container">
		<table class="table table-bordered table-hover" style="font-family:고도 M">
			<thead>
				<tr style="background-color:#0668a1; color:#ffffff">
					<th width="8%" class="text-center">번호</th>
					<th width="40%" class="text-center">제목</th>
					<th width="20%" class="text-center">자기개발자</th>
					<th width="16%" class="text-center">등록일</th>
					<th width="8%" class="text-center">추천수</th>
					<th width="8%" class="text-center">조회수</th>
				</tr>
			</thead>
			<c:forEach items="${list}" var="obj" varStatus="i">
			<tr>
				<td class="text-center">
				<c:out value="${list_count-i.index-(page_number-1)*20}"/>
				</td>
				<td onclick="gotoCnt(${obj.bid});" style="padding-left:20px">ㆍ<c:out value="${obj.btitle}"/></td>
				<td class="text-center"><c:out value="${obj.mnick}"/></td>
				<td class="text-center"><c:out value="${obj.btime}"/></td>
				<td class="text-center"><c:out value="${obj.brcm}"/></td>
				<td class="text-center"><c:out value="${obj.bhits}"/></td>
			</tr>
			</c:forEach>
		</table>
	</div>
				<div class="container" style="line-height: 1em">
			<div class="text-right">
				<a class="btn btn-center btn-primary" style="width:100px; font-family: 고도 M" onclick="gotoWrite(${IdCode})" >글쓰기</a> 
			</div>
			<br/>
			<div class="text-right" style="line-height: 1em;">
				<div id="srchOption">
				<select class="panel panel-primary" id="srchOptionS" name="srchOptionS" 
						style="width: 258px; height: 30px; font-family: 고도 M; margin-bottom:2.4px;">
					<option value=1 selected="selected">&nbsp; &nbsp;제목으로 검색</option>
					<option value=2>&nbsp; &nbsp;내용으로 검색</option>
					<option value=3>&nbsp; &nbsp;개발자이름으로 검색</option>
				</select>
				</div>
				<form name="goSrch" action ="goScheduleSrch.do"  method="get" onsubmit="return getOptions()">
					<div id="srchText" class=''>
						<input type="hidden" value='1' name="page_number">
						<input type="hidden" id="option" name ="option">
						<input type="text" class="panel panel-primary"  placeholder="" name="content"
								style="font-family:고도 M; width:200px; height: 30px"/>
						<button class="btn btn-primary" style="font-family:고도 M">검  색</button>
					</div>
				</form> 
			</div>
		</div>
		<div class="text-center">
			<ul class="pagination">
				<c:forEach begin="1" varStatus="i" end="${page_count}" >
				<li><a href="toBoardList_SCHEDULE.do?page_number=${i.count}">${i.count}</a></li>
				</c:forEach>
			</ul>
		</div>
	<div id="footer"></div>	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#gnb1").load("gnb.jsp");
			$("#footer").load("footer.jsp");
		});
	</script>
</body>
</html>