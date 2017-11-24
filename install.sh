#!/bin/bash

dotfiles="$HOME/dotfiles"

# Install apt packages
echo "********************"
echo "Installing aptitude packages"
echo "********************"
sudo apt-get install python python-pip build-essential htop tmux liblua5.1-dev luajit libluajit-5.1 python-dev zsh

gem install tmuxinator

# Install pip packages
echo "********************"
echo "Installing pip packages"
echo "********************"
pip install powerline-status --user


# Install and compile vim
if [[ ! -f "/usr/local/bin/vim" ]]
then
    echo "********************"
    echo "Compiling vim..."
    echo "********************"
    sudo mkdir /usr/include/lua5.1/include
    sudo mv /usr/include/lua5.1/*.h /usr/include/lua5.1/include/

    cd /tmp
    git clone https://github.com/b4winckler/vim.git
    cd vim/src
    make distclean
    ./configure --with-features=huge --enable-pythoninterp --enable-rubyinterp --enable-luainterp --with-luajit --with-lua-prefix=/usr/include/lua5.1 --with-python-config-dir=/usr/lib/python2.7/config
    make
    sudo make install
else
    echo "********************"
    echo "VIM already installed"
    echo "********************"
fi

# Setup vim
echo "********************"
echo "Checking VIM config"
echo "********************"
target="${HOME}/.vim"
source="${HOME}/dotfiles/vim"
if [[ "$(readlink -- "$target")" != $source ]]
then
    echo "********************"
    echo "Creating VIM symlink..."
    echo "********************"
    sudo ln -s $source $target
else
    echo "********************"
    echo "VIM config already installed"
    echo "********************"
fi

echo "********************"
echo "Checking if submodules need an update"
echo "********************"
git submodule update --recursive --init



# Setup ZSH

if [[ "$(readlink -- "$HOME/.zshrc")" != "$dotfiles/zsh/.zshrc" ]]
then
    echo "********************"
    echo "Creating zshrc symlink..."
    echo "********************"
    sudo ln -s $dotfiles/zsh/.zshrc $HOME/.zshrc
else
    echo "********************"
    echo "zshrc config already installed"
    echo "********************"
fi

if [[ "$(readlink -- "$HOME/.zlogin")" != "$dotfiles/zsh/.zlogin" ]]
then
    echo "********************"
    echo "Creating zshlogin symlink..."
    echo "********************"
    sudo ln -s $dotfiles/zsh/.zlogin $HOME/.zlogin
else
    echo "********************"
    echo "zlogin config already installed"
    echo "********************"
fi

# Setup tmux config

if [[ "$(readlink -- "$HOME/.tmux.conf")" != "$dotfiles/tmux/.tmux.conf" ]]
then
    echo "********************"
    echo "Creating tmux.conf symlink..."
    echo "********************"
    sudo ln -s $dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
else
    echo "********************"
    echo "tmux.conf config already installed"
    echo "********************"
fi

if [[ "$(readlink -- "$HOME/.tmux-colors.conf")" != "$dotfiles/tmux/.tmux-colors.conf" ]]
then
    echo "********************"
    echo "Creating tmux-colors.conf symlink..."
    echo "********************"
    sudo ln -s $dotfiles/tmux/.tmux-colors.conf $HOME/.tmux-colors.conf
else
    echo "********************"
    echo "tmux-colors.conf config already installed"
    echo "********************"
fi

if [[ "$(readlink -- "$HOME/.tmuxinator")" != "$dotfiles/tmuxinator" ]]
then
    echo "********************"
    echo "Creating tmuxinator symlink..."
    echo "********************"
    sudo ln -s $dotfiles/tmuxinator $HOME/.tmuxinator
else
    echo "********************"
    echo "tmuxinator config already installed"
    echo "********************"
fi

# Setup powerline

if [[ "$(readlink -- "$HOME/.config/powerline")" != "$dotfiles/powerline" ]]
then
    echo "********************"
    echo "Creating powerline symlink..."
    echo "********************"
    if [[ ! -d "$HOME/.config" ]]
    then
        mkdir $HOME/.config
    fi
    sudo ln -s $dotfiles/powerline $HOME/.config/powerline
else
    echo "********************"
    echo "powerline config already installed"
    echo "********************"
fi
