# 🚀 ローカル環境構築ガイド

このリポジトリへようこそ！
以下の手順に沿って、ローカル開発環境のセットアップを行ってください。

---

## 🛠 前提条件（必要なツールの準備）

まずは開発に必要なツールを PC にインストールします。

1. **Node.js (v18以上)**
   * 公式サイト（ https://nodejs.org/ ）から **LTS（推奨版）** をダウンロードしてインストールしてください。
2. **Git**
   * 公式サイト（ https://git-scm.com/ ）からダウンロードしてインストールしてください。
3. **VS Code**
   * 公式サイト（ https://code.visualstudio.com/ ）からダウンロードしてインストールしてください。

※ Node.js や Git を新規インストールした場合は、設定（パス）を反映させるために **PC または VS Code を一度再起動** してください。

---

## 🏃 セットアップ手順

### 1. リポジトリのクローン
PCのターミナル（Command Prompt または PowerShell）を開き、以下を実行します。

git clone <repository-url>

### 2. VS Code でプロジェクトフォルダを開く
VS Code を起動し、[ファイル] ＞ [フォルダを開く] から、クローンしたプロジェクトフォルダ（my-fishing-app）を開きます。
（またはターミナルで `cd my-fishing-app` を実行してから `code .` で開きます）

### 3. VS Code のターミナルを開く
VS Code の上部メニューから [ターミナル] ＞ [新しいターミナル] を開きます。

### 4. パッケージのインストール
VS Code のターミナルで以下を実行します。

npm install

※ もし `npm: コマンドが見つかりません` 等のエラーが出た場合は、Node.js のインストール後に VS Code を再起動していない可能性が高いため、VS Code を一度閉じて立ち上げ直してください。

### 5. 環境変数（.env.local）の作成
プロジェクトのルート直下に .env.local ファイルを作成し、共有された Supabase の接続情報を貼り付けてください。

NEXT_PUBLIC_SUPABASE_URL={your-supabase-url}
NEXT_PUBLIC_SUPABASE_ANON_KEY={your-supabase-anon-key}

### 6. 開発サーバーの起動
VS Code のターミナルで以下を実行します。

npm run dev

起動後、ブラウザで http://localhost:3000 にアクセスして画面が表示されれば構築完了です！

---

