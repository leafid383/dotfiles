#!/bin/bash

set -e

# カラーコード
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 dotfilesのセットアップを開始します...${NC}"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Homebrewがない場合はインストール
if ! command -v brew >/dev/null 2>&1; then
    echo -e "${YELLOW}🍺 Homebrewをインストール中...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # HomebrewをPATHに追加
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# パッケージをインストール
echo -e "${YELLOW}📦 Homebrewパッケージをインストール中...${NC}"
brew bundle --file=$DOTFILES_DIR/Brewfile || echo -e "${YELLOW}⚠️  一部のBrewfileパッケージが失敗しました（続行します）${NC}"

# 各ツールのインストール確認
echo -e "${YELLOW}🔍 ツールのインストール確認中...${NC}"

# neovim (.zshrcのaliasで使用)
if ! command -v nvim >/dev/null 2>&1; then
    echo -e "${YELLOW}  → neovimをインストール中...${NC}"
    brew install neovim
fi

# tmux (.tmux.conf)
if ! command -v tmux >/dev/null 2>&1; then
    echo -e "${YELLOW}  → tmuxをインストール中...${NC}"
    brew install tmux
fi

# ghostty (ghostty/config)
if ! command -v ghostty >/dev/null 2>&1; then
    echo -e "${YELLOW}  → ghosttyをインストール中...${NC}"
    brew install --cask ghostty
fi

# git (.gitconfig)
if ! command -v git >/dev/null 2>&1; then
    echo -e "${YELLOW}  → gitをインストール中...${NC}"
    brew install git
fi

# stowでシンボリックリンクを作成
echo -e "${YELLOW}📁 stowでシンボリックリンクを作成中...${NC}"
PACKAGES=(zsh git tmux ghostty)
for pkg in "${PACKAGES[@]}"; do
    echo -e "  → ${pkg}"
    stow -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

# Oh My Zshがない場合はインストール
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}🐚 Oh My Zshをインストール中...${NC}"
    RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo -e "${GREEN}✅ dotfilesのセットアップが完了しました！${NC}"
echo -e "${YELLOW}🔄 ターミナルを再起動するか、以下のコマンドを実行してください: exec zsh${NC}"
