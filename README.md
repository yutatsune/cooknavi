<h2 align="center">CookNavi</h2>

![443ae4e96c03a5cb995b4350dd322e82](https://user-images.githubusercontent.com/66116053/103897639-3473fd80-5137-11eb-9d6e-a86386a86459.jpg)

## :globe_with_meridians: サイト紹介
<ul>
  <li>ログイン用Email : yutayuta@gmail.com</li>
  <li>パスワード : yutayuta</li>
  <li>IPアドレス : http://3.114.126.161/</li>
</ul>

## :link: アプリケーションの概要
<ul>
  <li>レシピが投稿できるアプリです。</li>
  <li>また、レシピで使う材料はどこで買えるのか共有しあえる機能がございます。</li>
  <li>材料の情報を投稿する際に入力した住所の情報から、自動でGoogleMapの位置情報を取得できます。</li>
</ul>

## :link: 制作背景
<ul>
  <li>日頃、料理のレシピを見ていて、この材料はどこで買えるんだろうと思うことがありました。</li>
  <li>そこで、レシピを投稿できるアプリに、材料はどこで買えるのか共有できる機能を実装できれば解決できるのではないかと考え、このアプリを制作することにしました。</li>
</ul>

## :link: 実装予定の内容
<ul>
  <li>マイページの拡張</li>
  <li>現在Googleマップとの連携に挑戦中です</li>
  <li>(マップの表示はできるものの、動作が不安定なため検証中)</li>
</ul>

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
|explanation|string|null: false|
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