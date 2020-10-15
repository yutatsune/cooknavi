// 店舗新規登録画面
// Mapの表示
//マップオブジェクト
var gMap = null;
//マーカーオブジェクト
var gMarkerCenter = null;

function initMap(){

// 座標を設定
  var myLatLng = new google.maps.LatLng(10, 10)
  var mapOptions = {
    center: myLatLng,
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
// マップオブジェクトの生成、マーカー生成
  gMap = new google.maps.Map(document.getElementById("map"), mapOptions);
  gMarkerCenter = drawMarkerCenterInit(myLatLng);
}
// マーカー生成関数
function drawMarkerCenterInit(pos) {
  var markerCenter = new google.maps.Marker({
    position: pos,
    map: gMap,
    draggable: true
 });
  return markerCenter;
}

$(function(){
  // 検索ボタンをクリックした時
  $('#searchAddressBtn').click(function() {
    // Geocoderオブジェクト生成
    var geocoder = new google.maps.Geocoder();
    // 住所のテキストボックスから住所取得
    var address = $('.address_city').val();
    console.log(geocoder)
    // 住所検索実行
    geocoder.geocode(
      {
        'address' : address,
        'region' : 'jp'
      },
      function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          // 住所のデータを取得できた時
          // 取得した座標をマップに反映
          gMap.setCenter(results[0].geometry.location);
          // 取得した座標をマーカーに反映
          var pos = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
          gMarkerCenter.setPosition(pos);

          // 取得した座標をテキストボックスにセット
          $('#material_latitude').val(pos.lat());
          $('#material_longitude').val(pos.lng());

          } else {
            // 失敗した時
              alert('住所検索に失敗しました。<br>住所が正しいか確認してください');
          }
      });
  });
});