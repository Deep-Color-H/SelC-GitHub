<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>네이버 지도 API - 주소로 지도 표시하기</title>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=jmCEmLTgevYoxVl4hCGK&submodules=geocoder"></script>	
<script src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
<!-- alert 창 -->
<link rel="stylesheet" href="themes/alertify.core.css"/>
<link rel="stylesheet" href="themes/alertify.default.css"/>
<script src="lib/alertify.min.js"></script>
</head>
<body>
	<div id="map" style="width: 100%; height: 500px;"></div>
	<script type="text/javascript">
	  var map = new naver.maps.Map('map', {
  	      zoom:9
      });
	
	  var center = "";
     

		var infowindow = new naver.maps.InfoWindow();

		function onSuccessGeolocation(position) {
    		var location = new naver.maps.LatLng(position.coords.latitude,
            		                             position.coords.longitude);

    		map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
    		map.setZoom(10); // 지도의 줌 레벨을 변경합니다.
    		var marker = new naver.maps.Marker({
		            position: location,
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
	              content: '<h4>자기개발자님께서 접속하신 위치입니다.<img src="img/SelC.png" style="width:40px; height:auto;"/></h4>'
	          });
		}

		function onErrorGeolocation() {
			 var myaddress = "효령로 335";
		      //var myaddress = '대동로 34-16';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
		      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
		          if (status !== naver.maps.Service.Status.OK) {
		              return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
		          }
		          var result = response.result;
		          // 검색 결과 갯수: result.total
		          // 첫번째 결과 결과 주소: result.items[0].address
		          // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
		          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
		          map.setCenter(center); // 검색된 좌표로 지도 이동
		          // 마커 표시
		          var marker = new naver.maps.Marker({
		            position: myaddr,
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
		              content: '<h4>여러분의 미래가 함께하는 이곳은, 엔코아 플레이데이터입니다.<img src="img/SelC.png" style="width:40px; height:auto;"/></h4>'
		          });
		      });
		}

		$(window).on("load", function() {
    		if (navigator.geolocation) {
        		navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
    		} else {
        		var center = map.getCenter();
        		infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
        		infowindow.open(map, center);
    		}
		});
      </script>
      <script>
     	 $(document).ready(function() {
    		  alertify.success("위에 있는 버튼을 클릭해보세요.");
  		 });
      </script>
</body>
</html>