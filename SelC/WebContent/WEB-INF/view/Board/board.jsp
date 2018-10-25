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
<title>Create YourSelf, SelC : SelCer 게시판</title>
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

	ArrayList<BoardVO> Board1 = (ArrayList<BoardVO>) res.get("board_cur");
	BoardVO Board = (BoardVO) Board1.get(0);
	
	// 08-07 업데이트
	String imgpath = Board.getBimg();

	ArrayList<CmtVO> Cmt = (ArrayList<CmtVO>) res.get("cmt_cur");
	
	if(session.getAttribute("Idcode")!=null){
	%>	<c:set var="IdCode" value='<%=session.getAttribute("Idcode")%>' />
	<%}else{%>
	<c:set var="IdCode" value='' />
	<%}%>
<c:set var = "diary" value='BOARD_DIARY'/>
<c:set var = "schedule" value='BOARD_SCHEDULE'/>
<c:set var="Cmt" value="<%=Cmt%>" />
<c:set var="BoardMid" value="<%=Board.getMid()%>" />
<c:set var="BoardCat" value="<%=Board.getBcatid()%>" />
<!-- 08-07 업데이트 -->
<c:set var="imgpath" value="<%=imgpath%>" />

<style type="text/css">
#rcorners1 {
    border-radius: 25px;
    border: 2px solid #eaeaea;
    padding: 20px; 
    width: 750px;
    height: 500px; 
    overflow:auto;
}

#rcorners2 {
    border-radius: 25px;
    border: 2px solid #0668a1;
    padding: 20px; 
    width: 540px;
    height: 200px; 
}


/* 이미지 키우기 스타일 */
#myImg {
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
}

#myImg:hover {opacity: 0.7;}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

/* Modal Content (image) */
.modal-content {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
}

/* Caption of Modal Image */
#caption {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
    text-align: center;
    color: #ccc;
    padding: 10px 0;
    height: 150px;
}

/* Add Animation */
.modal-content, #caption {    
    -webkit-animation-name: zoom;
    -webkit-animation-duration: 0.6s;
    animation-name: zoom;
    animation-duration: 0.6s;
}

@-webkit-keyframes zoom {
    from {-webkit-transform:scale(0)} 
    to {-webkit-transform:scale(1)}
}

@keyframes zoom {
    from {transform:scale(0)} 
    to {transform:scale(1)}
}

/* The Close Button */
.close {
    position: absolute;
    top: 15px;
    right: 35px;
    color: #f1f1f1;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
}

.close:hover,
.close:focus {
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
    .modal-content {
        width: 100%;
    }
}




</style>

<!-- 이미지 키우기 스크립트 -->


</head>

<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<div id="gnb"></div>
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
        		 alertify.error("로그인이 필요합니다");
        	 }else{
        	 location.href = "rcm.do?bid="+arguments[0]+"&cid=0";
        	 document.crd1.button.disabled = true;
        	 }
         }
         function fn_rcm_cmt(){
        	 if(arguments[1]==""){
        		 alertify.error("로그인이 필요합니다");
        	 }else{
      
        	 location.href = "rcm.do?cid="+arguments[0]+"&bid="+<%=Board.getBid()%>;
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
							<td><span style="float: left; font-weight: bold;"> <%=Board.getBtitle()%> </span> <span style="float: right"><%=Board.getBtime()%></span></td>
						</tr>
						<tr>
							<td><span style="float: left"> <%=Board.getMnick()%> </span> <span style="float: right"> 조회수 <%=Board.getBhits()%> 추천수 <%=Board.getBrcm()%> </span></td>
						</tr>
					</table>
				
					<!-- 08-07 업데이트 -->
					
					<div>
					<p id="rcorners1" class="w3-theme-border">
							<c:choose>
							
								<c:when test="${imgpath eq null }">
								
								</c:when>
								
								<c:otherwise>
								<img  src="/BoardPic/${imgpath}"
								 class="img-upfile" id="myImg"
								 align="middle"
								 style="max-height: 80%; max-width: 80%; margin-left: auto; margin-right: auto; display: block">
								
								 
								</c:otherwise>
								
							</c:choose>
							<span class="help-block" style="margin-top: 15px">
							<%=Board.getBctx()%>
							</span>
					</p>		
					
							
							</div>
							<span class="help-block"></span>
					
					<c:if test ="${BoardMid ne IdCode}">
						
					<span style="float: right;">
						<button name="crd1" class="btn btn-primary" onclick="fn_rcm_post('<%=Board.getBid()%>','${IdCode}')">추천</button></span>	
					</c:if>
					<c:if test="${BoardMid eq IdCode}">
					<span style="float: right; margin-right: 10px ">
						<button class="btn btn-primary" onclick="delete_post('<%=Board.getBcatid()%>')">삭제</button></span>
					<span style="float: right; margin-right: 10px">
						<button class="btn btn-primary" onclick="revise_post('<%=Board.getBcatid()%>')">수정</button></span>
						</c:if>
					<c:choose>
						<c:when  test="${BoardCat eq diary}">
					<span style="float: right; margin-right: 10px">
						<button class="btn btn-primary" onclick="location.href='toBoardList_DIARY.do?page_number=1'">목록</button></span>
							</c:when>
						<c:when  test="${BoardCat eq schedule}">
					<span style="float: right;">
						<button class="btn" onclick="location.href='toBoardList_SCHEDULE.do?page_number=1'">목록</button></span>
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
										<button class="btn btn-danger" onclick="delete_cmt(${cnt.cid},'<%=Board.getBid()%>')">삭제</button>
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
<div id="myModal" class="modal">
  <span class="close">&times;</span>
  <img class="modal-content" id="img01">
  <div id="caption"></div>
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
	<script>
// Get the modal
var modal = document.getElementById('myModal');

// Get the image and insert it inside the modal - use its "alt" text as a caption
var img = document.getElementById('myImg');
var modalImg = document.getElementById("img01");
var captionText = document.getElementById("caption");
img.onclick = function(){
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
}

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on <span> (x), close the modal
span.onclick = function() { 
    modal.style.display = "none";
}
</script>
	
</body>
</html>
