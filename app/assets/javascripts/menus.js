$(function(){
  let dis = 250
  $("button").click(function(){
    $("nav").animate({"margin-left": "+=" + dis + "px"}, 200);
    $(".cook-contents").animate({"margin-left": "+=" + dis + "px"}, 200);
    dis *= -1
  });
});