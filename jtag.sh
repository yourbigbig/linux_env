JtagPath=/home/xaob/AIOT/C-Sky_DebugServer
mnull=""
if [ $# == 1 -a '$1'=='-f' ];then
    echo 关闭jtag...
        stat=`ps -a |grep DebugServeri*|awk '{print $1}'`
        nl=""
        if [ ${stat}x == ${mnull}x ]
        then
            echo 没有jtag进程运行
        else
            echo 已终止jtag
            sudo  kill  `ps -a |grep DebugServeri*|awk '{print $1}'`
        fi
    echo 关闭gdb...
        mpid=`lsof -i :1025|awk 'NR==2 {print $2}'`
        if [ ${mpid}X==${mnull}X ];then
            echo 没有运行的gdb
        else
            echo 已终止gdb
            kill ${mpid}
        fi  
fi
if [ -e ${JtagPath} ];then
    cd $JtagPath
    sudo  ./DebugServerConsole.elf -setclk 6
else
    echo -**************************error***************************
    echo -   请在$0第一行配置您的jtag地址
    echo
fi