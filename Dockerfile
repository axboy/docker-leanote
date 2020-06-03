FROM mongo:4.2.7-bionic
MAINTAINER zcw
ENV TZ=Asia/Shanghai

ADD run.sh /root/
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget tar vim; \
    apt-get install -y wkhtmltopdf xvfb; \
    rm -rf /var/lib/apt/lists/*; \
    wget https://static.axboy.cn/leanote/leanote-linux-amd64-v2.6.1.bin.tar.gz -O /root/leanote.tar.gz; \
    tar -xzf /root/leanote.tar.gz -C /root/ ;\
    rm -f /root/leanote.tar.gz ;\
    chmod a+x /root/run.sh ;\
    chmod a+x /root/leanote/bin/run.sh ;\
    echo 'export QT_QPA_PLATFORM=offscreen' >> ~/.bashrc ;\
	cp /usr/bin/wkhtmltopdf /usr/local/bin/ ;\
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime ;\
    echo $TZ > /etc/timezone

EXPOSE 9000
# CMD ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && /bin/bash /root/run.sh
CMD /bin/bash /root/run.sh