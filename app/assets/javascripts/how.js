$(function(){
  function buildField(index) {  // 追加するフォームのｈｔｍｌを用意
    const html = `<div class="js-file-group_how" data-index="${index}">
                    <div class="how-box_title">
                      作り方
                    </div>
                    <div class="how-box_form">
                      <textarea placeholder="例)卵を加えてかき混ぜる" rows="5" name="recipe[hows_attributes][${index}][how]" id="recipe_hows_attributes_${index}_how"></textarea>
                      <span class="delete-form-btn">
                        削除する
                      </span>
                    </div>
                  </div>`;
    return html;
  }

  let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14] // 追加するフォームのインデックス番号を用意
  var lastIndex = $(".js-file-group_how:last").data("index"); // 編集フォーム用（すでにデータがある分のインデックス番号が何か取得しておく）
  fileIndex.splice(0, lastIndex); // 編集フォーム用（データがある分のインデックスをfileIndexから除いておく）
  let fileCount = $(".hidden-destroy_how").length; // 編集フォーム用（データがある分のフォームの数を取得する）
  let displayCount = $(".js-file-group_how").length // 見えているフォームの数を取得する
  $(".hidden-destroy_how").hide(); // 編集フォーム用（削除用のチェックボックスを非表示にしておく）
  if (fileIndex.length == 0) $(".add-form-btn_how").css("display","none"); // 編集フォーム用（フォームが５つある場合は追加ボタンを非表示にしておく）

  $(".add-form-btn_how").on("click", function() { // 追加ボタンクリックでイベント発火
    $(".how-area").append(buildField(fileIndex[0])); // fileIndexの一番小さい数字をインデックス番号に使ってフォームを作成
    fileIndex.shift(); // fileIndexの一番小さい数字を取り除く
    if (fileIndex.length == 0) $(".add-form-btn_how").css("display","none"); // フォームが15になったら追加ボタンを非表示にする
    displayCount += 1; // 見えているフォームの数をカウントアップしておく
  })
  $(".how-area").on("click", ".delete-form-btn", function() { // 削除ボタンクリックでイベント発火
    $(".add-form-btn_how").css("display","block"); // どの道フォームは一つ消えるので、追加ボタンを必ず表示させるようにしておく
    const targetIndex = $(this).parent().parent().data("index") // クリックした箇所のインデックス番号を取得
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy_how`); // 編集用（クリックした箇所のチェックボックスを取得）
    var lastIndex = $(".js-file-group_how:last").data("index"); // フォームの最後に使われているインデックス番号を取得
    displayCount -= 1; // 表示されているフォーム数を一つカウントダウン
    if (targetIndex < fileCount) { // 編集用（チェックボックスがある場合の処理）
      $(this).parent().parent().css("display","none") // フォームを非表示にする
      hiddenCheck.prop("checked", true); // チェックボックスにチェックを入れる
    } else { // チェックボックスがない場合の処理
      $(this).parent().parent().remove(); // フォームを削除する
    }
    // ↓はfileIndex（フォーム追加ように用意してある数字の配列）の処理
    if (fileIndex.length >= 1) { // 数字が一つでも残っている場合
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1); // 配列の一番右側にある数字に１を足した数字を追加
    } else {
      fileIndex.push(lastIndex + 1); // フォームの最後の数字に1を足した数字を追加
    }
    // ↓はフォームがなくならないための処理
    if (displayCount == 0) { // 見えてるフォームの数が0になったとき
      $(".how-area").append(buildField(fileIndex[0] - 1)); // fileIndexの一番左側にある数字から１引いた数字でフォームを作成
      fileIndex.shift(); // fileIndexの一番小さい数字を取り除く
      displayCount += 1; // 見えているフォームの数をカウントアップしておく
    }
  })
})
