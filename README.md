# README

# yuiyui.com

  +好きなアイドルや声優さんのライブ、グッズ、書籍、CD、DVD、BDなどの
  +感想を写真付きで共有できるサービスです。[ https://yuiyuicom.herokuapp.com/ ]

  +DebugAccount:

  +[email] yui@yui.com
  +[password] password

# 使用した技術
  
  +・デプロイ
      +heroku（GitHubと連携した自動デプロイサービスも利用）
  
  +・Rspec
      +単体テスト
      +統合テスト
  
  +・画像アップロード
      +carrierwave
      +minimagick
  
  +・DB
      +開発、テスト環境：sqlite3
      +本番環境：PostgreSQL
  
  +・ページネーション
      +kaminari
  
  +・デザイン
      +bootstrap
    
  +・キーワード検索機能
    　+ユーザー名、記事の中身で検索可能
    　+gemを使わずに実装
  
  +・ユーザー認証
      +認証まわりの勉強を兼ねてdevise等のgemを使わずに実装
      +ログイン,ログアウト,永続ログイン,パスワード再設定など
      
  +・管理ユーザー機能
      +管理ユーザーのみ全てのアカウントとポストの削除が可能
      
# 主な機能
  
  +ユーザーの作成、削除、編集
  +投稿の作成、削除、編集
  +複数画像の投稿
  +ユーザーのアバター画像変更
  +投稿に「いいね」をつける
  +他ユーザーをフォロー、アンフォローする
  +投稿の内容、ユーザー名の検索 
  

# Requirement
   +Ruby : 2.5.3
   +Rails: 5.1.7
