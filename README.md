
https://github.com/bpking1/embyExternalUrl

docker版本

AUTO_UPDATE：重启自动更新，true/false，默认true

SERVER：服务端，emby/plex，默认emby

NGINX_PORT：nginx端口，默认8091

NGINX_SSL_PORT：nginx ssl端口，默认8095

容器内配置文件路径/opt/constant.js

docker-comppse.yml
```angular2html
version: '3'
services:
    medialinker:
        restart: always
        volumes:
            - '/volume1/docker/medialinker/constant.js:/opt/constant.js'
        environment:
            - AUTO_UPDATE=false
            - SERVER=emby
            - NGINX_PORT=8091
            - NGINX_SSL_PORT=8095

        container_name: medialinker
        image: 'thsrite/medialinker:latest'
        network_mode: "host"
```

