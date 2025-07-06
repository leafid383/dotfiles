# 🏠 My Dotfiles

個人用のmacOS開発環境設定ファイルとセットアップ自動化スクリプト

## 🚀 クイックセットアップ

```bash
# リポジトリをクローン
git clone git@github.com:leafid383/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 自動セットアップを実行
./install.sh

# ターミナルを再起動
exec zsh
```

## 📦 含まれる内容

### シェル設定
- **Zsh** + Oh My Zshフレームワーク
- **Powerlevel10k** テーマによる美しいプロンプト
- カスタムエイリアスと関数
- PATH最適化

### 開発ツール
- **Git** 設定（便利なエイリアス付き）
- **GitHub CLI** リポジトリ管理
- **Node.js** 開発環境
- **Claude Code** AI搭載コーディングアシスタント

### コマンドラインユーティリティ
- `tree` - ディレクトリ構造の可視化
- `jq` - JSON処理ツール
- `fzf` - ファジーファインダー
- `bat` - シンタックスハイライト付きcat
- `zoxide` - スマートなcd代替ツール
- `lazygit` - Git用ターミナルUI
- `htop` - 改良されたプロセスビューア
- `navi` - インタラクティブなチートシート
- `wget` - ファイルダウンローダー

### アプリケーション
- **Firefox Developer Edition** - Web開発用ブラウザ
- **VS Code** - メインコードエディタ

## 🛠 手動設定が必要な項目

インストールスクリプト実行後に手動で設定が必要な項目：

### SSH鍵の設定
```bash
# 新しいSSH鍵を生成
ssh-keygen -t ed25519 -C "your.email@example.com"

# GitHubに追加
cat ~/.ssh/id_ed25519.pub
# GitHubの Settings → SSH Keys にコピー&ペースト
```

### Git設定
```bash
# 個人情報を更新
git config --global user.name "あなたの名前"
git config --global user.email "your.email@example.com"
```

### Powerlevel10kテーマ設定
```bash
# 設定ウィザードを実行
p10k configure
```

### Claude Code認証
```bash
# Claude Codeを起動して認証プロンプトに従う
claude
```

## 📁 リポジトリ構造

```
dotfiles/
├── install.sh              # メインセットアップスクリプト
├── Brewfile                # Homebrewパッケージ一覧
├── .zshrc                  # Zsh設定
├── .gitconfig              # Git設定
├── .gitignore_global       # グローバルgitignore
├── .p10k.zsh              # Powerlevel10k設定
├── vscode/                 # VS Code設定
│   ├── settings.json
│   ├── keybindings.json
│   └── extensions.txt
├── scripts/                # 追加セットアップスクリプト
│   ├── macos-defaults.sh   # macOSシステム設定
│   └── npm-packages.sh     # グローバルnpmパッケージ
└── README.md              # このファイル
```

## 🔧 カスタマイズ

### 新しいパッケージの追加
```bash
# 新しいパッケージをインストール
brew install パッケージ名

# Brewfileを更新
cd ~/dotfiles
brew bundle dump --force --file=./Brewfile
git add Brewfile
git commit -m "Brewfileにパッケージ名を追加"
git push
```

### 設定の更新
```bash
# dotfilesを修正した後
cd ~/dotfiles
cp ~/.zshrc .
cp ~/.gitconfig .
git add .
git commit -m "設定を更新"
git push
```

## 🔄 複数マシン間での同期

### 現在の設定をエクスポート
```bash
cd ~/dotfiles
./scripts/export-settings.sh
```

### 新しいマシンでインポート
```bash
cd ~/dotfiles
git pull
./install.sh
```

## ⚡ 便利なエイリアス

`.zshrc`に含まれるエイリアス：

```bash
# Gitショートカット
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias gb="git branch"

# ディレクトリナビゲーション
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias ..="cd .."
alias ...="cd ../.."

# 開発
alias code="code ."
alias serve="python3 -m http.server 8000"
alias reload="exec zsh"

# システム
alias update="brew update && brew upgrade"
alias cleanup="brew cleanup && npm cache clean --force"
```

## 🎨 ターミナルテーマ

**Powerlevel10k**を使用した機能：
- Git状態インジケーター
- Node.jsバージョン表示
- 長時間実行コマンドの実行時間表示
- カスタムプロンプトセグメント
- ディレクトリパスの省略表示

## 📱 macOSシステム設定

`scripts/macos-defaults.sh`で自動化される設定：

- Dockの自動非表示とサイズ調整
- Finderのパスバーとステータスバー表示
- 高速キーリピート設定
- スクリーンショット保存場所設定
- ホットコーナー設定

## 🚨 トラブルシューティング

### 権限の問題
```bash
# npm権限を修正
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
```

### Homebrewの問題
```bash
# Homebrewを再インストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Zshがデフォルトシェルでない場合
```bash
# zshをデフォルトシェルに設定
chsh -s $(which zsh)
```

## 🤝 コントリビューション

このリポジトリをフォークして、ご自身のニーズに合わせてカスタマイズしてください。改善提案がある場合は、イシューを作成するかプルリクエストを送信してください。

## 📄 ライセンス

このプロジェクトはオープンソースで、[MIT License](LICENSE)の下で利用可能です。

## 🙏 謝辞

- [Oh My Zsh](https://ohmyz.sh/) - Zshフレームワーク
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zshテーマ
- [Homebrew](https://brew.sh/) - macOS用パッケージマネージャー
- [GitHub Dotfiles](https://dotfiles.github.io/) - インスピレーションとベストプラクティス

---

**最終更新:** $(date +'%Y年%m月%d日')  
**対応環境:** macOS 11+ (Big Sur以降)