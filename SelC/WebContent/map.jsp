<%@page import="java.net.URLEncoder"%>
<%@page import="SelCVO.srchOptionVO"%>
<%@page import="SelCVO.SrchClVO"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>네이버 지도 API - 주소로 지도 표시하기</title>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=jmCEmLTgevYoxVl4hCGK&submodules=geocoder"></script>
	<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>
<script src="js/map_marker.js"></script>
	<script>
	
	// 검색 결과가 없을 시 Controller 단에서 message를 보낸다. 이를 출력한다.
	var message='<%=request.getAttribute("message")%>';
	if(message!="") {
		alertify.error(message);
	}
	
	// 지도를 표시한다. naver api v3를 이용했다.
    var map = new naver.maps.Map('map', {
    	zoom:9
    });
    
    // 자기 위치를 표시한다.
    var myaddress = '<%=request.getParameter("location").trim()%>';
    naver.maps.Service.geocode({address: myaddress}, function(status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
        }
        var result = response.result;
        selcaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
        map.setCenter(selcaddr); // 검색된 좌표로 지도 이동
        // 마커 표시
        var marker = new naver.maps.Marker({
          position: selcaddr,
          map: map,
          icon: {
              url: 'img/SelC_Marker.png',
              size: new naver.maps.Size(40, 40),
              origin: new naver.maps.Point(0, 0),
              anchor: new naver.maps.Point(11, 35)
          }
        });
        // 마커 클릭 이벤트 처리
        naver.maps.Event.addListener(marker, "click", function(e) {
           if (infowindow.getMap()) {
               infowindow.close();
           } else {
               infowindow.open(map, marker);
           }
        });
        // 마크 클릭시 인포윈도우 오픈
        var infowindow = new naver.maps.InfoWindow({
            content:  '<h4>자기개발자님의 위치입니다.<img src="img/SelC.png" style="width:40px; height:auto;"/></h4>'
        });
       });
      
      
      // 검색결과를 마커로 출력한다.
      
      // 검색결과를 위한 index를 정의
      var i = 1;
      // 비교알고리즘을 위한 srchOption들을 가져온다.
      var srchCat = document.getElementById("acatid").value;
      var srchCl = document.getElementById("clcatid").value;
      var srchDist = document.getElementById("sldist").value;
      var srchCost = document.getElementById("slcost").value;
      var srchStime = document.getElementById("slstart").value;
      var srchEtime = document.getElementById("slend").value;

      var alocs_org = [];
      var positions = {};
  	  var StringContent = {};
      var iconUrl = {};
      var animations = {};
	  var infowindows = {};
      
      
      // 마커를 찍는다.
	  function gotoChk() {
    	document.getElementById("clid").value=arguments[0];
		$("#searchOption").submit();
      }
      
	  function see(){
			var pop = window.open("seeDetails.do?aid="+arguments[0],"pop","width=1200,height=800, scrollbars=yes, resizable=no");
	  }
	  
		function addMarker() {
	    	  // 검색결과를 가져온다.
	     	  var aid = document.getElementById("aid"+i).value;
	     	  var aloc = document.getElementById("aloc"+i).value;
	     	  var aname = document.getElementById("aname"+i).value;
	     	  var cid = document.getElementById("clid"+i).value;
	     	  var clname = document.getElementById("clname"+i).value;
	     	  var clday = document.getElementById("clday"+i).value;
	     	  var clstart = document.getElementById("clstart"+i).value;
	     	  var clend = document.getElementById("clend"+i).value;
	     	  var ccost = document.getElementById("ccost"+i).value;
	     	  // 인덱스 1 증가
	      	  i++;
	     	  
	     	  // 가중치 변수 선언
	     	  var fitness = 10;
	          
	    	  naver.maps.Service.geocode({address: aloc}, function(status, response) {
	              if (status !== naver.maps.Service.Status.OK) {
	                  return alert(str + '의 검색 결과가 없거나 기타 네트워크 에러');
	              }
	              var result = response.result;
	              // 검색 결과 갯수: result.total
	              // 첫번째 결과 결과 주소: result.items[0].address
	              // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
	              var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
	              
	              // 직선 거리를 계산한다. 사이를 긋는 Polyline을 그리고 getDistance()를 통하여 거리를 구한다. 단위는 m로 보임.
	              var markerLng = new naver.maps.LatLng(myaddr);
	              var selCLng = new naver.maps.LatLng(selcaddr);
	              var polyline = new naver.maps.Polyline({
	            	  map: map,
	            	  path: [
	            		  new naver.maps.LatLng(selcaddr),
	            		  new naver.maps.LatLng(myaddr)
	            	  ],
	            	  strokeOpacity: 0,
	              });
	              
	              //거리에 비례해서 fitness를 감소시킨다.
	              var realDist = polyline.getDistance()
	              if(srchDist!="") {
		              var Distance = srchDist - realDist;
//	 	              alert(Distance);
	            	  if(Distance < 0) {  fitness--;  }
	            	  if(Distance < -1000) {  fitness--;  }
	            	  if(Distance < -1500) {  fitness--;  }
	            	  if(Distance < -2000) {  fitness--;  }
	              } 
	              
	              // 시작시간을 검사한다. 원하는 시작시간보다 일찍 시작하면 감점시킨다. 중요한 요소이므로 2점 감점한다.
//	               alert(fitness);
	              if(srchStime!=""&&srchStime > clstart) fitness-=2;
//	               alert("srchStime :" + srchStime +"\nclstart :"+clstart+"\nfitness :"+fitness)
	              
	              // 종료시간을 검사한다. 원하는 종료시간보다 늦게 끝나면 감점시킨다. 1점 감점한다.
	              if(srchEtime!=""&&srchEtime < clend) fitness-=1;
//	               alert("srchEtime :" + srchEtime +"\nclend :"+clend+"\nfitness :"+fitness)

				  if(srchCost!="") {
					  var CostGap = srchCost - ccost;
					  if(CostGap < 0) {  fitness--;  }
	            	  if(CostGap < -50000) {  fitness--;  }
	            	  if(CostGap < -100000) {  fitness--;  }
	            	  if(CostGap < -200000) {  fitness--;  }
				  }
				
				  if(StringContent[aloc]==null) {
	            	  StringContent[aloc] = "<style>  </style>";
	            	  StringContent[aloc] +="<div style='padding:9px; font-family: 고도 M'>" +
	            		  					"<table style='background-color: white;'>" +
	            	  						"<tr>" +
	            	  							"<td colspan='2' rowspan='8' width=270px height=200px><img src='img/acatimg/acat_"+aid+".png' width=100% height=100%/></td>" +
	            	  							"<td class='text-center' style='font-weight:bold; font-size:130%; background-color:#0668a1; color:white;' width=150px height=50px>"+aname +"</td>"+
	            	  						"</tr>" +
	            	  						"<tr>" +
	            	  							"<td class='text-center' style='background-color:#1c8eb8; color:white;'> 주  소 </td>" +
	            	  						"</tr>" +
	            	  						"</tr>" +
	            	  						"<tr>" +
	            	  							"<td class='text-center'>"+aloc+"</td>" +
	            	  						"</tr>" +
	            	  						"<tr>" +
	            	  							"<td class='text-center' style='background-color:#1c8eb8; color:white;'> 거  리 </td>" +
	            	  						"</tr>" +
	            	  						"<tr>" +
	            	  							"<td class='text-center'>"+(realDist/1000).toFixed(3)+"km</td>" +
	            	  						"</tr>" +
	            	  						"<tr>" +
	            	  							"<td class='text-center'> <button class='btn btn-primary btn-xs' onclick='see("+aid+")'>자세한 정보 보기</button> </td></tr>" +
	            	  						"</table>";
	            	  StringContent[aloc] +="<table style='background-color: white;' width=420px>" +
	            	  						"<tr>" +
		            	  						"<td class='text-center' style='font-weight:bold; font-size:130%; background-color:#0668a1; color:white;' width=150px height=30px colspan='4'>자기 개발 목록 </td>" +
		            	  					"</tr>" +
		            	  					"<tr class='text-center' style='background-color:#1c8eb8; color:white;'>" +
		            	  						"<td>이름</td>" +
		            	  						"<td>시간</td>" +
		            	  						"<td>가격</td>" +
		            	  						"<td>선택</td>" +
		            	  					"</tr>";
	              } 
				  var clday_real ="";
				  while(clday!=0) {
					  switch(clday%10) {
					    case 1 : clday_real+="월";
					    		 break; 
					    case 2 : clday_real+="화";
					    		 break; 
					    case 3 : clday_real+="수";
					    		 break; 
					    case 4 : clday_real+="목"
					     		 break; 
					    case 5 : clday_real+="금"
					    		 break; 
					    case 6 : clday_real+="토"
					    		 break; 
					    case 7 : clday_real+="일"
					    		 break; 
					  }
					  clday=Math.floor(clday/10);
					  if(clday!=0) {
						  clday_real+=",";
					  }
				  }
				  clday = clday_real.split(",").reverse().join(",");
				  var animation = null;
				  if(iconUrl[aloc]==null) {
					  iconUrl[aloc]="";
				  }
				  if(fitness==10) {
					  StringContent[aloc] += "<tr class='text-center' style='color: red; font-size:120%; font-weight: bold' >";
					  iconUrl[aloc] = "img/marker/marker-red.png";
				  } else if(fitness<=9 && fitness >6) {
					  StringContent[aloc] += "<tr class='text-center' style='color: #ff8400; font-size:110%;'>";
					  if(iconUrl[aloc]!="img/marker/marker-red.png") {
						  iconUrl[aloc] = "img/marker/marker-orange.png";
					  }
				  } else if(fitness<=6 && fitness >3) {
					  StringContent[aloc] += "<tr class='text-center'>";
					  if(iconUrl[aloc]!="img/marker/marker-red.png"&&iconUrl[aloc]!="img/marker/marker-orange.png") {
						  iconUrl[aloc] = "img/marker/marker-blue.png";
					  }
				  } else if(fitness<=3) {
					  StringContent[aloc] += "<tr class='text-center' style='color:#8a7a74;'>";
					  if(iconUrl[aloc]!="img/marker/marker-red.png"&&iconUrl[aloc]!="img/marker/marker-orange.png"&&iconUrl[aloc]!="img/marker/marker-blue.png") {
						  iconUrl[aloc] = "img/marker/marker-gray.png";
					  }
				  }
	              StringContent[aloc] +=    "<td>"+clname+"</td>" +
											"<td>"+clday+" "+clstart+"~"+clend+"</td>" +
											"<td>"+ccost+"</td>" +
											"<td><button class='btn btn-primary btn-xs' onclick='gotoChk("+cid+")'>스케쥴 만들기</button></td>" +
										"</tr>";
	              if(iconUrl[aloc]=="img/marker/marker-red.png") {
	            	  animation = 1;
	              } else {
	            	  animation = null;
	              }
	              
	              alocs_org.push(aloc);
	              positions[aloc]=myaddr;
	              animations[aloc]=animation;
	              

	              
	          });
		          // 마커 클릭 이벤트 처리
	      }

	      function drawMarkers() {
	    	  // 마커 표시
	    	  
	    	  	var alocs = alocs_org.reduce(( a, b ) => {
				if( a.indexOf(b) < 0 ) a.push(b) ;
					return a ;
			  	}, []) ;
	    	  
	    	  	for(var i = 0; i < alocs.length; i++) {
				      var marker = new naver.maps.Marker({
			        	  position: positions[alocs[i]],
			              map: map,
			              animation: animations[alocs[i]],
			              icon: {
			                  url: iconUrl[alocs[i]],
			                  origin: new naver.maps.Point(0, 0),
			                  anchor: new naver.maps.Point(11, 35)
			              }
			          });
			          // 마크 클릭시 인포윈도우 오픈
					  addInfoWindow(marker, StringContent[[alocs[i]]]);
		    	}
	      };
	      
	      function addInfoWindow(marker, string) {
	          naver.maps.Event.addListener(marker, "click", function(e) {
	           	  if (infowindow.getMap()) {
	          			infowindow.close();
	              } else {
	                    infowindow.open(map, marker);
	              }
	          });
	          var infowindow = new naver.maps.InfoWindow({
	              	content: string,
	              	backgroundColor : '#eaf2ff',
	            	  borderColor: '#fff'
	          	});
	      };
	      
	      
	      
	      function addCircle() {
	    	  naver.maps.Service.geocode({address: myaddress}, function(status, response) {
	              if (status !== naver.maps.Service.Status.OK) {
	                  return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
	              }
	              var result = response.result;
	              var selcaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
		    	  var circle = new naver.maps.Circle({
	   		   	    map: map,
	      		    center: selcaddr,
	      	   		radius: srchDist,
	      	    	fillColor: '#e6a1ba',
	      	    	fillOpacity: 0.5
	      		});
	  	    });
	      }
      </script>
</head>
<body>
	<!-- 맵을 표시해주는 Div를 정의한다. -->
	<div id="map" style="width: 100%; height: 500px;"></div>


      
      <% 
         request.setCharacterEncoding("UTF-8");
      	response.setContentType("text/html; charset=UTF-8");
      	  ArrayList<SrchClVO> class_list = (ArrayList<SrchClVO>)request.getAttribute("classlist");
      	 srchOptionVO srchOption = (srchOptionVO) request.getAttribute("srchOption");             
      	 String location = (String) request.getParameter("location");
      	 location = URLEncoder.encode(location, "UTF-8"); %>
      <c:set var="list" value="<%=class_list%>"/>
      <c:set var="srchOption" value="<%=srchOption%>"/>
      <c:set var="loc" value="<%=location%>" />
      <form id="searchOption" action="setSchedule.do" method="post">
		<input type="hidden" id="slloc" name="slloc" value="${loc}"/>
		<input type="hidden" id="acatid" name="acatid" value="${srchOption.cat}"/>
		<input type="hidden" id="clcatid" name="clcatid" value="${srchOption.cl}"/>
		<input type="hidden" id="sldist" name="sldist" value="${srchOption.dist}"/>
		<input type="hidden" id="slcost" name="slcost" value="${srchOption.cost}"/>
		<input type="hidden" id="slstart" name="slstart" value="${srchOption.stime}"/>
		<input type="hidden" id="slend" name="slend" value="${srchOption.etime}"/>
		<input type="hidden" id="clid" name="clid" value=""/>
	  </form>
      <c:forEach items="${list}" var="obj" varStatus="i" >
		<input type="hidden" id="aid${i.count}" value="${obj.aid}"/>
		<input type="hidden" id="aloc${i.count}" value="${obj.aloc}"/>
		<input type="hidden" id="aname${i.count}" value="${obj.aname}"/>
		<input type="hidden" id="clid${i.count}" value="${obj.clid}"/>
		<input type="hidden" id="clname${i.count}" value="${obj.clname}"/>
		<input type="hidden" id="clday${i.count}" value="${obj.clday}"/>
		<input type="hidden" id="clstart${i.count}" value="${obj.clstart}"/>
		<input type="hidden" id="clend${i.count}" value="${obj.clend}"/>
		<input type="hidden" id="ccost${i.count}" value="${obj.ccost}"/>
		<script>
			addMarker();
		</script>
      </c:forEach>
      <script>
			addCircle();
			setTimeout("drawMarkers()",500);
      </script>
</body>
</html>