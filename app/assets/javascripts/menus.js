$(function(){
  let dis = 250
  $("button").click(function(){
    $("nav").animate({"margin-left": "+=" + dis + "px"}, 200);
    $(".big-bg").animate({"margin-left": "+=" + dis + "px"}, 200);
    dis *= -1
  });
});