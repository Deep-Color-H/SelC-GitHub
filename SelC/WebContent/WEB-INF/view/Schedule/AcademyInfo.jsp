<%@page import="SelCVO.ClcmtVO"%>
<%@page import="SelCVO.AcatinfoVO"%>
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
<title>Create Yourself,SelC : 학원 정보</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- 별점 -->
<script type="text/javascript" src="js/star.js"></script>

</head>
<style>
body {
	text-align: center;
	font-family: 고도 B;
}
 .Bar {
/* 	width:300px; */
	height:30px;
	position:absolute;
	z-index:1;
	padding-top:5px;
	font-size:115%;
	padding-left:25px;
	padding-right:25px;
	
}
 .star-input>.input,
 .star-input>.input>label:hover,
 .star-input>.input>input:focus+label,
 .star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('img/grade_img.png')no-repeat;}
 .star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;}
 .star-input>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}
 .star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
 star-input>.input.focus{outline:1px dotted #ddd;}
 .star-input>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
 .star-input>.input>label:hover,
 .star-input>.input>input:focus+label,
 .star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
 .star-input>.input>label:hover~label{background-image: none;}
 .star-input>.input>label[for="p11"]{width:30px;z-index:5;}
 .star-input>.input>label[for="p21"]{width:60px;z-index:4;}
 .star-input>.input>label[for="p31"]{width:90px;z-index:3;}
 .star-input>.input>label[for="p41"]{width:120px;z-index:2;}
 .star-input>.input>label[for="p51"]{width:150px;z-index:1;}
 .star-input>.input>label[for="p12"]{width:30px;z-index:5;}
 .star-input>.input>label[for="p22"]{width:60px;z-index:4;}
 .star-input>.input>label[for="p32"]{width:90px;z-index:3;}
 .star-input>.input>label[for="p42"]{width:120px;z-index:2;}
 .star-input>.input>label[for="p52"]{width:150px;z-index:1;}
 .star-input>.input>label[for="p13"]{width:30px;z-index:5;}
 .star-input>.input>label[for="p23"]{width:60px;z-index:4;}
 .star-input>.input>label[for="p33"]{width:90px;z-index:3;}
 .star-input>.input>label[for="p43"]{width:120px;z-index:2;}
 .star-input>.input>label[for="p53"]{width:150px;z-index:1;}
 .star-input>.input>label[for="p14"]{width:30px;z-index:5;}
 .star-input>.input>label[for="p24"]{width:60px;z-index:4;}
 .star-input>.input>label[for="p34"]{width:90px;z-index:3;}
 .star-input>.input>label[for="p44"]{width:120px;z-index:2;}
 .star-input>.input>label[for="p54"]{width:150px;z-index:1;}
 .star-input>.input>label[for="p15"]{width:30px;z-index:5;}
 .star-input>.input>label[for="p25"]{width:60px;z-index:4;}
 .star-input>.input>label[for="p35"]{width:90px;z-index:3;}
 .star-input>.input>label[for="p45"]{width:120px;z-index:2;}
 .star-input>.input>label[for="p55"]{width:150px;z-index:1;}
</style>
<body>
<% 
	HashMap<String, Object> res_map = (HashMap<String, Object>)request.getAttribute("res_map");
	
	ArrayList<AcatinfoVO> acat_info = (ArrayList<AcatinfoVO>)res_map.get("acatinfo");
	AcatinfoVO academy = acat_info.get(0);
	
	HashMap<Integer, ArrayList<ClcmtVO>> clcmt_map = (HashMap<Integer, ArrayList<ClcmtVO>>)res_map.get("clcmt_list");
	
	double tot_avg_score=0;
	double avg_score=0;
	int tot_num = 0;
	int num = 0;
	HashMap<Integer, Integer> score_map = new HashMap<>();
	for(AcatinfoVO one : acat_info) {
		if(clcmt_map.get(one.getClid())!=null) {
			for(ClcmtVO two : clcmt_map.get(one.getClid())) {
				tot_avg_score+=two.getClcscore();
				avg_score+=two.getClcscore();
				tot_num++;
				num++;
			}
			score_map.put(one.getClid(),(int)Math.round(avg_score/num*10));
			avg_score=0;
			num=0;
		}
	}
	tot_avg_score /= tot_num;
	double avg_star = Math.round(tot_avg_score*10);
	int avg_star_1 = (int)avg_star/10;
	int avg_star_2 = (int)avg_star%10;
%>
<script>
	var size = <%=acat_info.size()%>;
	function cltog() {
		var index = arguments[0];
		$('#class'+index).slideToggle("slow");
		for(var i=1; i<=size; i++) {
			if(i!=index) {
				$('#class'+i).slideUp("slow");
			}
		}
	};
	function checkCmt() {
		var mid = $('#mid').val();
		var clcctx = $('#clcctx'+arguments[0]).val();
		var star_input = $("input[name='star-input"+arguments[0]+"']:checked").val();
		var clid = $('#clid'+arguments[0]).val();
		if(mid==null||mid=='') {
			alert('로그인을 하고 이용해주시기 바랍니다.');
		} else if(clcctx==null||clcctx==''){
			alert('내용을 입력하여주시기 바랍니다.');
		} else {
			$('#star-input').val(star_input);	
			$('#clid').val(clid);	
			$('#clcctx').val(clcctx);
			$('#ins_cmt').submit();
		}
	}
</script>
<c:set var="acat_info" value='<%=acat_info%>'/>
<%	if(session.getAttribute("Idcode")!=null) { %>
		<c:set var="IdCode" value='<%=session.getAttribute("Idcode")%>'/>
<%  } else {  %>
	 	<c:set var="IdCode" value='' />
<%  }  %>
<div class="title"><h1><%=academy.getAname() %></h1></div>
<span class="help-block"></span>
<div class="panel panel-info text-center Bar" style="top:100px; right:55%; padding-right:70px;  font-size:110%">주소 : <%=academy.getAloc() %></div>
<div class="panel panel-info text-center Bar" style="top:150px; right:55%; padding-right:70px"><%=academy.getAcatname() %> 학원</div>
<div class="panel panel-info text-center Bar" style="top:200px; right:55%; padding-right:70px">학원조회수 : <%=academy.getAhits() %></div>
<div class="panel panel-info text-center Bar" style="top:100px; left:55%; padding-left:70px; font-size:100%">문의메일 : <%=academy.getMem()%></div>
<div class="panel panel-info text-center Bar" style="top:150px; left:55%; padding-left:70px">총 <%=acat_info.size()%>개 수업</div>
<div class="panel panel-info text-center Bar" style="top:200px; left:55%; padding-left:70px">평균 별점 : <%=avg_star_1%>.<%=avg_star_2 %> </div>
<img src="img/acatimg/acat_<%=academy.getAid()%>.png"  width="200" height="200" class="img-upfile img-circle"
	 style="z-index: 100000; border:2mm; border-color:black; position:relative;">
<span class="help-block"><br></span>
<div style="position:absolute; top:260px; left:33%; color:#0668a1; font-weight: bolder;"><h2>수업 목록</h2></div>
<div class="panel panel-info container text-left" style="width:800px; height:auto; padding:30px">
<% 
	int i = 0;
	for(AcatinfoVO cl : acat_info) {
		i++; %>

	<button id="show" class="btn btn-primary" style="width:100%; font-size:130%" onclick="cltog(<%=i%>)">
	<c:out value='<%=i%>'/>. <c:out value='<%=cl.getClname()%>'/></button>
	<div class="panel panel-primary" id="class<%=i%>" style="display:none">
		<div class="panel panel-heading text-center" style="font-size:120%">
			<% 
				if(score_map.get(cl.getClid())!=null) {
					int cl_avg_star = score_map.get(cl.getClid());
					int cl_avg_star_1 = (int)cl_avg_star/10;
					int cl_avg_star_2 = (int)cl_avg_star%10;
			%>
			해당 수업 별점 : <%=cl_avg_star_1%>.<%=cl_avg_star_2%>
			<% } else { %>
			아직 평가되지 않은 수업입니다.
			<% } %> 
		</div>
		<div class="panel panel-body">
			 <c:out value='<%=cl.getClinfo()%>'/>
		</div>
		<div class="panel panel-body">
			<span class="star-input">
				<span class="input">
    				<input type="radio" name="star-input<%=i%>" value="1" id="p1<%=i%>">
    				<label for="p1<%=i%>">1</label>
    				<input type="radio" name="star-input<%=i%>" value="2" id="p2<%=i%>">
    				<label for="p2<%=i%>">2</label>
    				<input type="radio" name="star-input<%=i%>" value="3" id="p3<%=i%>" checked="checked">
    				<label for="p3<%=i%>">3</label>
    				<input type="radio" name="star-input<%=i%>" value="4" id="p4<%=i%>">
    				<label for="p4<%=i%>">4</label>
    				<input type="radio" name="star-input<%=i%>" value="5" id="p5<%=i%>">
    				<label for="p5<%=i%>">5</label>
  				</span>
				<input type="hidden" name="clid<%=i%>" id="clid<%=i%>" value='<%=cl.getClid()%>'/>
<%-- 				<input type="hidden" name="mid" id="mid" value='${Idcode}'/> --%>
				<input type="text" class='panel panel-info' name="clcctx<%=i%>" id="clcctx<%=i%>" style="width:400px; height:40px; font-family:고도 B"/>
 	 			<input class='btn btn-primary' type='button' value='별점 달기' onclick="checkCmt(<%=i%>)"/>				
			</span>
		</form>
		</div>
		<% if(clcmt_map.get(cl.getClid())!=null) {%>
		<div class="panel panel-body">
		<table>
		<% for(ClcmtVO clcmt : (ArrayList<ClcmtVO>)clcmt_map.get(cl.getClid())) { %>
			<tr style="height:40px">
				<td style="width:70%;">
					<%=clcmt.getMnick()%> : <%=clcmt.getClcctx()%> 
				</td>
				<td style="width:15%; color: #0668a1;">
					<% for(int j=1; j<=clcmt.getClcscore(); j++) { %>
						★
					<% } %>
				</td>
				<% if((String)session.getAttribute("Idcode")!=null)  {%>
				<% if(clcmt.getMid()==Integer.parseInt((String)session.getAttribute("Idcode"))) { %>
				<td style="width:10%;">
					<button class="btn btn-danger" style="font-size:100%">댓삭</button>
				</td>
				<% } %>
				<% } %>
			</tr>		
		<% } %>
		</table>
		</div>
		<% } %>
	</div>
<% } %>
</div>
<form action="insertClcmt.do" method="get" id="ins_cmt">
	<input type="hidden" name="star-input" id="star-input" value=""/>
	<input type="hidden" name="clid" id="clid" value=''/>
	<input type="hidden" name="clcctx" id="clcctx" value=''/>
	<input type="hidden" name="aid" id="aid" value='<%=academy.getAid()%>'/>
	<input type="hidden" name="mid" id="mid" value='${Idcode}'/>
</form>
</body>
</html>
