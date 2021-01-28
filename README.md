# vimenv

该项目功能初始化ubuntu新系统

使用方法（加黑部分必须）

**git clone  https://github.com/yourbigbig/vimenv.git**

**cd vimenv**

vim init.sh

config your name 

config your email

**sudo ./init.sh**



**功能一 配置软件源为阿里源：**
    
**功能二 安装软件（可自定义软件）：**

提供checksoft_isrun checksoft两个函数自定义安装软件，软件环境一劳永逸

- checksoft_isrun ssh openssh-server

- checksoft vim

- checksoft gcc

- checksoft minicom

- checksoft git

- checksoft cu

- checksoft lsof


**功能三 配置vim**

提供上百行的配置，用户体验绝佳。

**功能四 生成ssh-keygen**

提供 sshkey 命令 快速查看公钥


**功能五 配置git alias**

**功能六 配置定义环境命令**

提供set_alias_to_config 函数自定义配置

set_alias_to_config "jtag"  jtag.sh file $1

set_alias_to_config "uart"  uart_cu.sh file $1

set_alias_to_config "mk"  mkill.sh file $1

set_alias_to_config "sshkey" "'cat ~/.ssh/id_rsa.pub'" none $1

**功能七 自定义功能--串口**

欢迎大家使用**uart**体验

**功能八 安装cpolar**

支持x86_x64和arm平台

并配有最简单的配置文件参考

