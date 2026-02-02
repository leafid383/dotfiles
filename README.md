# My Dotfiles

個人用のmacOS開発環境設定ファイル。GNU Stowによるシンボリックリンク管理。

## クイックセットアップ

```bash
git clone git@github.com:leafid383/dotfiles.git ~/Private/dotfiles
cd ~/Private/dotfiles
./install.sh
exec zsh
```

## パッケージ構成

[GNU Stow](https://www.gnu.org/software/stow/)でパッケージ単位に管理。

| パッケージ | 内容 |
|-----------|------|
| `zsh/` | Zsh + Oh My Zsh + Powerlevel10k 設定 |
| `git/` | Git設定、グローバルgitignore |
| `tmux/` | tmux設定（Ghostty連携、tokyonight風テーマ） |
| `ghostty/` | Ghosttyターミナル設定、tmux自動起動スクリプト |
| `zellij/` | Zellij設定、VSCode風レイアウト |

## ディレクトリ構造

```
dotfiles/
├── zsh/
│   └── .zshrc
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── tmux/
│   └── .tmux.conf
├── ghostty/
│   └── .config/ghostty/
│       ├── config
│       ├── tmux.sh
│       └── vscode-layout.sh
├── zellij/
│   └── .config/zellij/
│       ├── config.kdl
│       └── layouts/
│           └── vscode.kdl
├── Brewfile
├── install.sh
└── README.md
```

## 個別パッケージの適用

```bash
# 全パッケージ適用
stow -t ~ zsh git tmux ghostty zellij

# 特定パッケージのみ
stow -t ~ zsh

# ドライラン（確認のみ）
stow -n -v -t ~ zsh

# リンク解除
stow -D -t ~ zsh
```

## 既存環境への適用

既にdotfilesが実ファイルとして存在するマシンで、stow管理のシンボリックリンクに切り替える手順。

### 1. stowのインストール

```bash
brew install stow
```

### 2. リポジトリのクローン

```bash
git clone git@github.com:leafid383/dotfiles.git ~/Private/dotfiles
cd ~/Private/dotfiles
```

### 3. 既存ファイルのバックアップ

stowは既存の実ファイルがあるとエラーになるため、事前にバックアップする。

```bash
# ホームディレクトリ直下のファイル
for f in .zshrc .gitconfig .gitignore_global .tmux.conf; do
  [ -f ~/$f ] && mv ~/$f ~/$f.bak
done

# .config 配下のディレクトリ
for d in ghostty zellij; do
  [ -d ~/.config/$d ] && mv ~/.config/$d ~/.config/$d.bak
done
```

### 4. stowでシンボリックリンクを作成

```bash
stow -v -t ~ zsh git tmux ghostty zellij
```

### 5. 動作確認とバックアップの削除

新しいシェルを開いて設定が正しく反映されていることを確認後、バックアップを削除する。

```bash
exec zsh

# 問題なければバックアップを削除
rm -f ~/.zshrc.bak ~/.gitconfig.bak ~/.gitignore_global.bak ~/.tmux.conf.bak
rm -rf ~/.config/ghostty.bak ~/.config/zellij.bak
```

## Homebrewパッケージ

`Brewfile`で管理。追加・更新時：

```bash
brew bundle dump --force --file=~/Private/dotfiles/Brewfile
```

## 手動設定が必要な項目

- SSH鍵の設定・GitHub登録
- `git config --global user.name / user.email`
- `p10k configure`（Powerlevel10kテーマ）
- `claude`（Claude Code認証）
