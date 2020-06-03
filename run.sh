#!/bin/bash

mongod &

# 数据库未导入
if [ ! -f "/data/db/do_not_delete" ]; then
    echo "Initial mongo data"
    mongorestore -h localhost -d leanote --dir /root/leanote/mongodb_backup/leanote_install_data/
    echo "do not delete this file" >> /data/db/do_not_delete
    chmod 400 /data/db/do_not_delete
fi

# conf不存在
if [ ! -f '/data/leanote/conf/app.conf' ]; then
    mkdir -p /data/leanote/conf/
    cp /root/leanote/conf/app.conf /data/leanote/conf/app.conf

    echo "first run, replace secret"
    oldStr=`cat /data/leanote/conf/app.conf | grep 'app.secret'`
    newStr=app.secret=`cat /proc/sys/kernel/random/uuid`
    sed -i "s/${oldStr}/${newStr}/g" /data/leanote/conf/app.conf
fi

cp -n -r /root/leanote /data/
rm -rf /root/leanote/

echo `date "+%Y-%m-%d %H:%M:%S"`' >>>>>> start leanote service'
/data/leanote/bin/run.sh
