#########################################################################
# File Name: uart_minicom.sh
# Author: yourname
# mail: your email
# Descriptio: This is NULL
# Created Time: 2021-03-03
#########################################################################
#!/bin/bash
if [ -e /dev/ttyUSB* ] ;then
sudo chmod 777 /dev/ttyUSB*
fi
cu_stat=''
NAMEPATH=${0%/*}/.name$1
USERLOGPATH=${0%/*}/.userlog


minicftxt=.minirc.$1
if [ -e ~/${minicftxt} ];then
    echo  串口默认波特率:115200
else 
    cp ~/.minirc.dfl ~/${minicftxt}
    sed -i "s|USB0|USB$1|g"  ~/${minicftxt}
    echo 创建默认配置成功
fi


echo_info()
{
    cd /dev
    echo 当前主机连接的设备有：
    echo --------------------------
    if [ -e /dev/ttyUSB* ] ;then
        ls ttyUSB*
    else
        echo 同学，没有串口连接啦！
    fi
    echo --------------------------
    echo 
    echo 请使用uart [0-9]+$1串口 
    echo 例如：uart 0 $2 来$1串口0'('ttyUSB0')'
    echo 例如：uart 1 $2 来$1串口1'('ttyUSB1')'
    exit 0
}
cu_off() 
{
    
# cu_stat=(`ps -aux|grep  "cu -l /dev/ttyUSB$1 -s 115200"|awk '{print $2}'`)
# # kill  `ps -a |grep cu|awk '{print $1}'`
# if [ $# == 2  ];then
#     echo_info 释放 $2
# else
#     if [ ${#cu_stat[*]} == 1 ] 
#     then
#         echo 
#         echo UART$1未使用 无需释放
#         echo
#     else
#         # cu_stat=(`ps -aux|grep  "cu -l /dev/ttyUSB$1 -s 115200"|awk '{print $2}'`)
#         # kill ${cu_stat[0]}
#         # kill ${cu_stat[1]}
#         mk minicom
#         sleep 2
#         echo
#         echo UART$1释放成功
#         echo
#     fi  
# fi
mk minicom 
sleep 1
echo UART$1释放成功
}

def_stat=""
stat=n
name=""
killall()
{
        #     kill ${cu_stat[0]}
        #     kill ${cu_stat[1]}
        #     ret=(`ps -aux|grep  "cu -l /dev/ttyUSB$1 -s 115200"|awk '{print $2}'`)
        #     echo 杀除进程
        #     # while [ ${ret}x != ${def_stat}x ]
        # while [ ${#ret[*]} != 1 ]
        # do
        #     kill ${ret[0]}
        #     sleep 3
        #     ret=(`ps -aux|grep  "cu -l /dev/ttyUSB$1 -s 115200"|awk '{print $2}'`)
        # done
        #     #  if [ ${ret}x == ${def_stat}x ]
        # if [ ${#ret[*]} == 1 ]
        #     then
        #     echo 开始强占
        #     sleep 1
        #     echo ttyUSB0 115200 
        #     cu -l /dev/ttyUSB$1 -s 115200
        #     date >> ${USERLOGPATH}
        #     echo UART$1 ${name} release >> ${USERLOGPATH}
        #     echo >> ${USERLOGPATH}
        # else
        #     kill ${cu_stat[0]}
        #     kill ${cu_stat[1]}
        #     echo 开始强占...
        #     sleep 2
        #     echo ttyUSB0 115200 
        #     cu -l /dev/ttyUSB$1 -s 115200
        #     date >> ${USERLOGPATH}
        #     echo UART$1 ${name} release >> ${USERLOGPATH}
        #     echo >> ${USERLOGPATH}
        # fi

# echo -e '\033[31mI will close your connection!!!\033[0m' >/dev/pts/2
mini_stat=(`ps -aux|grep  "minicom"|awk '{print $2}'`)
for var in `seq 0 ${#mini_stat[*]}`
do
    if [ $((var+1)) == ${#mini_stat[*]} ];then
        break
    fi
	sudo    kill ${mini_stat[${var}]}
    echo success
done

sleep 4
echo UART$1释放成功
echo `ps -aux|grep  "sudo minicom $1"|awk '{print $2}'` > user.prv

sudo minicom $1
}

getusrname()
{

    if [ ! -e  ${NAMEPATH} ];then
    
        echo 无法定位使用者
    elif [ $# != 1 ];then
        OLD_NAME=`cat ${NAMEPATH}`
        echo 当前使用者: ${OLD_NAME}
    fi
    read -p "who are you:" name
    if [ ${name}X == ${def_stat}X ];then
        getusrname $1
    else
        # echo -${OLD_NAME}-
        # echo -${name}-
        # if [ ${name}X != ${OLD_NAME}X ];then
            echo -*********************************
            echo 释放串口请使用  CTRL+A +Q 
            echo -*********************************
            echo ${name} > ${NAMEPATH}
            date >> ${USERLOGPATH} 
            echo UART$1 ${name} >> ${USERLOGPATH} $2
        # fi
    fi
}
if [ $# == 0  ];then
    echo_info 启动
elif [ $# == 2 -a "$2"=="off"  ];then
    cu_off $1
    cu_off $1 'off'
    exit 0
else
    # cu_stat=(`ps -aux|grep  "cu -l /dev/ttyUSB$1 -s 115200"|awk '{print $2}'`) //sudo minicom 0
     cu_stat=(`ps -aux|grep  "sudo minicom $1"|awk '{print $2}'`)
fi

if [ ${#cu_stat[*]} == 1 ]
then

    if [ ! -e "/dev/ttyUSB$1" ]
    then
    echo -*****************
    echo UART$1串口未连接
    echo -*****************
    else
        getusrname $1
        echo UART$1连接中。。。
        # cu -l /dev/ttyUSB$1 -s 115200
        echo `ps -aux|grep  "sudo minicom $1"|awk '{print $2}'` > user.prv
        sudo minicom $1
        date >> ${USERLOGPATH}
        echo UART$1 ${name} release >> ${USERLOGPATH}
        echo >> ${USERLOGPATH}
    fi
else
    echo 申请UART$1
    echo ------------------注意--------------------
    read -p "UART$1被使用中，强占否(yes(y)/no(n)):" stat
     case $stat in
    y)
        getusrname $1 抢占使用
        killall $1
    ;;
    yes)
        getusrname $1 抢占使用
        killall $1
    ;;
        *)
        echo    放弃使用
        echo  已停止使用串口
    ;;
     esac
fi

