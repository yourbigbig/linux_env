#!/bin/bash
version=1.5
Email=DreamYangJW@outlook.com
github=//github.com/yourbigbig/linux_env
################################  your config   ##################################
NAME="yourname"
EMAIL="your email"

################################# author  info ###################################
echo -**********************************
echo -Email:${Email}
echo -https:${github}
echo -version:${version}
echo -***********************************
#################################   functions   ###################################
aliasPATH=~/.alias
rm ${aliasPATH}
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



set_alias_to_config()
{
    if [ "$3" == "file" ];then
        current_path=`pwd`/
    else
        current_path=""
    fi
    echo Remove $1 ...
    sudo sed -i "/$1/d" ~/.bashrc
    sudo sed -i "/$1/d" ~/.profile
    sudo sed -i "/$1/d" /etc/profile
    sudo sed -i "/$1/d" /etc/bash.bashrc
    if [ $# == 3 ];then
        if [ "$3" == "file" ];then
            if [ ! -f $2 ];then
            return 0
            fi
        fi
    echo config $1 ...
    echo $1 >>  ${aliasPATH}
    sudo echo alias $1=${current_path}$2>>~/.bashrc
    sudo echo alias $1=${current_path}$2>>~/.profile
    sudo echo alias $1=${current_path}$2>>/etc/profile
    sudo echo alias $1=${current_path}$2>>/etc/bash.bashrc
    fi
}
################################## config sources  ################################
if [ ! -f /etc/apt/sources.list_bak ];then
sudo cp /etc/apt/sources.list /etc/apt/sources.list_bak
sudo cp ./sources.list_aliyun /etc/apt/sources.list
#sudo cp ./sources.list_aliyun /etc/apt/sources.list
fi
echo 更新数据源（apt-get update）
sudo apt-get update
###########################  checksoft is exsit and install #######################
checksoft_isrun ssh openssh-server
checksoft vim
checksoft gcc
checksoft minicom
checksoft git
checksoft cu
checksoft lsof
###############################   config .vimrc #####################################
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

################################## creat ssh-keygen #################################
if [ ! -f ~/.ssh/id_rsa ];then
ssh-keygen -t rsa -C ${EMAIL}
else
	echo ssh-keygen is already config.
fi

################################## config git alias ################################
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
git config --global alias.ck "checkout"
git config --global alias.seturl "remote set-url origin"
git config --global alias.addurl  "remote add origin"

################################## config env alias ################################

set_alias_to_config "jtag"  jtag.sh file $1
set_alias_to_config "uart"  uart_cu.sh file $1
set_alias_to_config "mk"  mkill.sh file $1


set_alias_to_config "cpolarall" "'nohup cpolar start-all -config=~/.cpolar/cpolar.yml -log=stdout &'" none $1
set_alias_to_config "sshkey" "'cat ~/.ssh/id_rsa.pub'" none $1
set_alias_to_config "ybb" "'echo -e \" -**********************************\n\
                            -Email:${Email}\n -https:${github}\n -version:${version}\n\
                            -**********************************\nsupport alias:\"&&cat ${aliasPATH}'" none $1
#################################     cpolar         ################################

 res=(`whereis cpolar`)
    # echo ${#res[*]}
    if  [ ${#res[*]}} == 1 ]; then
        MK_ARCH=`uname -m`

        if [ "x86_64"=="${MK_ARCH}" ];then
            echo ${MK_ARCH}
            wget https://www.cpolar.com/static/downloads/cpolar-stable-linux-amd64.zip
        elif  "armv7l"=="${MK_ARCH}"];then
            echo ${MK_ARCH}
            wget https://www.cpolar.com/static/downloads/cpolar-stable-linux-arm.zip
        else
            echo 未知平台，无法安装cpolar.
        fi

        if [ -f cpolar-stable-linux-amd64.zip -o -f cpolar-stable-linux-arm.zip ];then
            unzip cpolar-stable-linux-amd64.zip
            sudo mv cpolar /usr/local/bin
        fi
        echo cpolar installed.
    else
        echo cpolar is already installed.
    fi
   
##################################      end         ################################
echo Config Done.Thank you for using.