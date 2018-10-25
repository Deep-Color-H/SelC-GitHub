<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>���̹� ���� API - �ּҷ� ���� ǥ���ϱ�</title>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=jmCEmLTgevYoxVl4hCGK&submodules=geocoder"></script>	
<script src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
<!-- alert â -->
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
      var myaddress = "<%=request.getParameter("location").trim()%>";
      //var myaddress = '�뵿�� 34-16';// ���θ� �ּҳ� ���� �ּҸ� ���� (�ǹ��� �Ұ�!!!!)
      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
          if (status !== naver.maps.Service.Status.OK) {
              return alert(myaddress + '�� �˻� ����� ���ų� ��Ÿ ��Ʈ��ũ ����');
          }
          var result = response.result;
          // �˻� ��� ����: result.total
          // ù��° ��� ��� �ּ�: result.items[0].address
          // ù��° �˻� ��� ��ǥ: result.items[0].point.y, result.items[0].point.x
          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
          map.setCenter(myaddr); // �˻��� ��ǥ�� ���� �̵�
          // ��Ŀ ǥ��
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
          // ��Ŀ Ŭ�� �̺�Ʈ ó��
          naver.maps.Event.addListener(marker, "click", function(e) {
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }
          });
          // ��ũ Ŭ���� ���������� ����
          var infowindow = new naver.maps.InfoWindow({
              content: '<h4>�ڱⰳ���ڴ��� ��ġ�Դϴ�.<img src="img/SelC.png" style="width:40px; height:auto;"/></h4>'
          });
      });
      </script>

</body>
</html>