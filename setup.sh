#!/bin/bash

#Variables
name="SETUP.SH"
programs="git htop zsh curl tig neovim"
dir=~/.dotfiles
olddir=~/.dotfiles_old
files="bashrc vimrc zshrc profile zprofile"
color='\033[0;33m' #yellow
nocolor='\033[0m' # No Color

info() {
    echo -e "$color[$name] $1!$nocolor"
}

backup_files () {
    info "Backing up old dotfiles"
    mkdir -p $olddir
    cd $dir
    for file in $files; do
       mv ~/.$file $olddir
    done
}

install_programs(){
   info "Installing programs"
   sudo apt update
   sudo apt install $programs
}

install_ohmyzsh (){
    info "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


install_dotfiles () {
    info "Installing dorfiles"
    for src in $(find -H "$dir" -maxdepth 2 -name '*.slink' -not -path '*.git*')
    do
      dst="$HOME/.$(basename "${src%.*}")"
      ln -sfv "$src" "$dst"
    done
}
#backup_files
install_programs
#install_ohmyzsh
install_dotfiles
