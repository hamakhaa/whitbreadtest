<%@ page language="java" contentType="text/html;"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>Foursquare Integration</title>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false" type="text/javascript"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

</head>
<body>

<!-- Search Area -->
<div class="row">
  <div class="col-lg-12" style="text-align:center;">
  <h2>Welcome to the place search application</h2>
  </div><!-- /.col-lg-12 -->
    
</div><!-- /.row -->
<div class="row">
   	<form action="search" method="post">
	<div class="col-lg-12">
    	<div class="input-group">
	      		<input type="text" class="form-control" value="${place}" name="place" placeholder="Search for...">
	      		<span class="input-group-btn">
	        		<input class="btn btn-default" type="submit">Search!</input>
	      		</span>
    	</div><!-- /input-group -->
  	</div><!-- /.col-lg-12 -->
    </form>	
</div><!-- /.row -->

<!-- Map Area -->
<div id="map-canvas" style="height:600px; width:100%"></div>

<script>
	var locations = [	
		<c:forEach var="place" items="${searchedPlaces}" varStatus="loop">
	   		["${place.name}", ${place.latitude}, ${place.longitude}, ${loop.index}],
		</c:forEach>
	];
	
	if (locations.length==0) {
		document.getElementById('map-canvas').innerHTML = "<div style=\"text-align:center;\"><h3>No results found.</h3>";	
	}
               var map = new google.maps.Map(document.getElementById('map-canvas'), {
                 zoom: 12,
                 center: new google.maps.LatLng(locations[0][1], locations[0][2]),
                 mapTypeId: google.maps.MapTypeId.ROADMAP
               });

               var infowindow = new google.maps.InfoWindow();

               var marker, i;

               for (i = 0; i < locations.length; i++) {  
                 marker = new google.maps.Marker({
                   position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                   map: map
                 });

                 google.maps.event.addListener(marker, 'click', (function(marker, i) {
                   return function() {
                     infowindow.setContent(locations[i][0]);
                     infowindow.open(map, marker);
                   }
                 })(marker, i));
               }
	</script>
</body>
</html>