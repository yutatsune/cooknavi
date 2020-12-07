function initMap() {
  //latitude,longitudeから位置を特定
  let latitude = gon.material_latitude
  let longitude = gon.material_longitude
  let test ={lat: latitude, lng: longitude};
  let map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15, 
            center: test
            });
  let transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  let contentString = '住所：<%= shop.address %>';
  let infowindow = new google.maps.InfoWindow({
    content: contentString
  });
  
  //Map上の指定した位置にピンを挿して表示する
  let marker = new google.maps.Marker({
                position:test,
                map: map,
                title: contentString
                });

    marker.addListener('click', function() {
      infowindow.open(map, marker);
    });
};