<%@page import="SelCVO.ScheduleVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Create Yourself, SelC : 스케쥴링</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<!-- BOOTSTRAP -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js">
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<!-- 지도 API -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=jmCEmLTgevYoxVl4hCGK&submodules=geocoder"></script>
<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- dialog 띄우는 jqeury UI, 기능-->
<!-- bar -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- time picker -->
<script type="text/javascript" src="dist/wickedpicker.min.js"></script>
<script type="text/javascript" src="js/wickedpicker.js"></script>
<link rel="stylesheet" href="dist/wickedpicker.min.css">
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>
<style>
	.schedule-btn { 
		width : 100px; 
		height : 300px;
		position : absolute; 
		right : -22px; 
		top : 120px; 
		z-index : 1; 
		background-image : url("img/Banner.png"); 
		background-size : 50%; 
		background-repeat : no-repeat; 
		background-position : center; 
		cursor : pointer; 
	}

	.schedule-close { 
 		width : 50px;
 		height : 50px;
 		position : absolute;
 		right : 0px;
 		top : 0px;
 		z-index : 2;
 		background-image : url("http://s1.daumcdn.net/cfs.tistory/custom/blog/204/2048858/skin/images/close.png"); 
 		background-size : 50%; 
 		background-repeat : no-repeat; 
 		background-position : center; 
 		cursor : pointer; 
 	}

 	#schedule { 
 		width : 500px; 
 		height : 100%; 
 		position : fixed;
 		top : 0px; 
 		right : -500px; 
 		z-index : 2147483647; 
 		border : 1px solid #c9c9c9; 
 		background-color : white; 
 		text-align : center; 
 		transition: All 0.2s ease; 
 		  -webkit-transition: All 0.2s ease; 
/*  		-moz-transition: All 0.2s ease;  */
/*  		-o-transition: All 0.2s ease;  */
	}

	#schedule.open {
 	  	right : 0px;
	}
	
    .hider {
      display: none;
    }

	#dist-slider {
		background : #7cc9d9;
	}

	#cost-slider {
		background : #7cc9d9;
	}

	#dist-handle {
		font-family:고도 B;
	    width: 2em;
	    height: 2em;
	    top: 50%;
	    margin-top: -1em;
 	    text-align: center;
	    line-height: 1.6em;
  }

/* 	#dist-handle2 { */
/* 	   font-family:고도 B; */
/* 	   width: 3em; */
/*   	   height: 1.6em; */
/*  	   top: 50%; */
/*  	   margin-top: -.8em; */
/*  	   text-align: center; */
/*  	   line-height: 1.6em; */
/*   } */
</style>
<script>
	var stitle="";
	
	function scheduleOpen(){ 
		$("#schedule").addClass("open"); 
	}; 

	function scheduleClose() { 
		$("#schedule").removeClass("open");
	};

	function updateTitle() {
		stitle = document.getElementById("stitle").value;
		document.getElementById("title-btn").value = "<   " + stitle + "   >";
		$("#schedule-title").slideToggle("slow");
		$("#schedule-title-insert").slideToggle("slow");
		document.getElementById("stitle22").value = stitle;
	};
	
jQuery(function($) {
	 $('#setLocation').click(function() {
		var sendData=$("#location").val();
		$.ajax({
			/* type:"POST", */
			type:"GET",
			url:"setLocation.do",
			data: { 'location' : sendData },
			dataType:'html',
			error:function() {
				alert("통신실패");
			},
			success:function(data) {
				$('#map1').html(data);
			}
		});
	})
	
	 $('#searchSchedule').click(function() {

		var location=$("#location").val();
		if($('#location').val()==null||$('#location').val()=="") {
			alertify.error("자기 위치를 설정해주시기 바랍니다.")	
		}
		
		var cat = "";
		if($("#cat option:selected").val()!=null)
			var cat = $("#cat option:selected").val();
		
		var cl ="";
		if($("#cl option:selected").val()!=null)
			var cl = $("#cl option:selected").val();
		
		var dist ="";
		if($("#disttext").val()!=null)
			var dist = $("#dist-slider").slider("value");
		
		var cost="";
		if($("#costtext").val()!=null)
			var cost = $("#cost-slider").slider("value");
		
		var stime="";
		if($("#stime").val()!=null)
			var stime = $("#stime").val();
		
		var etime="";
		if($("#etime").val()!=null)
			var etime = $("#etime").val();
		$.ajax({
			type:"POST",
			url:"srchSchedule.do",
			data: { 
				'location' : location,
				'cat' : cat,
				'cl' : cl,
				'dist' : dist,
				'cost' : cost,
				'stime' : stime,
				'etime' : etime
			},
			dataType:'html',
			error:function() {
				alert("통신실패");
			},
			success:function(data) {
				$('#map1').html(data);
			}
		});
	})
});

jQuery(function($) {
	var dialog, form,
	
	dialog = $("#addOption-form").dialog({
		autoOpen : false,
		height : 400,
		width : 400,
		modal : true,
		buttons : {
			"취소하기" : function() {
				
				dialog.dialog("close");
			}
		},
		close : function() {
		}
	});

// 	$("#cat").button().on("click", function() {
// 		var statement="<br/>";
// 		statement+="<label for=\"cat\" class=\"label label-primary\"> 학원 종류 선택  </label><br/>";
// 		statement+="<input type=\"text\" name=\"cat\" id=\"cat\" style=\"width:250px\"/><br/> ";
// 		$("#srchOption").append(statement);
// 		dialog.dialog("close");
// 	});
	$("#cl").button().on("click", function() {
		$('#cl').button().slideToggle("slow");
		var statement="<br/>";
		statement+="<label for=\"cl\" class=\"label label-primary\"> 수업 종류 선택  </label><br/>";
		statement+="<select class='form-control panel-info' name='cl' id='cl' style='width:250px'>";
		if($("#cat option:selected").val()=='ACAT_LANG') {
			statement+="<option value='CLCAT0'>영어</option>";
			statement+="<option value='CLCAT1'>영어(TOEIC)</option>";
			statement+="<option value='CLCAT2'>영어(TEPS)</option>";
			statement+="<option value='CLCAT3'>영어(TOEFL)</option>";
			statement+="<option value='CLCAT4'>영어(회화)</option>";
			statement+="<option value='CLCAT5'>중국어</option>";
			statement+="<option value='CLCAT6'>중국어(HSK)</option>";
			statement+="<option value='CLCAT7'>중국어(회화)</option>";
			statement+="<option value='CLCAT8'>일본어</option>";
			statement+="<option value='CLCAT9'>일본어(JLPT)</option>";
			statement+="<option value='CLCAT10'>일본어(회화)</option>";
			statement+="<option value='CLCAT11'>일본어(사교)</option>";
		} else if($("#cat option:selected").val()=='ACAT_COM') {
			statement+="<option value='CLCAT12'>JAVA</option>";
			statement+="<option value='CLCAT13'>C</option>";
			statement+="<option value='CLCAT14'>ORACLE</option>";
			statement+="<option value='CLCAT15'>JSP</option>";
		} else if($("#cat option:selected").val()=='ACAT_SPORTS') {
			statement+="<option value='CLCAT18'>필라테스</option>";
			statement+="<option value='CLCAT19'>줌바</option>";
			statement+="<option value='CLCAT20'>차차차</option>";
			statement+="<option value='CLCAT21'>룸바</option>";
		} else if($("#cat option:selected").val()=='ACAT_MUSIC') {
			statement+="<option value='CLCAT22'>피아노</option>";
			statement+="<option value='CLCAT23'>바이올린</option>";
		} else if($("#cat option:selected").val()=='ACAT_ART') {
			statement+="<option value='CLCAT24'>포토샵 일러스트</option>";
			statement+="<option value='CLCAT25'>켈라그라피</option>";
			statement+="<option value='CLCAT26'>취미미술</option>";
		} else if($("#cat option:selected").val()=='ACAT_COOK') {
			statement+="<option value='CLCAT27'>베이커리</option>";
		}
		statement+="</select>"
// 		statement+="<input type=\"text\" name=\"cl\" id=\"cl\" style=\"width:250px\"/><br/>";
		$("#srchOption").append(statement);
		dialog.dialog("close");
	});

	$("#dist").button().on("click", function() {
		$('#dist').button().slideToggle("slow");
		var statement="<br/>";
		statement+="<label for=\"dist\" class=\"label label-primary\"> 거리 선택 </label><br/>";
		statement+="<div id = 'dist-slider' name='dist' style='height:25px; width:350px'>";
		statement+="<div id ='dist-handle' class='ui-slider-handle'></div>";
		statement+="<input class='panel panel-primary' style='font-family:고도 M; margin-left:130px; margin-top:27px; height:20px; width:220px' placeholder='금액을 m 단위로 직접 입력하세요' type='text' id='distinput' name='distinput'/>";
		statement+="</div>";
		statement+="<div id ='amount' style='padding:5px; font-family:고도 B'>거리 :</div>";
		statement+="<input type='hidden' id='disttext' name='disttext'/>";
		$("#srchOption").append(statement);
		var handle = $('#dist-handle');
		$("#dist-slider").slider({
			range: "max",
		    max: 30000,
		    value: 1000,
		    create: function() {
		    	if($(this).slider("value") >= 1000) {
			        $('#amount').text(" 거리 : "+$( this ).slider( "value" )/1000+"km" );
		    	} else {
			        $('#amount').text(" 거리 : "+$( this ).slider( "value" )+"m" );	    		
		    	}
			   	$('#disttext').val($(this).slider("value"));
		      },
		    slide: function( event, ui ) {
		    	if($(this).slider("value") >= 1000) {
			        $('#amount').text(" 거리 : "+$( this ).slider( "value" )/1000+"km" );
		    	} else {
			        $('#amount').text(" 거리 : "+$( this ).slider( "value" )+"m" );	    		
		    	}
			    $('#disttext').val( $(this).slider("value"));
		      }
		});
		$('#distinput').change(function() {
			$('#dist-slider').slider({
				value: $('#distinput').val()
			});
			if($('#distinput').val() >=1000) {
				$('#amount').text(" 거리 : "+$( '#distinput' ).val()/1000+"km" );
			} else {
				$('#amount').text(" 거리 : "+$( '#distinput' ).val()+"m" );				
			}
			$('#disttext').val($('#distinput').val());
		});
		dialog.dialog("close");
	});

	
	$("#cost").button().on("click", function() {
		$('#cost').button().slideToggle("slow");
		var statement="<br/>";
		statement+="<label for=\"cost\" class=\"label label-primary\"> 금액 한도를 설정해주셔요  </label><br/>";
		statement+="<div id ='cost-slider' name='cost' style='height:25px; width:350px'>";
		statement+="<div id ='dist-handle' class='ui-slider-handle'></div>";
		statement+="<input class='panel panel-primary' style='font-family:고도 M; margin-left:130px; margin-top:27px; height:20px; width:220px' placeholder='금액을 원 단위로 직접 입력하세요' type='text' id='costinput' name='costinput'/>";
		statement+="</div>";
		statement+="<div id ='cost-amount' style='padding:5px; font-family:고도 B'></div>";
		statement+="<input type='hidden' id='costtext' name='costtext'/>";
		$("#srchOption").append(statement);
		var handle = $('#dist-handle');
		$("#cost-slider").slider({
			range: "max",
		    max: 3000000,
		    min: 10000,
		    value: 1000000,
		    create: function() {
			     $('#cost-amount').text(" 금액 : "+$( this ).slider( "value" )/10000+"만원" );
				 $('#costtext').val($(this).slider("value"));
				 
		      },
		    slide: function( event, ui ) {
			     $('#cost-amount').text(" 금액 : "+$( this ).slider( "value" )/10000+"만원" );
				 $('#costtext').val($(this).slider("value"));
		      }
		});
		$('#costinput').change(function() {
			$('#cost-slider').slider({
				value: $('#costinput').val()
			});
			$('#cost-amount').text(" 금액 : "+$( '#costinput' ).val()/10000+"만원" );
			$('#costtext').val($('#costinput').val());
		});
		dialog.dialog("close");
	});
	$("#stime").button().on("click", function() {
		$('#stime').button().slideToggle("slow");
		var statement="<br/>";
		statement+="<label for=\"stime\" class=\"label label-primary\"> 자기개발의 시작 시간은 언제였으면 하시나요?  </label><br/>";
		statement+="<input type='text' name='stime' id='stime' style='width:250px;' class='timepicker1 panel panel-info text-center'/><br/>";
		$("#srchOption").append(statement);
		$('.timepicker1').wickedpicker(options);
		dialog.dialog("close");
	});

	$("#etime").button().on("click", function() {
		$('#etime').button().slideToggle("slow");
		var statement="<br/>";
		statement+="<label for=\"etime\" class=\"label label-primary\"> 스케쥴이 끝나는 시간을 정해주세요.  </label><br/>";
		statement+="<input type='text' name='etime' id='etime' style='width:250px;' class='timepicker2 panel panel-info text-center'/><br/>";
		$("#srchOption").append(statement);
		$('.timepicker2').wickedpicker(options);
		dialog.dialog("close");
	});
	
	$("#addOption").button().on("click", function() {
		dialog.dialog("open");
	});
	
	$('#initSearchCondition').button().on("click", function() {
		var statement="";
		statement+="<label for='location' class='label label-primary'>시작 위치를 정하세요.</label><br/>";
		statement+="<input class='panel panel-info' type='text' name='location' id='location' readonly='readonly' style='width:250px; height:30px'/>";
		statement+="<input type='button' class='btn btn-primary' value='시작 위치 검색' onclick='goPopup()'>"; 
		statement+="<input type='button' class='btn btn-primary' value='찾기' id='setLocation'>"; 
		statement+="<br/><br/>";
		statement+="<label for='cat' class='label label-primary'> 학원 종류 선택  </label><br/>";
		statement+="<select class='form-control panel-info' name='cat' id='cat' style='width:250px'>";
		statement+="	<option value='ACAT_LANG'>언어</option>"; 
		statement+="	<option value='ACAT_COM'>컴퓨터</option>"; 
		statement+="	<option value='ACAT_SPORTS'>스포츠</option>"; 
		statement+="	<option value='ACAT_MUSIC'>음악</option>"; 
		statement+="	<option value='ACAT_ART'>미술</option>"; 
		statement+="	<option value='ACAT_COOK'>요리</option>"; 
		statement+="</select>"; 
		$("#srchOption").html(statement);
		$('#cl').button().slideDown("slow");
		$('#dist').button().slideDown("slow");
		$('#cost').button().slideDown("slow");
		$('#stime').button().slideDown("slow");
		$('#etime').button().slideDown("slow");
	});
	
	$('#gotoScheduleBoard').button().on("click", function() {
		document.location.href='toBoardList_SCHEDULE.do?page_number=1';
	});
	
});

	function init() {
		document.location.href="initSchedule.do";
	}
	
	function chk_login() {
		<% if(session.getAttribute("Idcode")==null) {%>
		alertify.error("로그인이 필요한 기능입니다. 로그인 해주십시오.");
		return false;
		<%}%>
		alertify.success("저장이 완료되었습니다. 스케쥴 게시판에서 스케쥴을 공유해보는 건 어떨까요?");
		return true;
	}
	
// 	function costinputgo() {
// 		document.getElementById("cost-slider").value = document.getElementById("costinput").value;
// 		alert();
// 	}
</script>
<!-- 주소 팝업창 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script language="javascript">
	function goPopup() {
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
		var pop = window.open("jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}

	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
			roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
			detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
			buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo, entX, entY) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.getElementById("location").value=roadAddrPart1;
	}
</script>
</head>
<body>
<!-- 조건을 추가하는 dialog -->
	<div id="addOption-form" title="      검색 정보를 추가합니다." class="container">
		<fieldset>
				<br/>
				<div class="btn-group"> 
					<button id="srchOption1" type="button" class="btn btn-default btn-primary dropdown-toggle" 
					  										data-toggle="dropdown" aria-expanded="true">
					검색 조건을 선택해주세요.
					<span class="caret"></span>
					</button>
					<ul class="dropdown-menu text-center" role="menu">
        				<li><button id="cl" class="btn btn-primary" style="width:100%">수업 종류 선택 (Class)</button></li>
        				<li><button id="dist" class="btn btn-primary" style="width:100%">거  리</button></li>
        				<li><button id="cost" class="btn btn-primary" style="width:100%">금  액</button></li>
        				<li><button id="stime" class="btn btn-primary" style="width:100%">시작시간</button></li>
        				<li><button id="etime" class="btn btn-primary" style="width:100%">종료시간</button></li>
      				</ul>
				</div>
		</fieldset>
	</div>
<!-- GNB -->
<div id="gnb1"></div>

<div id="schedule" style="font-family:고도 B; padding:30px 10px 10px 30px; overflow:auto;">
<div class="schedule-close" onclick="scheduleClose()"></div>
<%
	ArrayList<ScheduleVO> schedulelist = (ArrayList<ScheduleVO>) session.getAttribute("Schedule_List");
	if(schedulelist!=null) {
		ScheduleVO first_schedule = schedulelist.get(0);
		String Hour_start = first_schedule.getSchedule_start().split("[:]")[0];
		String Hour_end = first_schedule.getSchedule_end().split("[:]")[0];
%>
	<c:set var="scheduleList" value="<%=schedulelist%>"/>
	<c:set var="firstList" value="<%=first_schedule%>"/>
    <c:set var="startTime" value="<%=Hour_start%>" />
    <c:set var="endTime" value="<%=Hour_end%>" />

	<div id="titleSet" style="font-size:150%">
		Self-Creator<br>
		${firstList.mnick}님만의 Schedule입니다.<br>
		<div id="schedule-title">
			<input type="button" class="btn btn-primary btn-lg" id="title-btn" onclick="updateTitle()"
					value="<   스케쥴 제목     >">
		</div>
		<div id="schedule-title-insert" style="display:none;">
			<input type="text" id="stitle" value="스케쥴 제목" onchange="updateTitle()"/>
		</div>
	</div>
	<div id="time" style="position:absolute; top:20%; right:8%; line-height: 175%; font-size:130%; font-family: 고도 B; color:#0668a1; z-index:2;">
		<table>
		<c:forEach begin="${startTime}" step="1" end="${endTime}" var="h">
				<tr>
					<td>
						<c:if test="${h lt 24}">
							<fmt:parseDate value="${h}:00 " pattern="HH:mm" var="sample"/>
							<fmt:formatDate value="${sample}" pattern="HH:mm"/>
						</c:if>
						<c:if test="${h ge 24}">
							${h}:00
						</c:if>
					</td>
					<td id="${h}:00">
						<hr width="350px" style="background-color:#7cc9d9; height:1px; border:none" align="right">
					</td>
				<tr><td></td>
					<td id="${h}:30">
						<hr width="350px" style="background-color:#7cc9d9; height:1px; border:none" align="right">
					</td>
				<tr>
		</c:forEach>
		<%
		
			String start = first_schedule.getSchedule_start();
			String location = first_schedule.getLocation();
			String H = start.split("[:]")[0];
			String M = start.split("[:]")[1];
			int Mi = Integer.parseInt(M);
			if(Mi>=0 && Mi<30) {
				%>
					<script>
						var H = <%=H%>;
						document.getElementById(H+":00").innerHTML= "--<button class='btn btn-primary'>스케쥴 시작 :" +
																	"<%=location%>" +
																	"</button>--";
					</script>
				<%	
			} else if(Mi>=30 && Mi<=60) {
				%>
					<script>
						var H = <%=H%>;
						document.getElementById(H+":30").innerHTML= "--<button class='btn btn-primary'>스케쥴 시작 :" +
																	"<%=location%>" +
																	"</button>--";
					</script>
				<%
			}
			String end = first_schedule.getSchedule_end();
			String H2 = end.split("[:]")[0];
			String M2 = end.split("[:]")[1];
			int Mi2 = Integer.parseInt(M2);
			if(Mi2>=0 && Mi2<30) {
				%>
					<script>
						var H2 = <%=H2%>;
						document.getElementById(H2+":00").innerHTML="-------------" +
																	"<button class='btn btn-primary'>스케쥴 종료</button>" +
																	"-------------";
					</script>
				<%	
			} else if(Mi2>=30 && Mi2<=60) {
				%>
					<script>
						var H2 = <%=H2%>;
						document.getElementById(H2+":30").innerHTML="-------------" +
																	"<button class='btn btn-primary'>스케쥴 종료</button>" +
																	"-------------";
					</script>
				<%
			}
		for(ScheduleVO one : schedulelist) {
			String clstart = one.getClstart();
			String clend = one.getClend();
			String clname = one.getClname();
			String aloc = one.getAloc();
			String aname = one.getAname();
			
			int Shour = Integer.parseInt(clstart.split("[:]")[0]);
			int Ehour = Integer.parseInt(clend.split("[:]")[0]);
			if(Ehour < Shour) {
				Ehour+=24;
			}
			int Gaphour = Ehour-Shour;
			%>
				<script>
					var classhtml = "<div class='panel' style='height: <%=Gaphour*80%>px; width: 300px; padding: 10px; background-color: #daeaf0; position:absolute; left:20%;'>";
					classhtml += "<div class='panel' style='width=100%; padding 5px; background-color: #0668a1; color:white; font-size:110%; margin-bottom:<%=15*Gaphour-20%>px;'><%=clname%></div>";
					classhtml += "<div class='panel' style='width=100%; padding 5px; background-color: #1c8eb8; color:white; font-size:<%=10*Gaphour+55%>%; line-height:<%=40*Gaphour+60%>%'>";
					classhtml += "학원명 : <%=aname%><br/>";
					classhtml += "학원위치 : <%if(Gaphour>=5) {%><br><%}%><%=aloc%><br/>";
					classhtml += "시 간 : <%=clstart%>~<%=clend%>";
					classhtml += "</div>";
					classhtml += "</div>";
					document.getElementById("<%=Shour%>:00").innerHTML=classhtml;
				</script>
			<%
		}
		%>
		</table>
		<form action="finSchedule.do" method="post" onsubmit="return chk_login()">
			<input type="hidden" id="stitle22" name="stitle22" value="기본 스케쥴 제목"/>		
			<input type="submit" class="btn btn-primary" value='스케쥴 저장하기'/>
			<input type="button" class="btn btn-danger" value='스케츌 초기화하기' onclick="init()"/>
		</form>
	</div>
<% } else { %>
	<div id="titleSet" style="font-size:150%;">
	Self-Creator<br>
	<p style="color:#0668a1;">Scheduling</p><br>
	<div class="panel panel-default text-left" style="padding: 8px; width:100%; height:100%; font-size:80%">
	<br><br>
	&nbsp; &nbsp; Self-Creator, SelC는 여러분의 자기개발을 위한 스케쥴 기능을 제공합니다.<br><br>
	&nbsp; &nbsp; 원하는 위치와 원하는 조건을 입력해서 검색해보세요. 본인에게 맞는 수업을 추천해드립니다.<br><br><br>
	<p class="text-center">- 가능한 조건 -</p><br>
	&nbsp; &nbsp; ▷ 학원의 종류<br>
	&nbsp; &nbsp; ▶ 수업의 종류<br>
	&nbsp; &nbsp; ▷ 거리 : m 단위로 입력해주세요<br>
	&nbsp; &nbsp; ▶ 금액 : 만원 단위로 입력해주세요<br>
	&nbsp; &nbsp; ▷ 시작시간 : 스케쥴이 시작할 시간을 정해주세요<br>
	&nbsp; &nbsp; ▶ 종료시간 : 스케쥴이 종료될 시간을 정해주세요<br>
	<br><br>
	</div>
	</div>
<% } %>
</div> 
<div class="schedule-btn" onclick="scheduleOpen()">
</div>


<!-- 지도 -->
<div id="map1" class="container" style="z-index:0;"></div>
<br/>
<!-- DIALOG FORM에서 추가한 조건이 여기로 추가된다. -->
<div id ="srchRes" name="srchRes">
</div>
<form id="srchOptions" name="srchOptions" modelAttribute="SelCVO.srchOptionVO">
	<div id="srchOption" class="container">
		<label for="location" class="label label-primary">시작 위치를 정하세요.</label><br/>
		<input class="panel panel-info" type="text" name="location" id="location" readonly="readonly" style="width:250px; height:30px"/>
		<input type="button" class="btn btn-primary" value="시작 위치 검색" onclick="goPopup()"> 
		<input type="button" class="btn btn-primary" value="찾기" id="setLocation"> 
		<br/><br/>
		<label for="cat" class="label label-primary"> 학원 종류 선택  </label><br/>
		<select class="form-control panel-info" name="cat" id="cat" style="width:250px">
			<option value="ACAT_LANG">언어</option> 
			<option value="ACAT_COM">컴퓨터</option> 
			<option value="ACAT_SPORTS">스포츠</option> 
			<option value="ACAT_MUSIC">음악</option> 
			<option value="ACAT_ART">미술</option> 
			<option value="ACAT_COOK">요리</option> 
		</select> 
	</div>
<br>
</form>

	<div class="container">
		<button class="btn btn-primary" id="addOption">조건추가하기</button> 
		<button class="btn btn-primary" id="searchSchedule">조건에 맞는 스케쥴 찾기</button>
		<button class="btn btn-danger" id="initSearchCondition">조건 삭제</button>
	</div>
	<button class="btn btn-primary" id="gotoScheduleBoard"
			style="position:absolute; bottom:-100px; right:210px; width:250px; height:200px; font-family:고도 B;">
	스케쥴 자랑하러 가기<br>&<br>다른 SelCer의 스케쥴보러가기</button>
	<br><br><br><br><br><br><br>
	<div id="footer"></div>	
<script>
	var options = { 
		now: '12:30',//hh:mm 24 hour format only, defaults to current time 
		twentyFour: true, //Display 24 hour format, defaults to false 
		upArrow: 'wickedpicker__controls__control-up', //The up arrow class selector to use, for custom CSS 
		downArrow: 'wickedpicker__controls__control-down', //The down arrow class selector to use, for custom CSS 
		close: 'wickedpicker__close', //The close class selector to use, for custom CSS 
		hoverState: 'hover-state', //The hover state class to use, for custom CSS 
		title: 'Timepicker', //The Wickedpicker's title, 
		showSeconds: false, //Whether or not to show seconds, 
		minutesInterval: 30, //Change interval for minutes, defaults to 1 
		beforeShow: null, //A function to be called before the Wickedpicker is shown 
		show: null, //A function to be called when the Wickedpicker is shown 
		clearable: false //Make the picker's input clearable (has clickable "x")  
	};
	
	$(document).ready(function() {
		$("#gnb1").load("gnb.jsp");
		$("#map1").load("map2.jsp");
		$("#footer").load("footer.jsp");
		<%
		if(schedulelist!=null) { %>
			scheduleOpen();
		<%}%>
	});
</script>
</body>
</html>