#!/bin/bash
checksoft()
{
    res=(`whereis $1`)
    # echo ${#res[*]}
    if  [ ${#res[*]}} == 1 ]; then
        sudo apt-get install $1
    else
        echo "$1 is  installed"
    fi  
}
checksoft_isrun()
{
    ret=`ps -e |grep $1`
    # echo $ret
    if  [ -z "$ret" ]; then
        sudo apt-get install $2
    else
        echo "$2 is  installed"
    fi  
}


checksoft_isrun ssh openssh-server
checksoft vim


sudo cp .vimrc /etc/.vimrc
sudo cp .vimrc ~/.vimrc

if [ ! -f ~/.ssh/id_rsa ];then
ssh-keygen -t rsa -C "DreamYangjw@outlook.com"
fi



git config --global user.email "DreamYangjw@outlook.com"
git config --global user.name "yangjunwei"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.lggeturl "config --get remote.origin.url"
git config --global alias.ad "add ."
git config --global alias.lgm "commit -m"
git config --global alias.st "status"
git config --global alias.hr "--hard reset"
git config --global alias.sr "--soft reset"


echo Config done