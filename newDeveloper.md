# 🚀 ローカル環境構築ガイド

このリポジトリへようこそ！
以下の手順に沿って、ローカル開発環境のセットアップを行ってください。

---

## 🛠 前提条件

事前に以下のツールがインストールされていることを確認してください。
* Node.js: v18.x 以上
* Git

---

## 🏃 セットアップ手順

### 1. リポジトリのクローン
git clone <repository-url>
cd <project-directory>

### 2. パッケージのインストール
npm install

### 3. 環境変数（.env.local）の作成
プロジェクトのルート直下に .env.local ファイルを作成し、共有された Supabase の接続情報を貼り付けてください。

NEXT_PUBLIC_SUPABASE_URL={your-supabase-url}
NEXT_PUBLIC_SUPABASE_ANON_KEY={your-supabase-anon-key}

### 4. 開発サーバーの起動
npm run dev

起動後、ブラウザで http://localhost:3000 にアクセスして画面が表示されれば構築完了です！

---
