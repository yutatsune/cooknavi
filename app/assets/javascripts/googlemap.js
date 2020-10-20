$(document).on('turbolinks:load',function initMap() {
  //latitude,longitudeから位置を特定
  var latitude = gon.material_latitude
  var longitude = gon.material_longitude
  var test ={lat: latitude, lng: longitude};
  var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15, 
            center: test
            });
  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  var contentString = '住所：<%= shop.address %>';
  var infowindow = new google.maps.InfoWindow({
    content: contentString
  });
  
  //Map上の指定した位置にピンを挿して表示する
  var marker = new google.maps.Marker({
                position:test,
                map: map,
                title: contentString
                });

    marker.addListener('click', function() {
      infowindow.open(map, marker);
    });
});