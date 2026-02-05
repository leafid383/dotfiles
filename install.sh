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
brew bundle --file=$DOTFILES_DIR/Brewfile

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

# Powerlevel10kがない場合はインストール
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo -e "${YELLOW}⚡ Powerlevel10kをインストール中...${NC}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

echo -e "${GREEN}✅ dotfilesのセットアップが完了しました！${NC}"
echo -e "${YELLOW}🔄 ターミナルを再起動するか、以下のコマンドを実行してください: exec zsh${NC}"
echo -e "${BLUE}💡 Powerlevel10kの設定を忘れずに: p10k configure${NC}"
