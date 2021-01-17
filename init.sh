#!/bin/bash

################################  your config   ##################################
NAME="yourname"
EMAIL="your email"

################################# author  info ###################################
echo -**********************************
echo -Email:DreamYangJW@outlook.com
echo -https://github.com/yourbigbig/linux_env
echo -version:1.4
echo -***********************************
#################################   functions   ###################################
checksoft()
{
    res=(`whereis $1`)
    # echo ${#res[*]}
    if  [ ${#res[*]}} == 1 ]; then
        sudo apt-get install $1
    else
        echo "$1 is already installed."
    fi  
}
checksoft_isrun()
{
    ret=`ps -e |grep $1`
    # echo $ret
    if  [ -z "$ret" ]; then
        sudo apt-get install $2
    else
        echo "$2 is already installed."
    fi  
}

###################################################################################
#sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp ./sources.list_aliyun /etc/apt/sources.list
#sudo cp ./sources.list_aliyun /etc/apt/sources.list
sudo apt-get update

###############################  checksoft is exsit ################################
checksoft_isrun ssh openssh-server
checksoft vim
checksoft gcc
checksoft minicom
checksoft git

####################################################################################
echo Config .vimrc.You can edit at ~/.vimrc and /etc/.vimrc.
if [ ! -f .vimrc ];then
	cp .vimrc_bak .vimrc
	echo config .vimrc.
	sed -i "s|Author:none|Author: ${NAME}|g" .vimrc
	sed -i "s|mail:none|mail: ${EMAIL}|g" .vimrc
	sudo cp .vimrc /etc/.vimrc
	sudo cp .vimrc ~/.vimrc
else
	echo .vimrc config is ok.
fi

#####################################################################################
if [ ! -f ~/.ssh/id_rsa ];then
ssh-keygen -t rsa -C ${EMAIL}
else
	echo ssh-keygen is already config.
fi

#####################################################################################
echo Config git alias.
git config --global user.email ${EMAIL}
git config --global user.name  ${NAME}
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.url "config --get remote.origin.url"
git config --global alias.ad "add ."
git config --global alias.lgm "commit -m"
git config --global alias.st "status"
git config --global alias.hr "--hard reset"
git config --global alias.sr "--soft reset"
git config --global alias.ck "checkout ."

echo Config Done.Thank you for using.

