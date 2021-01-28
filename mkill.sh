if [ $# == 0 ];then
    echo 请输入需要kill的进程名称  
    echo eg: mk ssh
    exit 0
fi

cu_stat=(`ps -aux|grep  $1|awk '{print $2}'`)
for var in `seq 0 ${#cu_stat[*]}`
do
    if [ $((var+1)) == ${#cu_stat[*]} ];then
        exit 0
    fi
    kill ${cu_stat[${var}]}
    echo success
done