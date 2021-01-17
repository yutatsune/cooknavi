<h2 align="center">CookNavi</h2>

![443ae4e96c03a5cb995b4350dd322e82](https://user-images.githubusercontent.com/66116053/103897639-3473fd80-5137-11eb-9d6e-a86386a86459.jpg)

## :link: アプリケーションの概要
<ul>
  <li>レシピが投稿できるアプリです。</li>
  <li>また、レシピで使う材料はどこで買えるのか共有しあえる機能がございます。</li>
  <li>材料の情報を投稿する際に入力した住所の情報から、自動でGoogleMapの位置情報を取得できます。</li>
</ul>

## :globe_with_meridians: App URL
<ul>
  <li>https://www.cooknavi.xyz/</li>
</ul>

## :link: 制作背景
<ul>
  <li>日頃、料理のレシピを見ていて、この材料はどこで買えるんだろうと思うことがありました。</li>
  <li>そこで、レシピを投稿できるアプリに、材料はどこで買えるのか共有できる機能を実装できれば解決できるのではないかと考え、このアプリを制作することにしました。</li>
</ul>

## :laptop: 利用方法
<ul>
  <li>トップページからゲストログイン（閲覧用）をクリック</li>
  <li>「レシピを見てみる」または「材料を探してみる」をクリックし、一覧画面へ遷移する</li>
  <li>新規投稿は右下の投稿をクリック</li>
  <li>投稿完了後は一覧画面へ戻る</li>
</ul>

## :wrapped_gift: 機能一覧
|機能|概要|
|----|----|
|ユーザー管理機能|新規登録・ログイン・ログアウトが可能|
|投稿機能|レシピまたは材料を画像を5枚までつけて投稿可能|
|投稿詳細表示機能|各投稿画面が詳細ページで見ることができます|
|投稿編集・削除機能|投稿者本人のみ投稿編集・削除が可能|
|ユーザー一覧表示機能|登録したユーザーの一覧を見ることができます|
|ユーザー情報編集機能|ログイン中のユーザーでアカウント本人であればプロフィール編集が可能|
|フォロー機能|ユーザー一覧画面から各ユーザーのフォローが可能|
|フォロー一覧表示機能|フォローしているまたはフォローされているユーザーを見ることができます|
|いいね機能|投稿詳細ページからいいねすることが可能|
|いいね一覧機能|いいねした投稿の一覧を見ることができます|
|コメント機能|投稿詳細ページから非同期通信でコメントが可能|
|住所自動入力機能|材料投稿画面にて、郵便番号を入力するだけで住所が自動で入力されます|
|マップ表示機能|材料投稿画面で入力した住所の経度・緯度を自動で取得し、マップで表示することができます|

# CookNavi DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
### Association
- has_many :recipes
- has_many :comments
- has_many :materials
- has_many :material_comments
- has_many :recipe_likes
- has_many :liked_recipes, through: :recipe_likes, source: :recipe
- has_many :material_likes
- has_many :liked_materials, through: :material_likes, source: :material
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_rerationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_rerationships, source: :user

## relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|follow_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :follow, class_name: 'User'

## recipesテーブル
|Column|Type|Options|
|------|----|-------|
|name|text|null: false|
|explanation|text|null: false|
|material|text|null: false|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_many :comments
- has_many :images

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|string|null: false|
|recipe_id|references|null: false, foreign_key: true|
### Association
- belongs_to :recipe

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|recipe_id|references|null: false, foreign_key: true|
### Association
- belongs_to :recipe
- belongs_to :user

## recipe_likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|recipe_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :recipe

## materialテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|postcode|integer|null: false|
|prefecture_code|integer|null: false|
|address_city|string|null: false|
|address_building|string||
|explanation|text|null: false|
|latitude|float|null: false|
|longitude|float|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_many :material_comments
- has_many :material_images

## material_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|string|null: false|
|material_id|references|null: false, foreign_key: true|
### Association
- belongs_to :material

## material_commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|material_id|references|null: false, foreign_key: true|
### Association
- belongs_to :material
- belongs_to :user

## material_likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|material_id|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :material