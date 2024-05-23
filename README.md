
https://github.com/bpking1/embyExternalUrl docker版本

### 可选参数

AUTO_UPDATE：重启自动更新，true/false，默认true

SERVER：服务端，emby/plex，默认emby

NGINX_PORT：nginx端口，默认8091

NGINX_SSL_PORT：nginx ssl端口，默认8095

REPO_URL：仓库地址，默认`https://github.com/bpking1/embyExternalUrl.git`

### 必填参数

容器内配置文件路径/opt/constant.js

### 部署方式

[docker-compose.yml](deploy/docker-compose.yml)

[unraid模版](deploy/my-MediaLinker.xml)
