<%@page import="SelCVO.QABoardVO"%>
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
<title>Create YourSelf, SelC : 질문 게시판</title>

<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>

<%
	Map res = (Map) request.getAttribute("res");

	ArrayList<QABoardVO> Board1 = (ArrayList<QABoardVO>) res.get("qa_board_cur");
	QABoardVO Board = (QABoardVO) Board1.get(0);

	ArrayList<CmtVO> Cmt = (ArrayList<CmtVO>) res.get("qa_cmt_cur");
	if(session.getAttribute("Idcode")!=null){
		%>	<c:set var="IdCode" value='<%=session.getAttribute("Idcode")%>' />
		<%}else{%>
		<c:set var="IdCode" value='' />
		<%}%>
<c:set var="Cmt" value="<%=Cmt%>" />
<c:set var="Y" value='Y' />
<c:set var="N" value='N' />
<c:set var="BoardMid" value="<%=Board.getMid()%>" />
<c:set var="QABoardBACH" value="<%=Board.getBach()%>" />

<%-- <c:set var="IdCode" value=session.getAttribute("Cmt")/> --%>

</head>

<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<div id="gnb"></div>
	<script language="javascript">		
    function revise_qapost() {
   	 location.href = "revice_QApostview.do?bid="+<%=Board.getBid()%>;
        
   	 
    }
    function delete_qapost() {
    	location.href = "delete_qapost_diary.do?bid="+<%=Board.getBid()%>+"&bcatid="+arguments[0];
    }
    
    function delete_qacmt() {
    	
   	 location.href = "delete_qacmt.do?cid="+arguments[0]+"&bid="+arguments[1];  
   	document.crd1.button.disabled = true;
    }
    

    function fn_rcm_qacmt(){
   	 	if(arguments[1]==""){
			 alertify.error("로그인이 필요합니다");
	 	}else{

	 	location.href = "qarcm.do?cid="+arguments[0]+"&bid="+<%=Board.getBid()%>;
	 	document.crd.button.disabled = true;
	 	}

    }
    
    function postToCMT(){
   	 if($('#cctx').val()==null || $('#cctx').val()=="" ){
   		 alertify.error("내용을 입력해주세요.")
   		 return false;
   	 } else {
   		 return 1;
//    		var cctx = $('#cctx').val();
<%--         		document.location.href = "postToCMT.do?cctx="+cctx+"&bid="+<%=Board.getBid()%>; --%>
   	 }
    }

    </script>
	<!-- jQuery. 부트스트랩의 자바스크립트 플러그인이 필요. -->
	<div class="container">
		<div class="row">
			<div class="col-xs-2 col-md-2"></div>
			<div class="col-xs-8 col-md-8">
				<h2 class="text-center">질문내용</h2>
				<p>&nbsp;</p>
				<div class="table table-responsive">
					<table class="table">
						<tr>
							<th class="info">조회수</th>
							<td><%=Board.getBhits()%></td>
							<th class="info">답변여부</th>
							<td><c:choose>
									<c:when test="${QABoardBACH eq N}">답변대기중</c:when>
									<c:when test="${QABoardBACH eq Y}">답변완료</c:when>
								</c:choose></td>
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
							<th class="info">내용</th>
							<td colspan="3"><%=Board.getBctx()%></td>
						</tr>

					</table>


					<button class="btn btn-primary"
						onclick="location.href='toBoardList_QA.do?page_number=1'">목록</button>
					<c:if test="${BoardMid eq IdCode}">
						<button class="btn btn-primary" onclick="revise_qapost('<%=Board.getBid()%>')">수정</button>
						<button class="btn btn-danger" onclick="delete_qapost('<%=Board.getBid()%>')">삭제</button>

					</c:if>


				</div>
			</div>
		</div>


		<span class="help-block"></span>
		<div class="row">
			<div class="col-xs-2 col-md-2"></div>
			<div class="col-xs-8 col-md-8">
				<div class="table table-responsive">

					<form id="QApostToCMT" action="postToQACMT.do" method="get" onsubmit="return postToCMT();">
						<div class="form-group">
							<table class="table" style="align-items: center;">


								<tr>
									<th>
										<%
											if (session.getAttribute("Idcode") != null) {
										%> <input type="hidden" value="<%=Board.getBid()%>" name="bid">
										<input type="text" id="cctx" name="cctx" class="form-control" maxlength="150" placeholder="댓글을 입력해 주세요~">
										<button type="submit" class="btn btn-primary" name=cmt_post>답변 등록</button> 
										<% 	} %>
									</th>
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
				  <c:forEach items="${Cmt}" var="cnt">
				  	  <div class="panel panel-info text-center" 
				  	  		style="position: relative; background-color: #daeaf0; z-index:3; padding-top:10px; width: 300px; height:40px; font-family:고도 B; font-size:120%; margin-left:30px; margin-bottom:-18px" >
				  		  <c:out value="${cnt.cmnick}" /> 님의 답변입니다.
				  	  </div>
				  	  <div class="panel panel-primary"
				  		  style="position: relative; z-index:2; padding:30px; width: 100%; height:180px; font-family:고도 M; font-size:100%;" >
				  	  	  <div class="well" style="height:100px; font-size:110%;  margin-bottom:5px">
				  	  	  	<c:out value="${cnt.cctx}" />
				  	  	  </div>
				  	  	  <div class="text-right" style="height:20px;">
				  	  	 	<c:if test="${cnt.cmid eq IdCode}">
										<button class="btn btn-danger"
											onclick="delete_qacmt(${cnt.cid},'<%=Board.getBid()%>')">삭제</button>&nbsp; &nbsp; &nbsp;
							</c:if>
							<c:if test="${cnt.cmid ne Idcode }">
				  	  	  	<button class="btn btn-primary" name="crd" onclick="fn_rcm_qacmt(${cnt.cid},${IdCode})">추천</button>&nbsp; &nbsp; &nbsp; &nbsp;
							</c:if>
				  	  	  	추천수 : <c:out value="${cnt.crcm}" /> &nbsp; / &nbsp; 작성일 : <c:out value="${cnt.ctime}" />
				  	  	  </div>
				  	  </div>
				    </c:forEach>
				</div>
			</div>
			<!-- COL의 끝 -->
		</div>
		<!-- ROW의 끝  -->

	</div>
	<!-- 컨테이너의끝  -->
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
