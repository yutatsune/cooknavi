$( ()=> {
  //共通の定数を定義==================================================================
  const prevContent = $('.material_label-content').prev();

  //プレビューのhtmlを定義============================================================
  function buildHTML(id,image) {
    var html = `<div class="material_preview-box">
                  <div class="material_upper-box">
                    <img src=${image} alt="preview">
                  </div>
                  <div class="material_lower-box">
                    <div class="material_delete-box">
                      <div class="material_delete-btn" data-delete-id= ${id}>削除</div>
                    </div>
                  </div>
                </div>`
    return html;
  }
  //ラベルのwidth・id・forの値を変更==================================================
  function setLabel(count) {
    //プレビューが5個あったらラベルを隠す
    if (count == 5) { 
      $('.material_label-content').hide();
    } else {
      //プレビューが4個以下の場合はラベルを表示
      $('.material_label-content').show();
      //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
      labelWidth = (620 - parseInt($(prevContent).css('width')));
      $('.material_label-content').css('width', labelWidth);
      //id・forの値を変更
      $('.material_label-box').attr({for: `material_material_images_attributes_${count}_src`});
    }
  }

  //編集ページ(materials/:i/edit)へリンクした際のアクション==================================
  if (window.location.href.match(/\/materials\/\d+\/edit/)){
    //プレビューの数を取得
    var count = $('.material_preview-box').length;
    //countに応じてラベルのwidth・id・forの値を変更
    setLabel(count) 
  }

  //プレビューの追加=================================================================
  $(document).on('change', '.material-hidden-field', function() {
    //material-hidden-fieldのidの数値のみ取得
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
      if ($(`#material_material_images_attributes_${id}__destroy`)){
        $(`#material_material_images_attributes_${id}__destroy`).prop('checked',false);
      } 
      //プレビューの数を取得
      var count = $('.material_preview-box').length;
      //countに応じてラベルのwidth・id・forの値を変更
      setLabel(count);
    }
  });

  // 画像の削除=====================================================================
  $(document).on('click', '.material_delete-btn', function() {
    var id = $(this).attr('data-delete-id')
    //削除用チェックボックスがある場合はチェックボックスにチェックを入れる
    if ($(`#material_material_images_attributes_${id}__destroy`).length) {
      $(`#material_material_images_attributes_${id}__destroy`).prop('checked',true);
    }
    //画像を消去
    $(this).parent().parent().parent().remove();
    //フォームの中身を削除
    $(`#material_material_images_attributes_${id}_src`).val("");
    //プレビューの数を取得
    var count = $('.material_preview-box').length;
    //countに応じてラベルのwidth・id・forの値を変更
    setLabel(count);
  });
});