FROM alpine:3.12
MAINTAINER zcw
ENV TZ=Asia/Shanghai

RUN apk update && apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    mkdir /data/ && \
    wget http://static.axboy.cn/leanote/leanote-linux-amd64-v2.6.1.bin.tar.gz -O /root/leanote.tar.gz && \
    tar -xzf /root/leanote.tar.gz -C /data/ && \
    chmod a+x /data/leanote/bin/run.sh && \
    rm -f /root/leanote.tar.gz

EXPOSE 9000
CMD sh /data/leanote/bin/run.sh