<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<link href="/css/bootstrap-responsive.css" rel="stylesheet">
<body>
<% String Idcode = (String)session.getAttribute("Idcode"); %>
	<div>
		<center>
			<a class="navbar-brand" href="index.jsp">
			<img src="img/SelC.png" class="img-circle" alt="SelC" height="150px" width="150px" style="border-color: black; position:absolute; top:20px; left: 15px"></a>
		</center>
	</div>
	
	<table align="center" width="40%" style="align-content: center; top: 50px; right: 500px; position: absolute;">
		<tr align="center">
			<td><span class='text-nowrap'>
			<a href="toSchedule.do"><img src="img/gnb/sch.png"></a>
			</span></td>
			<td><span class='text-nowrap'>
			<a href="toBoardList_SCHEDULE.do?page_number=1"><img src="img/gnb/sch_share.png"></a>
			</span></td>
			<td><span class='text-nowrap'>
			<a href="toBoardList_DIARY.do?page_number=1"><img src="img/gnb/selcer.png"></a>
			</span></td>
			<td><span class='text-nowrap'>
			<a href="toBoardList_QA.do?page_number=1"><img src="img/gnb/Qna.png"></a>
			</span></td>
		
		</tr>
	</table>
	
	<div id="navbar" class="navbar-collapse collapse">
		<ul class="nav navbar-nav navbar-right">
		
			<c:if test="<%=Idcode==null%>">
			<li><a href="toSignin.do">회원가입</a></li>
			<li><a href="toLogin.do">로그인</a></li>
			</c:if>
			
			<c:if test="<%=Idcode!=null%>">
			<li><a href="toLogout.do">로그아웃</a></li>
			<li><a href="toUserModify.do?mid=<%=Idcode%>">회원정보조회</a></li>
			</c:if>
		</ul>
	</div>
	<br>
	<hr>
</body>
</script>
</html>