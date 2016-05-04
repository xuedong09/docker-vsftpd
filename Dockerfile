FROM ubuntu:14.04
MAINTAINER Docker xd <xdsnakex@gmail.com>

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV DEBIAN_FRONTEND noninteractive

#not work Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.
#RUN echo '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d

RUN useradd -s /sbin/nologin -d /var/ftp/test test
RUN echo "test:test" | chpasswd

#RUN mkdir -p /var/ftp/{test,anon}/pub \
RUN mkdir -p /var/ftp/test/pub \
            /var/run/vsftpd/empty \
            /etc/vsftpd && \
    chown test /var/ftp/test/pub 

RUN touch /etc/init.d/vsftpd \
        /etc/vsftpd/user_list \
        /etc/vsftpd/chroot_list \
        /etc/vsftpd/welcome.txt && \
    echo welcome xxx! > /etc/vsftpd/welcome.txt && \
    echo /sbin/nologin >> /etc/shells && \
    echo $'test' > /etc/vsftpd/user_list


RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y --force-yes --fix-missing install \
#        python-dev \
#        curl \
#	    vim \
        python-pip \
        vsftpd && \
    apt-get clean


RUN pip install supervisor==3.2.3

COPY vsftpd.conf /etc/vsftpd.conf
COPY supervisord.conf /usr/local/etc/supervisord.conf
#COPY user_list /etc/vsftpd/user_list

#RUN cp /etc/ftpusers /etc/vsftpd/ftpusers
RUN echo "America/Los_Angeles" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

VOLUME ["/data"]
EXPOSE 21 20
EXPOSE 30000-30009

CMD ["supervisord"]
