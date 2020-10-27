<h2 align="center">CookNavi</h2>

![443ae4e96c03a5cb995b4350dd322e82](https://user-images.githubusercontent.com/66116053/89136208-78058280-d56d-11ea-8d75-f5f2fbd31fd5.jpg)

## :globe_with_meridians: サイト紹介
<ul>
  <li>ログイン用Email : yutayuta@gmail.com</li>
  <li>パスワード : yutayuta</li>
  <li>IPアドレス : http://176.32.93.82/</li>
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
  <li>レシピや材料情報のいいね機能</li>
  <li>ユーザー情報編集機能</li>
  <li>現在Googleマップとの連携に挑戦中です</li>
  <li>(マップの表示はできるものの、動作が不安定なため検証中)</li>
</ul>

# CookNavi DB設計（暫定）
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

## recipesテーブル
|Column|Type|Options|
|------|----|-------|
|name|text||
|material|text||
|text|text||
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_many :comments
- has_many :images

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|string||
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

## materialテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|postcode|integer||
|prefecture_code|integer||
|address_city|string||
|address_building|string||
|latitude|float||
|longitude|float||
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user