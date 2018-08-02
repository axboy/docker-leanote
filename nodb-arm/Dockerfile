FROM armv7/armhf-ubuntu:16.10
MAINTAINER zcw
ENV TZ=Asia/Shanghai

ADD run.sh /root/
ADD leanote-linux-arm-v2.6.1.bin.tar.gz /root/
RUN set -ex; \
    rm -rf /var/lib/apt/lists/*; \
    # apt-get update; \
    # apt-get install -y --no-install-recommends wget tar ca-certificates; \
    # wget https://static.axboy.cn/leanote/leanote-linux-arm-v2.6.1.bin.tar.gz -O /root/leanote.tar.gz; \
    # tar -xzf /root/leanote.tar.gz -C /root/ ;\
    chmod a+x /root/run.sh ;\
    chmod a+x /root/leanote/bin/run.sh ;\
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime ;\
    echo $TZ > /etc/timezone

EXPOSE 9000
CMD /bin/bash /root/run.sh