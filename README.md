# TechLog App

TechLog App は、プログラミング学習の内容を日々記録し、あとから振り返るための学習ログ管理アプリです。  
「何を学んだか」「どこでつまずいたか」「次に何をするか」を短い投稿として蓄積し、学習の継続と成長の可視化をサポートします。

このアプリでは、ユーザー登録後に学習ログ（Post）を作成し、一覧・詳細画面で過去の記録を確認できます。  
ユーザーページでは投稿履歴と投稿数を確認できるため、学習量の変化を把握しやすくなっています。

主なユースケースは次のとおりです。

- 今日学んだ内容を簡潔に記録する
- 過去の投稿を見返して復習する
- 投稿数を見ながら学習習慣を維持する

実装は Rails 8 系をベースに、認証に Devise、UI に Tailwind CSS、テストに RSpec / Capybara / FactoryBot を採用しています。

## 主な機能

- ユーザー登録 / ログイン / ログアウト
- 学習ログ（Post）の作成・一覧・詳細・削除
- ユーザーページで投稿一覧と投稿数を表示
- 未ログイン時の投稿作成制限（`authenticate_user!`）

## 技術スタック

- Ruby `3.2.2`
- Rails `8.1.x`
- DB
	- 開発・テスト: SQLite3（`storage/*.sqlite3`）
	- 本番: `DATABASE_URL`（PostgreSQL 想定）
- 認証: Devise
- フロント: Importmap + Turbo + Stimulus + Tailwind CSS
- テスト: RSpec / Capybara / FactoryBot

## セットアップ

```bash
cd techlog-app
bundle install
bin/rails db:prepare
```

または一括セットアップ:

```bash
bin/setup
```

## 開発サーバー起動

```bash
bin/dev
```

`Procfile.dev` で以下を同時起動します。

- Rails サーバー
- Tailwind の watch

## テスト

```bash
# 全体
bin/rspec

# 個別
bin/rspec spec/models/user_spec.rb
```

`bin/rspec` はデフォルトで Spring を使いません。  
Spring を使う場合のみ:

```bash
USE_SPRING=1 bin/rspec
```

## 静的解析・セキュリティチェック

```bash
bin/rubocop
bin/brakeman
bin/bundler-audit
```

## 主要ルーティング

- `/` : トップページ
- `/posts` : 投稿一覧
- `/posts/new` : 投稿作成（ログイン必須）
- `/posts/:id` : 投稿詳細
- `/users/:id` : ユーザーページ
- Devise:
	- `/users/sign_up`
	- `/users/sign_in`

## 本番実行（Docker）

このリポジトリの `Dockerfile` は本番向けです。

```bash
docker build -t techlog_app .
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<your_master_key> --name techlog_app techlog_app
```

## 補足

- Rails 8.2 互換に関する deprecation warning（Devise / routes 由来）が表示される場合があります。
- 動作には `config/master.key` または `RAILS_MASTER_KEY` が必要です（環境に応じて設定）。
