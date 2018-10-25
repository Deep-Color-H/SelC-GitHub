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
<title>Create YourSelf, SelC : 스케쥴 게시판</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>

<%
	Map res = (Map) request.getAttribute("res");

	ArrayList<BoardVO> Board1 = (ArrayList<BoardVO>) res.get("board_cur");
	BoardVO Board = (BoardVO) Board1.get(0);
/* 08-06 업데이트  */
	
	String path = (String)res.get("path");
	
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
	<!--08-06 업데이트  -->
	<c:set var="Path" value="<%=path %>" />

</head>
	<script language="javascript">		
         function revise_post() {
        	 location.href = "revice_SC_postview.do?bid="+<%=Board.getBid()%>+"&bcatid="+arguments[0];
             
        	 
         }
         function delete_post() {
   			 location.href = "delete_SC_post_diary.do?bid="+<%=Board.getBid()%>+"&bcatid="+arguments[0];
			 

         }
         
         function delete_cmt() {
        	 location.href = "delete_SC_cmt.do?cid="+arguments[0]+"&bid="+arguments[1];  
         }
         function fn_rcm_post(){
        	 if(arguments[1]==""){
        		 alertify.error("로그인이 필요합니다");
        	 }else{
        	 location.href = "rcm_sc.do?bid="+arguments[0]+"&cid=0";
        	 document.crd1.button.disabled = true;
        	 }
         }
         function fn_rcm_cmt(){
        	 if(arguments[1]==""){
        		 alertify.error("로그인이 필요합니다");
        	 }else{
      
        	 location.href = "rcm_sc.do?cid="+arguments[0]+"&bid="+<%=Board.getBid()%>;
        	 document.crd.button.disabled = true;
        	 }
         }
         
         function postToCMT(){
        	 if($('#cctx').val()==null || $('#cctx').val()=="" ){
        		 alertify.error("내용을 입력해주세요.")
        		 return false;
        	 } else {
        		 return 1;
        	 }
         }
    </script>
<body>
<div id="gnb"></div>
<div class="container" style="font-family: 고도 B">
	<br><br>
	
	<!-- 08-06 업데이트 -->
	<c:choose>
		<c:when test="${Path eq null}">
			<img src="img/profile_image.jpg"
			 width="200" height="200"
			 class="img-upfile img-circle" id="avatar_image"
			 style="position:absolute; top: 140px; left:16%; z-index: 3">
		
		</c:when>
		
		<c:otherwise>
			<img src="/ProfilePic/${Path}"
			 width="200" height="200"
			 class="img-upfile img-circle" id="avatar_image"
			 style="position:absolute; top: 140px; left:16%; z-index: 3">
		
		</c:otherwise>
	
	</c:choose>
	
	<br>
		<div class="panel panel-default col-md-8" 
			style="padding-left: 110px; padding-top:6px; padding-bottom:6px; font-size:125%; width:700px;
				   position:absolute; top: 170px; left:25%">
		제목 : <%=Board.getBtitle()%>
		</div>
		<div class="panel panel-default col-md-8" 
			style="padding-left: 148px; padding-top:6px; padding-bottom:6px; font-size:125%; width:660px;
			       position:absolute; top: 220px; left:25%">
		자기개발자 : <%=Board.getMnick()%>
		</div>
		<div class="panel panel-default col-md-8" 
			style="padding-left: 100px; padding-top:6px; padding-bottom:6px; font-size:125%; width:620px;
			       position:absolute; top: 270px; left:25%">
		작성일 : <%=Board.getBtime()%>
		</div>
</div>
	<br><br><br><br><br><br><br><br>
	<div class="row">
	<div class="col-md-8 strong text-right" style="font-family:고도 B; padding-top:5px; ">
	추천수 : <%=Board.getBrcm()%> / 조회수 : <%=Board.getBhits()%>&nbsp; &nbsp; &nbsp; 
	<c:if test ="${BoardMid ne IdCode}">
		<button name="crd1" class="btn btn-primary" style="font-family:고도 B" onclick="fn_rcm_post('<%=Board.getBid()%>','${IdCode}')">추천</button>
	</c:if>
	<c:choose>
		<c:when  test="${BoardCat eq diary}">
			<button class="btn btn-primary" style="font-family:고도 B" onclick="location.href='toBoardList_DIARY.do?page_number=1'">목록</button>
		</c:when>
		<c:when  test="${BoardCat eq schedule}">
			<button class="btn btn-primary" style="font-family:고도 B" onclick="location.href='toBoardList_SCHEDULE.do?page_number=1'">목록</button>
		</c:when>
	</c:choose>
	<c:if test="${BoardMid eq IdCode}">
		<button class="btn btn-primary" style="font-family:고도 B" onclick="revise_post('<%=Board.getBcatid()%>')">수정</button>
		<button class="btn btn-danger" style="font-family:고도 B" onclick="delete_post('<%=Board.getBcatid()%>')">삭제</button>
	</c:if>
	</div>
	</div>
	<br>
	<div class="container row">
		<div class="col-md-3"></div>
		<div class="panel panel-info col-md-9">
			<div class="panel-heading"><h4 style="font-family: 고도 B;">스케쥴</h4></div>
			<div class="panel-body" id="viewSchedule"></div>
		</div>
	</div>
<br>
	<div class="container row">
		<div class="col-md-3"></div>
		<div class="panel panel-info col-md-9">
			<div class="panel-heading"><h4 style="font-family: 고도 B;">스케쥴 설명</h4></div>
			<div class="panel-body" style="font-family: 고도 B"><%=Board.getBctx()%></div>
		</div>
	</div>
	<br>
	<div class="container row">
		<div class="col-md-3"></div>
		<div class="col-md-9">
				<form id="postTo_CMT" action="postTo_SC_CMT.do" method="get" onsubmit="return postToCMT();">
					<div class="row">
									<% if(session.getAttribute("Idcode")!=null)  {%>
									<input type="hidden" value="<%=Board.getBid()%>" name="bid"> 
									<input type="text" id="cctx" name="cctx" class="panel panel-info col-md-10" 
									style="height:50px" maxlength="150"
									placeholder="댓글을 입력해 주세요~">
									<button type="submit" class="btn btn-primary col-md-2" name="cmt_post" style="font-family:고도 B; height:50px">
									댓글 등록</button>
									<% } %>
					</div>
				</form>
		</div>
	
				<!-- 댓글  -->

		<div class="container row">
			<div class="col-md-3"></div>
			<div class="col-md-9">
				<div class="table table-responsive">
				  <c:forEach items="${Cmt}" var="cnt">
					   <div class="panel panel-info text-center" 
				  	  		style="position: relative; background-color: #daeaf0; z-index:3; padding-top:10px; width: 300px; height:40px; font-family:고도 B; font-size:120%; margin-left:30px; margin-bottom:-18px" >
				  		  <c:out value="${cnt.cmnick}" /> 님의 댓글입니다.
				  	  </div>
				  	  <div class="panel panel-primary"
				  		  style="position: relative; z-index:2; padding:30px; width: 100%; height:180px; font-family:고도 M; font-size:100%;" >
				  	  	  <div class="well" style="height:100px; font-size:110%;  margin-bottom:5px">
				  	  	  	<c:out value="${cnt.cctx}" />
				  	  	  </div>
				  	  	  <div class="text-right" style="height:20px;">
				  	  	 	<c:if test="${cnt.cmid eq IdCode}">
										<button class="btn btn-danger"
											onclick="delete_cmt(${cnt.cid},'<%=Board.getBid()%>')">삭제</button>&nbsp; &nbsp; &nbsp; &nbsp;
							</c:if>
							<c:if test="${cnt.cmid ne Idcode }">
				  	  	  	<button class="btn btn-primary" name="crd" onclick="fn_rcm_cmt(${cnt.cid},${IdCode})">추천</button>&nbsp; &nbsp; &nbsp; &nbsp;
							</c:if>
				  	  	  	추천수 : <c:out value="${cnt.crcm}" /> &nbsp; / &nbsp; 작성일 : <c:out value="${cnt.ctime}" />
				  	  	  </div>
				  	  </div>
				    </c:forEach>
				</div>
			</div>
			<!-- COL의 끝 -->
		</div>
	</div>
<div id="footer"></div>	
	<!-- 컨테이너의끝  -->


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#gnb").load("gnb.jsp");
			$("#footer").load("footer.jsp");
			$.ajax({
				type:"GET",
				url:"view_SCHEDULE.do",
				dataType:'html',
				error:function() {
					alertify.error("통신실패");
				},
				success:function(data) {
					$("#viewSchedule").html(data);
				}
			});
		});
	</script>
</body>
</html>
