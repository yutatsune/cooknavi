$( ()=> {
  //共通の定数を定義==================================================================
  const prevContent = $('.label-content').prev();

  //プレビューのhtmlを定義============================================================
  function buildHTML(id,image) {
    var html = `<div class="preview-box">
                  <div class="upper-box">
                    <img src=${image} alt="preview">
                  </div>
                  <div class="lower-box">
                    <div class="delete-box">
                      <div class="delete-btn" data-delete-id= ${id}>削除</div>
                    </div>
                  </div>
                </div>`
    return html;
  }
  //ラベルのwidth・id・forの値を変更==================================================
  function setLabel(count) {
    //プレビューが5個あったらラベルを隠す
    if (count == 5) { 
      $('.label-content').hide();
    } else {
      //プレビューが4個以下の場合はラベルを表示
      $('.label-content').show();
      //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
      labelWidth = (620 - parseInt($(prevContent).css('width')));
      $('.label-content').css('width', labelWidth);
      //id・forの値を変更
      $('.label-box').attr({for: `recipe_images_attributes_${count}_src`});
    }
  }

  //編集ページ(recipes/:i/edit)へリンクした際のアクション==================================
  if (window.location.href.match(/\/recipes\/\d+\/edit/)){
    //プレビューの数を取得
    var count = $('.preview-box').length;
    //countに応じてラベルのwidth・id・forの値を変更
    setLabel(count) 
  }

  //プレビューの追加=================================================================
  $(document).on('change', '.hidden-field', function() {
    //hidden-fieldのidの数値のみ取得
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    //選択したfileのオブジェクトを取得
    var file = this.files[0];
    var reader = new FileReader();
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      var image = this.result;
      //htmlを作成
      var html = buildHTML(id,image);
      //ラベルの直前のプレビュー群にプレビューを追加
      $(prevContent).append(html);
      //プレビュー削除したフィールドにチェックボックスがあった場合、チェックを外す
      if ($(`#recipe_images_attributes_${id}__destroy`)){
        $(`#recipe_images_attributes_${id}__destroy`).prop('checked',false);
      } 
      //プレビューの数を取得
      var count = $('.preview-box').length;
      //countに応じてラベルのwidth・id・forの値を変更
      setLabel(count);
    }
  });

  // 画像の削除=====================================================================
  $(document).on('click', '.delete-btn', function() {
    var id = $(this).attr('data-delete-id')
    //削除用チェックボックスがある場合はチェックボックスにチェックを入れる
    if ($(`#recipe_images_attributes_${id}__destroy`).length) {
      $(`#recipe_images_attributes_${id}__destroy`).prop('checked',true);
    }
    //画像を消去
    $(this).parent().parent().parent().remove();
    //フォームの中身を削除
    $(`#recipe_images_attributes_${id}_src`).val("");
    //プレビューの数を取得
    var count = $('.preview-box').length;
    //countに応じてラベルのwidth・id・forの値を変更
    setLabel(count);
  });
});