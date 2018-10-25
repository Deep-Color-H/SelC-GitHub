<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Create YourSelf, SelC : 질문게시판 글쓰기</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>

<!-- 부트스트랩링크 -->

<!--[if lt IE 9]> 
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script> 
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script> 
<![endif]-->
<script>
function post() {
	if($('#btitle').val()==null || $('#btitle').val()=="" ){
			alertify.error("제목을 입력해주세요.")
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
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<div id="gnb1"></div>


	<!-- jQuery. 부트스트랩의 자바스크립트 플러그인이 필요. -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	
		<div class="panel panel-default" style="font-family: 고도 B;">
		<div class="panel-heading" width="400px">
			<h2 class="container"> 질문 하기</h2>
		</div>


		<div class="panel-body">
			<!-- 패널 사용-->
			<div class="container">
				<form action="<%=request.getContextPath()%>/QAinsert.do" method="POST"
						modelAttribute = "QABoardVO">
					<form role="form">
						<input type="hidden" value="BOARD_DIARY" name="bcatid" id="bcatid">
						<div class="row">
							<div class="col-md-6">
								<!-- 컨테이너안에 그리드시스템 사용 -->
								<!-- 제목  -->
								<div class="form-group">
									<label for="subject">제목 </label> <input type="text"
										class="form-control" name="btitle" id="btitle"
										placeholder="Enter Question Title">
								</div>
							</div>
						</div>
						<!-- 내용 -->
						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" rows="10" name="bctx"id="bctx"></textarea>
						</div>
						<!-- 하단 버튼 -->
						<div class="center-block" style='width: 200px'>
							<input type="submit" class="btn btn-primary" value="등록" onclick="return post()"> 
							<input type="reset" class="btn btn-primary" value="다시쓰기"> 
							<input type="button" class="btn btn-primary" value="뒤로" onclick="history.back(1)"><!-- 현재페이지 1단계 뒤로감 -->
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
			$("#gnb1").load("gnb.jsp");
			$("#footer").load("footer.jsp");
		});
	</script>
</body>
</html>