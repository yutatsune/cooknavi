<h2 align="center">CookNavi</h2>

## :link: アプリケーションの概要
<ul>
  <li>レシピが投稿できるアプリです。</li>
  <li>今後、レシピで使う材料はどこで買えるのか共有しあえる機能を追加予定です。</li>
</ul>

## :link: 制作背景
<ul>
  <li>日頃、料理のレシピを見ていて、この材料はどこで買えるんだろうと思うことがありました。</li>
  <li>そこで、レシピを投稿できるアプリに、材料はどこで買えるのか共有できる機能を実装できれば解決できるのではないかと考え、このアプリを制作することにしました。</li>
</ul>

## :link: 実装予定の内容
<ul>
  <li>材料が手に入る場所を共有する機能の追加</li>
  <li>非同期通信を使ったインクリメンタルサーチの実装</li>
  <li>自慢の調理器具を紹介するコーナー</li>
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

## recipesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text||
|text|text||
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_many :comments

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|recipe_id|references|null: false, foreign_key: true|
### Association
- belongs_to :recipe
- belongs_to :user