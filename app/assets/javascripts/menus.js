$(function(){
  let dis = 200
  $(".headerbutton").click(function(){
    $("nav").animate({"margin-left": "+=" + dis + "px"}, 200);
    dis *= -1
  });
});