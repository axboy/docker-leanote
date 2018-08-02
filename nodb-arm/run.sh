#!/bin/bash

# Copy tar data to `/data/` path
cp -n -r /root/leanote /data/

echo `date "+%Y-%m-%d %H:%M:%S"`' >>>>>> start leanote service'
/data/leanote/bin/run.sh