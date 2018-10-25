<%@page import="SelCVO.BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Create YourSelf, SelC</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- alert â -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>
<style type="text/css">
thead {
	background-color: #0668a1;
	color: #ffffff;
	text-align: center;
}

</style>

</head>
<body onload="init()">
<%
	Map res = (Map)request.getAttribute("res");

	ArrayList<BoardVO> board_list = (ArrayList<BoardVO>)res.get("board_list");
	ArrayList<BoardVO> sch_list = (ArrayList<BoardVO>)res.get("sch_list");
%>

	<div id="gnb1"></div>
	
	
	<div id="myCarousel" class="carousel slide container" data-ride="carousel" style="width:70%; height:385px"> 
	
	
	
	<!--������-->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
		<li data-target="#myCarousel" data-slide-to="3"></li>
	</ol>
	<!--������-->

	<div class="carousel-inner">
		<!--�����̵�1-->
		<div class="item active"> 
			<a href="toSchedule.do">
			<img src="img/main/sports.jpg" style="width:100%; height:385px;" alt="First slide">
			</a>
			<div class="container">
				<div class="carousel-caption" style="color:#000000; font-family: �� B;">
					<h1>SCHEDULEING</h1>
					<p style="color:#000000">��ȹ�Ϸ� ����</p>
				</div>
			</div>
		</div>
		<!--�����̵�1-->

		<!--�����̵�2-->
		<div class="item"> 
			<a href="toBoardList_SCHEDULE.do?page_number=1">
			<img src="img/main/sch.PNG" style="width:100%; height:385px; alt="Second slide"></a>
			<div class="container">
				<div class="carousel-caption" style="color:#000000; font-family: �� B;">
					<h1>Schedule Share</h1>
					<p style="color:#000000">������ ����</p>
				</div>
			</div>
		</div>
		<!--�����̵�2-->
		
		<!--�����̵�3-->
		<div class="item"> 
			<a href="toBoardList_DIARY.do?page_number=1">
			<img src="img/main/music.jpg" style="width:100%; height:385px;" alt="Third slide"></a>
			<div class="container">
				<div class="carousel-caption" style="color:#FFFFFF; font-family: �� B;">
					<h1>Board</h1>
					<p style="color:#FFFFFF">SELCER</p>
				</div>
			</div>
		</div>
		<!--�����̵�3-->
		<!--�����̵�4-->
		<div class="item"> 
			<a href="toBoardList_QA.do?page_number=1">
			<img src="img/main/qna.jpg" style="width:100%; height:385px;" alt="Third slide"></a>
			<div class="container">
				<div class="carousel-caption" style="color:#000000; font-family: �� B;">
					<h1>Q & A</h1>
					<p  style="color:#000000">������ �亯</p>
				</div>
			</div>
		</div>
		<!--�����̵�4-->
	</div>
	
	<!--����, ���� ��ư-->
	<a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> 
	<a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a> 
</div>

<span class="help-block"></span>
<br>

<div class="container">
	<div class="row vertical-align">
		<div class="col-md-6">
		
		<!-- ���� �޾ƿͼ� item�� �־���ؿ� -->
		
		
		<table class="table table-hover">
			<thead>
			<tr>
				<th colspan="2" scope="col" style="width:35px; font-size:130%; padding-left:20px">
					�����층
				</th>
			</tr>
			</thead>
			<c:forEach items="<%=sch_list%>" var="sch_list" end="4">
			<tr onclick="go_SCboard_view(${sch_list.bid});" style="font-family:�� B">
				<td><input type="hidden" value="${sch_list.bid}" name="bid"> �� ${sch_list.btitle}</td>
				<td class="text-center"><img src="img/main/recommend_icon.png" height="15px" width="15px"> ${sch_list.brcm}</td>
			 </tr>
			</c:forEach>
		
		</table>
		
		
		
		</div>
		
		
		<div class="col-md-6">
		
		<!-- ���� �޾ƿͼ� item�� �־���ؿ� -->
		
		<table class="table table-hover">
			<thead>
			<tr>
				<th colspan="2" scope="col" style="width:35px; font-size:130%; padding-left:20px">
					SelCer
				</th>
			</tr>
			</thead>
			<c:forEach items="<%=board_list%>" var="board_list" end="4">
			<tr onclick="go_board_view(${board_list.bid});" style="font-family:�� B">
				<td>��${board_list.btitle}</td>
				<td class="text-center"><img src="img/main/recommend_icon.png" height="15px" width="15px">${board_list.brcm}</td>
			 </tr>
			</c:forEach>
		</table>
		
		
		</div>
	</div>
</div>




<!-- �ش� �۷� ���� ��Ʈ�ѷ� Ȯ��  -->
<script type="text/javascript" language="javascript">

	function go_board_view(go_bid){
		location.href="toBoard.do?bid=" + go_bid;
		/* location.href="Main.jsp?bid=" + go_bid; */
	}

	function go_SCboard_view(go_bid){
		location.href="toScheduleBoard.do?bid=" + go_bid;
		/* location.href="Main.jsp?bid=" + go_bid; */
	}

</script>


<div id="footer"></div>	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
	function init() {
		if(<%=request.getAttribute("message")!=null%>) {
			alertify.success('<%=request.getAttribute("message")%>');
		}
	}
</script>
	<script>
		$(document).ready(function() {
			$("#gnb1").load("gnb.jsp");
			$("#footer").load("footer.jsp");
			if(<%=request.getAttribute("mname")!=null%>)
				alertify.error("<%=request.getAttribute("mname")%>��, �׵��� �����߽��ϴ�.");
		});
	</script>
	
	

</body>
</html>