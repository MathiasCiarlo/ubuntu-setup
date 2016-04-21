#!/bin/bash

# Folders
dirs=(~/.ssh
      ~/.config/autostart
      ~/.emacs.d/plugins
      ~/dev/dotfiles
      ~/kurs
     )

# Apt-get apps
apt_apps=(git
          emacs
          tree
          google-chrome-stable
          python-pip
          python-dev
         )

# Other repositories, formatted as ssh-link, folder
repos=(
)

# Symbolic links
symlinks=("~/dev/dotfiles/emacs/.emacs ~/.emacs"
          "~/dev/dotfiles/.bash_aliases ~/.bash_aliases"
          "~/dev/dotfiles/.ssh/config ~/.ssh/config"
          "~/dev/dotfiles/.config/autostart/gnome-terminal.desktop ~/.config/autostart/gnome-terminal.desktop"
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
apt-get update

echo "Installing apps ..."
apt-get install -y ${apt_apps[@]}

# Config files
echo "Cloning config files ..."
git clone git@github.com:MathiasCiarlo/dotfiles.git ~/dev/dotfiles

# Install other stuff
echo "Installing fuck ..."
wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0

# @
echo "Installing @ ..."
pip install paramiko

# Devilry mode
echo "Installing Devilry mode ..."
git clone git@github.com:MathiasCiarlo/devilry-mode.git ~/.emacs.d/plugins/devilry-mode

# Symbolic links
echo "Creating symbolic links ..."
for symlink in $symlinks
do
    ln -fs $symlink
done

source ~/.bashrc
