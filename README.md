# docker-vsftpd

## will create a user: test passwd: test

### docker build -t "xd/vsftpd" .

### docker run -d -p 20-21:20-21/tcp -p 30000-30009:30000-30009/tcp -v /var/tmp:/data --name vsftpd xd/vsftpd
