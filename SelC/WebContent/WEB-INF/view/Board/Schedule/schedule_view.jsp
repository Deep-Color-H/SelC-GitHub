<%@page import="java.util.ArrayList"%>
<%@page import="SelCVO.ScheduleVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<!-- BOOTSTRAP -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js">
<style>
	.time {
		background-color: #0668a1;
		color:white;
		border-radius: 5px;
		vertical-align: bottom;
	}
	.class {
		color:white;
		border-radius: 5px;
		background-color: #1c8eb8;
	}
</style>
<body>
<% 
   ArrayList<ScheduleVO> schedule = (ArrayList<ScheduleVO>)request.getAttribute("Schedule"); 
   ScheduleVO First = schedule.get(0);
   String p_start = First.getSchedule_start();
   int sHour = Integer.parseInt(p_start.split("[:]")[0]);
   int sMin = Integer.parseInt(p_start.split("[:]")[1]);
   String p_end =First.getSchedule_end();
   int eHour = Integer.parseInt(p_end.split("[:]")[0]);
   int eMin = Integer.parseInt(p_end.split("[:]")[1]);
%>
<table width="800px" style="font-family:고도 B; margin:auto; background-color:#daeaf0; text-align:center; vertical-align: middle">
<tr style="height: 50px;">
	<%
		for(int i = sHour; i<=eHour; i++) {
	%>
	<td>
	<div class="time" style="height: 50px">
	<% if(i < 10) { %>
	0<%=i%>:00
	<%} else { %> 
	<%=i%>:00
	<%} %>
	</div>
	</td>
	<% } %>
<tr>
<tr class="text-center" style="height: 150px;">
	<%
		for(int i = sHour; i<=eHour; i++) {
	%>
	<td style="position:relative">
	<% if(i==sHour) { %>
	<div class="time">
	스<br>
	케<br>
	쥴<br>
	시<br>
	작<br>
	</div>
	<% } else if(i==eHour) {%>
	<div class="time">
	스<br>
	케<br>
	쥴<br>
	종<br>
	료<br>
	</div>
	<%} else {%>
	<div id="<%=i%>">
	</div>
	<% } %>
	</td>
	<% } %>
	<%
		for(ScheduleVO one : schedule) {
			int tot_gap = eHour-sHour;
			int clstart = Integer.parseInt(one.getClstart().split("[:]")[0]);
			int clend = Integer.parseInt(one.getClend().split("[:]")[0]);
			int gap = clend-clstart;
			double percent = ((double)gap)/tot_gap;
			String html = "<div style='width:"+gap*100+"%; position:absolute; background-color:#0668a1; border-radius: 5px; color:white; height:130px; top:10px; left:10px; padding: 10px'>";
			html += "<div class='class' style='font-size:"+percent*250+"%; color:white;'>"+one.getClname()+"</div>";
			html += "<span class='help-block'></span>";
			html += "<div class='content' style='font-size:"+percent*230+"%;'>";
			html += "학원 : "+one.getAname()+"<br>";
			html += "학원위치 : "+one.getAloc()+"<br>";
			html += "내용설명 : "+one.getClstart()+"~"+one.getClend()+"<br>";
			html += "</div></div>";
			%>
			<script>
				$("#<%=clstart%>").html("<%=html%>");
			</script>
			<%
		}
	%>

</table>
</body>
</html>