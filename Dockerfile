FROM mongo:3.2
MAINTAINER zcw
ENV TZ=Asia/Shanghai

ADD run.sh /root/
RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends wget tar; \
	rm -rf /var/lib/apt/lists/*; \
	wget https://static.axboy.cn/leanote/leanote-linux-amd64-v2.6.1.bin.tar.gz -O /root/leanote.tar.gz; \
	tar -xzf /root/leanote.tar.gz -C /root/ ;\
	rm -f /root/leanote.tar.gz ;\
	chmod a+x /root/run.sh ;\
	chmod a+x /root/leanote/bin/run.sh ;\
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime ;\
	echo $TZ > /etc/timezone
	
EXPOSE 9000
# CMD ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && /bin/bash /root/run.sh
CMD /bin/bash /root/run.sh