#!/bin/bash

# Folders
dirs=(~/.ssh
      ~/.config/autostart
      ~/.emacs.d/plugins
      ~/apps
      ~/dev
     )

# Apt-get apps
apt_apps=(emacs
          curl
          git
          tree
          python-pip
          python-dev
          wget
         )

# Other repositories, formatted as ssh-link, folder
repos=(
)

# Setting up folder structure
for dir in ${dirs[*]}
do
    if [ ! -d "$dir" ]; then
        mkdir -p $dir
        echo "Created $dir"
    fi
done


# Install apt apps
echo "Updating ubuntu ..."
sudo apt-get update

echo "Installing apps ..."
sudo apt-get install -y ${apt_apps[*]}

# Config files
if [ ! -d $HOME/dev/dotfiles ]; then
    echo "Cloning config files ..."
    git clone --recursive https://github.com/MathiasCiarlo/dotfiles.git ~/dev/dotfiles
fi

# Install other stuff
echo "Installing fuck ..."
wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0

# @
echo "Installing @ ..."
sudo pip install paramiko
git clone https://github.com/larstvei/at.git ~/apps/at

# Devilry mode
if [ ! -d $HOME/.emacs.d/plugins/devilry-mode ]; then
    echo "Installing Devilry mode ..."
    git clone https://github.com/MathiasCiarlo/devilry-mode.git ~/.emacs.d/plugins/devilry-mode
fi

# Symbolic links
symlinks=("$HOME/dev/dotfiles/emacs/.emacs $HOME/.emacs"
          "$HOME/dev/dotfiles/.bash_aliases $HOME/.bash_aliases"
          "$HOME/dev/dotfiles/.ssh/config $HOME/.ssh/config"
          "$HOME/dev/dotfiles/.config/autostart/gnome-terminal.desktop $HOME/.config/autostart/gnome-terminal.desktop"
         )

echo "Creating symbolic links ..."
for ((i = 0; i < ${#symlinks[*]}; i++))
do
    ln -fs ${symlinks[$i]}
    echo "Created symlink " ${symlinks[$i]}
done

# Load aliases
echo "Loading aliases"
. ~/dev/dotfiles/.bash_aliases
