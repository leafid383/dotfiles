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
| `zsh/` | Zsh + Oh My Zsh 設定 |
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
- **ターミナル**: xterm-256color（TrueColor対応、terminal-overridesで`:Tc`指定）
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

### 1. 必要なツールのインストール

```bash
brew install stow tmux
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

## インストール一覧

`install.sh`が自動でインストールするもの。

### CLIツール（Brewfile）

| パッケージ | 説明 |
|-----------|------|
| `stow` | dotfiles管理（シンボリックリンク） |
| `bat` | catの代替（シンタックスハイライト） |
| `fzf` | ファジーファインダー |
| `gh` | GitHub CLI |
| `git` | バージョン管理 |
| `htop` | プロセスモニター |
| `jq` | JSONパーサー |
| `lazygit` | Git TUI |
| `navi` | コマンドチートシート |
| `neovim` | テキストエディタ |
| `node` | Node.js |
| `tmux` | ターミナルマルチプレクサ |
| `tree` | ディレクトリツリー表示 |
| `wget` | ファイルダウンロード |
| `zoxide` | スマートcd |

### アプリ（Brewfile cask）

| パッケージ | 説明 |
|-----------|------|
| `alfred` | ランチャー |
| `claude` | Claude Desktop |
| `clipy` | クリップボード管理 |
| `discord` | チャット |
| `firefox@developer-edition` | ブラウザ（開発者版） |
| `google-chrome` | ブラウザ |
| `karabiner-elements` | キーリマッパー |
| `notion` | ノート |
| `obsidian` | ナレッジベース |
| `slack` | チャット |
| `visual-studio-code` | エディタ |
| `zoom` | ビデオ会議 |

### 個別インストール確認（install.sh）

Brewfileとは別に、dotfilesが直接設定するツールを個別に確認・インストール。

| ツール | 対応dotfile |
|--------|------------|
| `neovim` | `.zshrc`のalias `v` |
| `tmux` | `.tmux.conf` |
| `ghostty` | `.config/ghostty/config` |
| `git` | `.gitconfig` |

Brewfileでの更新方法：

```bash
brew bundle dump --force --file=~/Private/dotfiles/Brewfile
```

## 設定ファイル一覧

stowで`$HOME`にシンボリックリンクされる設定ファイル。

| ファイル | リンク先 | 説明 |
|---------|---------|------|
| `zsh/.zshrc` | `~/.zshrc` | Zsh設定、エイリアス、プロンプト |
| `git/.gitconfig` | `~/.gitconfig` | Git設定（エディタ、ブランチ、push方式） |
| `git/.gitignore_global` | `~/.gitignore_global` | グローバルgitignore |
| `tmux/.tmux.conf` | `~/.tmux.conf` | tmux設定、テーマ、キーバインド |
| `ghostty/.config/ghostty/config` | `~/.config/ghostty/config` | Ghostty設定（フォント、テーマ、ウィンドウ） |
| `ghostty/.config/ghostty/tmux.sh` | `~/.config/ghostty/tmux.sh` | tmux自動起動スクリプト |
| `ghostty/.config/ghostty/vscode-layout.sh` | `~/.config/ghostty/vscode-layout.sh` | VSCode風レイアウトスクリプト |

## トラブルシューティング

### Ghosttyでoh-my-zshの読み込みに失敗する

**症状**: Ghostty起動時に以下のエラーが表示され、プロンプトが壊れる。

```
.zshrc:source:5: no such file or directory: /Users/xxx/.oh-my-zsh/oh-my-zsh.sh
$fg[green]→$reset_color $(custom_prompt):
```

**原因**: `.tmux.conf`の`default-terminal`に`xterm-ghostty`を指定しているが、terminfoがシステムにインストールされていない。tmux内のシェル起動時にterminfo解決が失敗し、oh-my-zshの`source`がエラーになる。

**解決方法**: `.tmux.conf`のターミナル設定を変更する。

```diff
- set -g default-terminal "xterm-ghostty"
- set -ag terminal-overrides ",xterm-ghostty:Tc"
+ set -g default-terminal "xterm-256color"
+ set -ag terminal-overrides ",xterm-256color:Tc"
```

変更後、`tmux kill-server`でtmuxを終了してGhosttyを再起動する。

> **補足**: `xterm-ghostty`のterminfoをインストールすれば`xterm-ghostty`も使用可能だが、`xterm-256color` + `:Tc`overrideで同等のTrueColor対応が得られるため、互換性の高いこちらを推奨。

## 手動設定が必要な項目

- SSH鍵の設定・GitHub登録
- `git config --global user.name / user.email`
- `claude`（Claude Code認証）
