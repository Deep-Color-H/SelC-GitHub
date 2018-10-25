	<%@page import="SelCVO.CmtVO"%>
<%@page import="SelCVO.BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Create YourSelf, SelC : SelCer 게시글 수정</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />

<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- 부트스트랩링크 -->

<!--[if lt IE 9]> 
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script> 
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script> 
<![endif]-->


<%
	Map res = (Map) request.getAttribute("res");

	ArrayList<BoardVO> Board1 = (ArrayList<BoardVO>) res.get("board_cur");
	BoardVO Board = (BoardVO) Board1.get(0);
	
	/* 08-07 업데이트 */
	String imgpath = Board.getBimg();
%>

<c:set value="<%=imgpath %>" var="imgpath" />

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

</script>


</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<div id="gnb1"></div>
	<!-- jQuery. 부트스트랩의 자바스크립트 플러그인이 필요. -->
	<script src="js/bootstrap.min.js"></script>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h2>게시판 글쓰기</h2>
		</div>


		<div class="panel-body">
			<!-- 패널 사용-->
			<div class="container">
				<form action="<%=request.getContextPath()%>/revice_post.do" method="post"
				modelAttribute = "BoardVO" enctype="multipart/form-data">
					<form role="form">
						<input type="hidden" value=<%=Board.getBid() %> name="bid"> 
						<input type="hidden" value=<%=Board.getBimg() %> name="bimg"> 
						<input type="hidden" value="BOARD_DIARY" name="bcatid" id="bcatid">
						<div class="row">
							<div class="col-md-6">
								<!-- 컨테이너안에 그리드시스템 사용 -->
								<!-- 제목  -->
								<div class="form-group">
									<label for="subject">제목 </label> <input type="text"
										class="form-control" name="btitle" id="btitle"
										value="<%=Board.getBtitle() %>">
								</div>
							</div>
						</div>
						<!-- 내용 -->
						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" rows="10" name="bctx" 
								id="bctx"><%=Board.getBctx() %></textarea>
						</div>

						<!-- 08-07 이미지 첨부 // -->
						<div class="form-group">
							<c:choose>
								<c:when test="${imgpath eq null }">
								<img src="/img/profile_image.jpg"
								 width="200" height="200"
								 class="img-upfile" id="avatar_image"
								 >
								 <input type="file" path="mpfimg_org" class="btn custom-file-input" name="bimg_org" id="bimg" accept=".bmp, .gif, .jpg, .png" onclick="ResizeImage();" onchange="getThumbnailPrivew(this, 'avatar_image');">
								</c:when>
								
								<c:otherwise>
								<img src="/BoardPic/${imgpath}"
								 width="200" height="200"
								 class="img-upfile" id="avatar_image"
								 >
								 <input type="file" path="mpfimg_org" class="btn custom-file-input" name="bimg_org" id="bimg" accept=".bmp, .gif, .jpg, .png" onclick="ResizeImage();" onchange="getThumbnailPrivew(this, 'avatar_image');">
								</c:otherwise>
								
							</c:choose>
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
			<script>
		$(document).ready(function() {
			$("#gnb1").load("gnb.jsp");
			$("#footer").load("footer.jsp");
		});
	</script>
</body>
</html>