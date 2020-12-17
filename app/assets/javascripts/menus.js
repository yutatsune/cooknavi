$(function(){
  let dis = 200
  $("button").click(function(){
    $("nav").animate({"margin-left": "+=" + dis + "px"}, 200);
    dis *= -1
  });
});