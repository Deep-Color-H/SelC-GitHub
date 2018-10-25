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
<title>Create YourSelf, SelC : 질문 게시글 수정</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />

<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<%
	Map res = (Map) request.getAttribute("res");

	ArrayList<QABoardVO> Board1 = (ArrayList<QABoardVO>) res.get("qa_board_cur");
	QABoardVO QABoard = (QABoardVO) Board1.get(0);
%>


<%-- <c:set var="IdCode" value=session.getAttribute("Cmt")/> --%>

</head>

<body>
<div id="gnb"></div>
	<!-- jQuery. 부트스트랩의 자바스크립트 플러그인이 필요. -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h2>질문 수정</h2>
		</div>


		<div class="panel-body">
			<!-- 패널 사용-->
			<div class="container">
				<form action="<%=request.getContextPath()%>/revice_QApost.do" method="get"
				modelAttribute = "QABoardVO">
					<form role="form">
						<input type="hidden" value=<%=QABoard.getBid() %> name="bid"> 
						<input type="hidden" value="BOARD_DIARY" name="bcatid" id="bcatid">
						<div class="row">
							<div class="col-md-6">
								<!-- 컨테이너안에 그리드시스템 사용 -->
								<!-- 제목  -->
								<div class="form-group">
									<label for="subject">제목 </label> <input type="text"
										class="form-control" name="btitle" id="btitle"
										value="<%=QABoard.getBtitle() %>">
								</div>
							</div>
						</div>
						<!-- 내용 -->
						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" rows="10" name="bctx" 
								id="bctx"><%=QABoard.getBctx() %></textarea>
						</div>

						<!-- 하단 버튼 -->
						<div class="center-block" style='width: 200px'>
							<input type="submit" value="등록"> <input type="reset"
								value="다시쓰기"> <input type="button" value="뒤로"
								onclick="history.back(1)"><!-- 현재페이지 1단계 뒤로감 -->
						</div>
					</form>
				</form>
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
