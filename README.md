原作者仓库：https://github.com/chen3861229/embyExternalUrl 

本项目为大佬项目的docker版本，旨在简化部署方式、方便更新。

### 可选参数

AUTO_UPDATE：重启自动更新，true/false，默认true

SERVER：服务端，emby/plex，默认emby

NGINX_PORT：nginx端口，默认8091

NGINX_SSL_PORT：nginx ssl端口，默认8095

REPO_URL：仓库地址，默认`https://github.com/chen3861229/embyExternalUrl`

SSL：是否开启ssl，true/false，默认false

SSL_CRON：ssl证书更新时间，默认每2小时执行一次

DOMAIN：域名，开启SSL的时候必填

#### ssl证书容器内路径

/opt/fullchain.pem

/opt/privkey.key

#### ssl申请命令路径

/opt/ssl

### 必填参数

容器内配置文件路径/opt/constant.js

### 部署方式

[docker-compose.yml](deploy/docker-compose.yml)

[unraid模版](deploy/my-MediaLinker.xml)
