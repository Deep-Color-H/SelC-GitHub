%@page import="SelCVO.ScheduleVO"%>
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
<title>게시글 상세</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<%
	Map res = (Map) request.getAttribute("res");

	ArrayList<BoardVO> Board1 = (ArrayList<BoardVO>) res.get("board_cur");
	BoardVO Board = (BoardVO) Board1.get(0);

	ArrayList<CmtVO> Cmt = (ArrayList<CmtVO>) res.get("cmt_cur");
	
	if(session.getAttribute("Idcode")!=null) {
	%>	<c:set var="IdCode" value='<%=session.getAttribute("Idcode")%>' />
	<%} else {%>
	<c:set var="IdCode" value='' />
	<%}%>
	<c:set var = "diary" value='BOARD_DIARY'/>	
	<c:set var = "schedule" value='BOARD_SCHEDULE'/>
	<c:set var="Cmt" value="<%=Cmt%>" />
	<c:set var="BoardMid" value="<%=Board.getMid()%>" />
	<c:set var="BoardCat" value="<%=Board.getBcatid()%>" />

</head>
	<script language="javascript">		
         function revise_post() {
        	 location.href = "revice_postview.do?bid="+<%=Board.getBid()%>+"&bcatid="+arguments[0];
             
        	 
         }
         function delete_post() {
   			 location.href = "delete_post_diary.do?bid="+<%=Board.getBid()%>+"&bcatid="+arguments[0];
			 

         }
         
         function delete_cmt() {
        	 location.href = "delete_cmt.do?cid="+arguments[0]+"&bid="+arguments[1];  
         }
         
         function fn_rcm_post(){
        	 if(arguments[1]==""){
        		 alert("로그인이 필요합니다");
        	 }else{
        	 location.href = "rcm.do?bid="+arguments[0]+"&cid=0";
        	 document.crd1.button.disabled = true;
        	 }
         }
         function fn_rcm_cmt(){
        	 if(arguments[1]==""){
        		 alert("로그인이 필요합니다");
        	 }else{
      
        	 location.href = "rcm.do?cid="+arguments[0]+"&bid="+<%=Board.getBid()%>;
        	 document.crd.button.disabled = true;
        	 }
         }
         
         function postToCMT(){
        	 if($('#cctx').val()==null || $('#cctx').val()=="" ){
        		 alert("내용을 입력해주세요.")
        		 return false;
        	 } else {
        		 return 1;
        	 }
         }
    </script>
<body>
<div id="gnb"></div>
	<!-- jQuery. 부트스트랩의 자바스크립트 플러그인이 필요. -->
	<div class="container" style="font-family: 고도 B">
		<div class="row">
			<div class="col-xs-2 col-md-2"></div>
			<div class="col-xs-8 col-md-8">
				<h2 class="text-center">게시글 상세</h2>
				<p>&nbsp;</p>
				<div class="table table-responsive">
					<table class="table">
						<tr>
							<th class="info">조회수</th>
							<td><%=Board.getBhits()%></td>
							<th class="info">추천수</th>
							<td><%=Board.getBrcm()%></td>
						</tr>

						<tr>
							<th class="info">작성자</th>
							<td><%=Board.getMnick()%></td>
							<th class="info">작성일</th>
							<td><%=Board.getBtime()%></td>
						</tr>
						<tr>
							<th class="info">제목</th>
							<td colspan="3"><%=Board.getBtitle()%></td>
						</tr>
						<tr>
							<th class="info">스케쥴</th>
							<td colspan="3"><div id="viewSchedule"></div></td>
						</tr>
						<tr>
							<th class="info">내용</th>
							<td colspan="3"><%=Board.getBctx()%></td>

					</table>
					<c:if test ="${BoardMid ne IdCode}">
						<button name="crd1" class="btn btn-primary" onclick="fn_rcm_post('<%=Board.getBid()%>','${IdCode}')">추천</button>
					</c:if>
					<c:if test="${BoardMid eq IdCode}">
						<button class="btn btn-primary" onclick="delete_post('<%=Board.getBcatid()%>')">삭제</button>
						<button class="btn btn-primary" onclick="revise_post('<%=Board.getBcatid()%>')">수정</button>
						</c:if>
					<c:choose>
						<c:when  test="${BoardCat eq diary}">
						<button class="btn btn-primary" onclick="location.href='toBoardList_DIARY.do?page_number=1'">목록</button>
							</c:when>
						<c:when  test="${BoardCat eq schedule}">
						<button class="btn btn-primary" onclick="location.href='toBoardList_SCHEDULE.do?page_number=1'">목록</button>
							</c:when>
					</c:choose>
						


				</div>
			</div>
		</div>


		<span class="help-block"></span>
		<div class="row">
			<div class="col-xs-2 col-md-2"></div>
			<div class="col-xs-8 col-md-8">
				<div class="table table-responsive">

					<form id="postToCMT" action="postToCMT.do" method="get" onsubmit="return postToCMT();">
						<div class="form-group">
							<table class="table" style="align-items: center;">
								<tr>
									<th>
										<% if(session.getAttribute("Idcode")!=null)  {%>
										<input type="hidden" value="<%=Board.getBid()%>" name="bid"> 
										<input type="text" id="cctx" name="cctx" class="form-control" placeholder="댓글을 입력해 주세요~">
											<button type="submit" class="btn btn-primary" name=cmt_post>댓글 등록</button>
										<% } %>
									</th>
								</tr>
							</table>
							<span class="help-block"></span>
						</div>
					</form>
				</div>
			</div>
		</div>

		<span class="help-block"></span>
		<!-- 댓글  -->

		<div class="row">
			<div class="col-xs-2 col-md-2"></div>
			<div class="col-xs-8 col-md-8">
				<div class="table table-responsive">
					<table class="table" style="align-items: center;" align="center">
						<c:forEach items="${Cmt}" var="cnt">
							<tr>
								<th class="info">닉네임</th>
								<td><c:out value="${cnt.cmnick}" /></td>
								<th class="info">추천수</th>
								<td><c:out value="${cnt.crcm}" /></td>
								<c:if test="${BoardMid ne IdCode}">
								<th><button class="btn btn-primary" name="crd" onclick="fn_rcm_cmt(${cnt.cid},${IdCode})">추천</button></th>
								</c:if>
								<th class="info">작성일</th>
								<td><c:out value="${cnt.ctime}" /></td>
							</tr>
							<tr>
								<th class="info">내용</th>
								<td colspan="5"><c:out value="${cnt.cctx}" /></td>
								<c:if test="${cnt.cmid eq IdCode}">
									<th>
										<button class="btn btn-primary"
											onclick="delete_cmt(${cnt.cid},'<%=Board.getBid()%>')">삭제</button>
									</th>
								</c:if>
							</tr>

						</c:forEach>
					</table>
				</div>
			</div>
			<!-- COL의 끝 -->
		</div>
		<!-- ROW의 끝  -->

	</div>
	<!-- 컨테이너의끝  -->


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#gnb").load("gnb.jsp");
			$.ajax({
				type:"GET",
				url:"view_SCHEDULE.do",
				dataType:'html',
				error:function() {
					alert("통신실패");
				},
				success:function(data) {
					$("#viewSchedule").html(data);
				}
			});
		});
	</script>
</body>
</html>
