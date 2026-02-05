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

### zsh

- **テーマ**: robbyrussell（Oh My Zsh）
- **プラグイン**: git
- **エイリアス**: `gp`(git pull), `gs`(git switch), `gl`(git log --oneline --graph), `v`(nvim), `reload`(source ~/.zshrc)

### git

- **エディタ**: nvim
- **デフォルトブランチ**: main
- **push方式**: simple
- **グローバルgitignore**: macOS系ファイル(.DS_Store等)、エディタ設定(.vscode/, .idea/)、Node.js/Python関連の一時ファイル

### ghostty

- **フォント**: JetBrainsMono Nerd Font (14pt)
- **テーマ**: tokyonight
- **ウィンドウ**: 半透明背景(opacity 0.8)、ブラー有効、起動時最大化
- **tmux連携**: 起動時にtmuxを自動起動、Cmd+n/w/z/1-9やCmd+h/j/k/lでtmux操作をショートカット

### tmux

- **プレフィックス**: Ctrl+B
- **ターミナル**: xterm-ghostty（TrueColor対応）
- **操作**: マウス有効、viモードコピー（y→pbcopy）、vim風ペイン移動(h/j/k/l)
- **外観**: tokyonight風テーマ、ステータスバー上部表示
- **その他**: Claude Code向けパススルー有効、VSCode風レイアウト（Prefix+V）

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
├── Brewfile
├── install.sh
└── README.md
```

## 個別パッケージの適用

```bash
# 全パッケージ適用
stow -t ~ zsh git tmux ghostty

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
[ -d ~/.config/ghostty ] && mv ~/.config/ghostty ~/.config/ghostty.bak
```

### 4. stowでシンボリックリンクを作成

```bash
stow -v -t ~ zsh git tmux ghostty
```

### 5. 動作確認とバックアップの削除

新しいシェルを開いて設定が正しく反映されていることを確認後、バックアップを削除する。

```bash
exec zsh

# 問題なければバックアップを削除
rm -f ~/.zshrc.bak ~/.gitconfig.bak ~/.gitignore_global.bak ~/.tmux.conf.bak
rm -rf ~/.config/ghostty.bak
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
