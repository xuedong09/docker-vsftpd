FROM ubuntu:14.04
MAINTAINER Docker xd <xdsnakex@gmail.com>

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /var/ftp/{test,anon}/pub \
            /var/run/vsftpd/empty \
            /etc/vsftpd

RUN touch /etc/init.d/vsftpd \
        /etc/vsftpd/user_list \
        /etc/vsftpd/chroot_list \
        /etc/vsftpd/welcome.txt && \
    echo welcome xxx! > /etc/vsftpd/welcome.txt && \
    echo /sbin/nologin >> /etc/shells && \
    echo "test\nanonymous" > /etc/vsftpd/user_list


RUN useradd -s /sbin/nologin -d /var/ftp/test test
RUN echo "test:test" | chpasswd

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

VOLUME ["/var/ftp"]
EXPOSE 21 20
EXPOSE 30000-30009

CMD ["supervisord"]
