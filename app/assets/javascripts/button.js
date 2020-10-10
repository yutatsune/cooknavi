$(function() {
  $('#button').hover(
    function(){
      $(this).fadeTo("4000", 0.3);
    },
    function(){
      $(this).fadeTo("4000", 1.0);
    }
  );
});