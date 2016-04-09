# docker-vsftpd

## will create one user
    username: test  passwd: test
## build image
    docker build -t "xd/vsftpd" .
## run a container
    docker run -d -p 20-21:20-21/tcp -p 30000-30009:30000-30009/tcp -v /var/tmp:/data --name vsftpd xd/vsftpd
