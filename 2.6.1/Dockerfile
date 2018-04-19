FROM mongo:3.2
MAINTAINER zcw

ADD leanote-linux-amd64-v2.6.1.bin.tar.gz /root/leanote
#wget https://jaist.dl.sourceforge.net/project/leanote-bin/2.6.1/leanote-linux-amd64-v2.6.1.bin.tar.gz -O /root/leanote.tar.gz
ADD run.sh /root/
RUN chmod a+x /root/run.sh && chmod a+x /root/leanote/leanote/bin/run.sh
EXPOSE 9000
CMD /bin/bash /root/run.sh