FROM mongo:4.2.7-bionic
MAINTAINER zcw
ENV TZ=Asia/Shanghai

ADD run.sh /root/
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget tar vim; \

    # install font
    apt-get install -y xvfb libXrender* libfontconfig*; \
    apt-get install -y \
        fonts-arphic-bkai00mp \
        fonts-arphic-bsmi00lp \
        fonts-arphic-gbsn00lp \
        fonts-arphic-gkai00mp \
        fonts-arphic-ukai \
        fonts-arphic-uming \
        ttf-wqy-zenhei \
        ttf-wqy-microhei \
        xfonts-wqy; \
    rm -rf /var/lib/apt/lists/*; \

    # download wkhtmltopdf
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz; \
    tar -xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz; \
    cp wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf; \
    chmod +x /usr/local/bin/wkhtmltopdf; \
    rm -rf wkhtmltox wkhtmltox-0.12.4_linux-generic-amd64.tar.xz ;\

    #download leanote
    wget https://static.axboy.cn/leanote/leanote-linux-amd64-v2.6.1.bin.tar.gz -O /root/leanote.tar.gz; \
    tar -xzf /root/leanote.tar.gz -C /root/ ;\
    rm -f /root/leanote.tar.gz ;\
    chmod a+x /root/run.sh ;\
    chmod a+x /root/leanote/bin/run.sh ;\
    echo 'export QT_QPA_PLATFORM=offscreen' >> ~/.bashrc ;\
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime ;\
    echo $TZ > /etc/timezone

EXPOSE 9000 27017
# CMD ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && /bin/bash /root/run.sh
CMD /bin/bash /root/run.sh
