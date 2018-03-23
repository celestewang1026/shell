#!/usr/bin/env bash 

source /etc/profile
#多线程抽取数据

today=$1

if [ $# == 0 ];then
        today=`date +%F`
fi
day=`date -d "1 days ago $today" +"%Y-%m-%d"`



begintime=$(date +%H%M%S)


all_num=1000
thread_num=10

#seq 1 ${all_num} | xargs -n 1 -I {} -P ${thread_num} sh -c "sleep 5;echo  "hello"_{}_"world"" >> /data/hadoop/wangyu/test/hello.txt
seq 1 ${all_num} | xargs -n 1 -I {} -P ${thread_num} sh -c "sleep 1;mongoexport -h 127.0.0.1:27017  -d mldn -c test_{} -f _id,title,description,likes,by  --csv |tail -n+2 |sed 's/ObjectID[(]\([0-9a-zA-Z-]\+\)[)]/\1/i' " >> /data/wang.yu/test/test.txt

lzop /data/wang.yu/test/test.txt

endtime=$(date +%H%M%S)
echo  "startTime:= $begintime"
echo  "endTime:= $endtime"

