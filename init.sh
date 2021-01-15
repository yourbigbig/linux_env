#!/bin/bash
sudo apt-get install vim
sudo cp .vimrc /etc/.vimrc
sudo cp .vimrc ~/.vimrc

sudo apt-get install openssh-server

git config --global user.email "DreamYangjw@outlook.com"
git config --global user.name "yangjunwei"

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.lggeturl "config --get remote.origin.url"
git config --global alias.lgm "commit -m"
ssh-keygen -t rsa -C "DreamYangjw@outlook.com"