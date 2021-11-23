#!/bin/sh

DOT_DIR="$HOME/dotfiles"

# コマンドの存在を判定する関数
has() {
    type "$1" > /dev/null 2>&1
}

# brew がインストールされていなければインストール
if [ -z "$(command -v brew)" ]; then
    echo "--- Installing Homebrew ---"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "--- Successfully installed Homebrew ---"
fi

# dotfilesを取得
if [ ! -d ${DOT_DIR} ]; then
    if [ ! has "git" ]; then
        brew install git
    fi
    echo "--- Fetching dotfiles... ---"
    git clone https://github.com/46goh/dotfiles.git ${DOT_DIR}
    echo "--- Successfully fetched dotfiles! ---"
fi

cd ~/dotfiles
brew bundle

echo "--- Linking dotfiles... ---"
stow fish git tmux vim
echo "--- Successfully linked dotfiles! ---"

echo "--- Setting fisher... ---"
fish -c "curl -sL git.io/fisher | source && fisher update"
echo "--- Successfully Set fisher! ---"

