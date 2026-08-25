# 環境構築・セットアップ手順 (setup.md)

本ドキュメントは、釣果記録＆分析アプリ (my-fishing-app) の開発環境構築手順および初期セットアップ手順をまとめたものです。

---

## 1. 開発環境・前提要件

本プロジェクトは GitHub Codespaces 上での開発（Samsung DeX等のブラウザ環境を含む）に対応しており、クラウド環境・ローカル環境のどちらでもスムーズに構築できます。

・Node.js: v18.x 以上 (推奨: LTS)
・パッケージマネージャー: npm
・フレームワーク: Next.js (App Router, TypeScript, Tailwind CSS)
・データベース: Supabase (PostgreSQL)
・ホスティング: Vercel

---

## 2. プロジェクトの初期化

### ① リポジトリのクローンとプロジェクトディレクトリへの移動

git clone <YOUR_REPOSITORY_URL> my-fishing-app
cd my-fishing-app

### ② Next.js プロジェクトの作成

npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"

※競合エラーが発生した場合（既存ファイルがある場合）は、一時フォルダ経由で生成します。

npx create-next-app@latest temp --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"
shopt -s dotglob
mv temp/* .
rm -rf temp

---

## 3. 依存パッケージのインストール

### ① テスト環境（Vitest）の導入

npm install -D vitest @vitejs/plugin-react @testing-library/react @testing-library/jest-dom jsdom

### ② Supabase クライアントライブラリの導入

npm install @supabase/supabase-js @supabase/ssr

---

## 4. 設定ファイルの追加・編集

### ① vite.config.ts の作成
プロジェクト直下に vite.config.ts を作成し、以下を記述します。

import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
});

### ② package.json へテストスクリプトの追記
package.json の "scripts" に "test": "vitest" を追加します。

"scripts": {
  "dev": "next dev",
  "build": "next build",
  "start": "next start",
  "lint": "next lint",
  "test": "vitest"
}

### ③ 環境変数 .env.local の作成
プロジェクト直下に .env.local を作成し、Supabaseの接続情報を記述します。

NEXT_PUBLIC_SUPABASE_URL=YOUR_SUPABASE_URL
NEXT_PUBLIC_SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY

---

## 5. ディレクトリ構造の作成 (Package by Feature)

src ディレクトリ配下に機能ごとのフォルダを作成します。

mkdir -p src/features/record
mkdir -p src/features/analysis
mkdir -p src/features/feed

【ディレクトリ構成図】
src/
├── features/
│   ├── record/        # 釣果記録機能 (UI, API, 型定義, テスト)
│   ├── analysis/      # マイデータ分析機能 (UI, アルゴリズム, 型定義)
│   └── feed/          # 共有・タイムライン機能 (UI, API)
├── components/        # 全体で共通利用する汎用UIコンポーネント
├── lib/               # Supabase等の共通ライブラリ設定
├── types/             # アプリ全体の共通型定義
└── app/               # Next.js (App Router) ルーティング層

---

## 6. データベース構築 (Supabase SQL)

Supabase の SQL エディタを開き、以下のテーブル作成 SQL を実行します。

-- 1. 釣行ログテーブル（環境データ・ボウズ記録に対応）
CREATE TABLE fishing_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    fished_at TIMESTAMPTZ NOT NULL,
    location_name VARCHAR(100) NOT NULL,
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    tide VARCHAR(20),
    tide_level DECIMAL(5, 1),
    water_temp DECIMAL(4, 1),
    wind_direction VARCHAR(20),
    wind_speed DECIMAL(4, 1),
    is_public BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. 釣果詳細テーブル（1釣行に対して複数の釣果を紐付け）
CREATE TABLE catch_details (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    log_id UUID NOT NULL REFERENCES fishing_logs(id) ON DELETE CASCADE,
    fish_species VARCHAR(50) NOT NULL,
    size DECIMAL(5, 1),
    bait_lure VARCHAR(100),
    count INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 3. インデックスの作成
CREATE INDEX idx_fishing_logs_user_id ON fishing_logs(user_id);
CREATE INDEX idx_fishing_logs_fished_at ON fishing_logs(fished_at);
CREATE INDEX idx_catch_details_log_id ON catch_details(log_id);
CREATE INDEX idx_catch_details_fish_species ON catch_details(fish_species);

---

## 7. 動作確認と本番デプロイ

### 開発サーバーの起動

npm run dev

・http://localhost:3000 にアクセスし、Next.js の初期画面が表示されれば準備完了です。

### Vercel へのデプロイ
1. GitHub リポジトリへコードを Push します。
2. Vercel のダッシュボードから該当リポジトリをインポートします。
3. 環境変数（NEXT_PUBLIC_SUPABASE_URL / NEXT_PUBLIC_SUPABASE_ANON_KEY）を設定して Deploy を実行します。
