$(function(){
  function buildHTML(comment){
    let html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>：
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  }
  $('#material_new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.material_show_contents__container__comments').append(html);
      $('.material_show_contents__container__text').val('');
      $('.material_show_contents__container__send').prop('disabled', false);
    })
  })
})