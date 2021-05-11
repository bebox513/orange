# orange
***

介護専用のSNS機能と、ご家族と、関係施設、ケアマネジャーの情報共有を目的に作成しました。

レスポンシブ対応していますので、スマホからもご確認いただけます。

新規登録ボタンからゲストログインが可能となっております。是非ご使用下さい。

<img width="1792" alt="スクリーンショット 2021-03-29 17 01 12" src="https://user-images.githubusercontent.com/61938584/112808635-28536880-90b4-11eb-8148-a7e45d73469f.png">

# URL
***
http://orange-community.net

# AWS構成図
***
![構成図](https://user-images.githubusercontent.com/61938584/117607206-728d3680-b196-11eb-8967-d5bbdbfa73b1.png)


# 使用技術
***
- Ruby 2.6.3
- Ruby on Rails 5.2.4
- MySQL 8.0.19
- Nginx
- Unicorn
- AWS
  - VPC
  - EC2

# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能
- コメント機能
- いいねいのう(Ajax)
- フォロー機能(Ajax)
- 画像投稿機能
- 画像プレビュー機能(javascript、jquery)
- ページネーション機能(kaminari)
- 無限スクロール機能(Ajax)
- 検索機能
- メッセージ機能
- 介護記録機能
- 利用者登録機能

# テスト
- RSpec
  - 単体テスト(model)
  - 統合テスト(feature)
