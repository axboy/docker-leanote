#!/bin/bash

mongod &

if [ ! -f "/data/db/do_not_delete" ]; then
	mongorestore -h localhost -d leanote --dir /root/leanote/leanote/mongodb_backup/leanote_install_data/
	echo "do not delete this file" >> /data/db/do_not_delete	# 用该文件来判断有没有导入过数据
	chmod 400 /data/db/do_not_delete
fi

cp -n -r /root/leanote/leanote /data/

echo `date "+%Y-%m-%d %H:%M:%d"`' >>>>>> start leanote service'
/data/leanote/bin/run.sh