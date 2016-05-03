# docker-vsftpd

## This Dockerfile will create one user
    username: test  passwd: test

## Build image
    docker build -t "xd/vsftpd" .

## Run container
    docker run -d -p 20-21:20-21/tcp -p 30000-30009:30000-30009/tcp -v /var/tmp:/data --name vsftpd xd/vsftpd

## Add a alias command dps, use dps get the container's ip
    alias dps="docker ps -q | xargs docker inspect --format '{{ .Id }} - {{ .Name }} - {{ .NetworkSettings.IPAddress }}'"

## Use container-ip to login ftp, now enjoy it! @_@
