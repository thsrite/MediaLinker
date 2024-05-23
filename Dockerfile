FROM nginx:latest

# 环境变量
ENV LANG="C.UTF-8" \
    TZ="Asia/Shanghai" \
    NGINX_PORT="8091" \
    NGINX_SSL_PORT="8095" \
    REPO_URL="https://github.com/bpking1/embyExternalUrl.git" \
    AUTO_UPDATE="true" \
    SERVER="emby"

# 安装git
RUN apt-get update && apt-get install -y git

# 拉取代码
RUN git clone $REPO_URL /embyExternalUrl

COPY entrypoint /entrypoint

RUN chmod +x /entrypoint

ENTRYPOINT [ "/entrypoint" ]