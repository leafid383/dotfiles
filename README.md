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
