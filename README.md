[![Github][Github-image]][Github-url]
[![commit activity][commit-activity-image]][commit-activity-url]
[![docker version][docker-version-image]][docker-version-url]
[![docker pulls][docker-pulls-image]][docker-pulls-url]
[![docker stars][docker-stars-image]][docker-stars-url]
[![docker image size][docker-image-size-image]][docker-image-size-url]

[Github-image]: https://img.shields.io/static/v1?label=Github&message=MediaLinker&color=brightgreen
[Github-url]: https://github.com/thsrite/MediaLinker
[commit-activity-image]: https://img.shields.io/github/commit-activity/m/thsrite/MediaLinker
[commit-activity-url]: https://github.com/thsrite/MediaLinker
[docker-version-image]: https://img.shields.io/docker/v/thsrite/medialinker?style=flat
[docker-version-url]: https://hub.docker.com/r/thsrite/medialinker/tags?page=1&ordering=last_updated
[docker-pulls-image]: https://img.shields.io/docker/pulls/thsrite/medialinker?style=flat
[docker-pulls-url]: https://hub.docker.com/r/thsrite/medialinker
[docker-stars-image]: https://img.shields.io/docker/stars/thsrite/medialinker?style=flat
[docker-stars-url]: https://hub.docker.com/r/thsrite/medialinker
[docker-image-size-image]: https://img.shields.io/docker/image-size/thsrite/medialinker?style=flat
[docker-image-size-url]: https://hub.docker.com/r/thsrite/medialinker

原作者仓库：https://github.com/chen3861229/embyExternalUrl 

本项目为大佬项目的docker版本，旨在简化部署方式、方便更新。

非容器运行问题请去原作者仓库提issue，请给原作者大佬点赞！

### 环境配置
| 参数            | 是否必填    | 说明                                                                                               |
|---------------|:--------|--------------------------------------------------------------------------------------------------|
| AUTO_UPDATE   | 可选      | 重启自动更新，true/false，默认`false`                                                                      |
| SERVER        | 可选      | 服务端，emby/plex，默认`emby`                                                                           |
| NGINX_PORT    | 可选      | nginx端口，默认`8091`                                                                                 |
| NGINX_SSL_PORT | 可选      | nginx ssl端口，默认`8095`                                                                             |
| REPO_URL      | 可选      | 仓库地址，默认`https://github.com/chen3861229/embyExternalUrl`                                          |
| SSL_ENABLE    | 可选      | 是否开启ssl，true/false，默认`false`                                                                     |
| SSL_CRON      | 可选      | ssl证书更新时间，默认每2小时执行一次                                                                             |
| SSL_DOMAIN    | 可选      | 域名，开启SSL的时候必填                                                                                    |
| 证书路径        | 开启SSL必填 | 映射到宿主机/opt/fullchain.pem                                                                         |
| 证书路径        | 开启SSL必填 | 映射到宿主机/opt/privkey.pem                                                                           |
| 证书申请命令     | 开启SSL必填 | 映射到宿主机/opt/ssl [ssl示例](config%2Fssl)                                                             |
| 配置文件        | `必填`    | 映射到宿主机/opt/constant.js [emby示例](config%2Femby%2Fconstant.js) [plex示例](config%2Fplex%2Fconstant.js) |

### 部署方式

#### docker部署
/home/MediaLinker/下创建证书文件、配置文件constant.js [emby示例](config%2Femby%2Fconstant.js) [plex示例](config%2Fplex%2Fconstant.js)

```
  docker run -d \
    --name MediaLinker \
    -p 8091:8091 \
    -v /home/MediaLinker/:/opt/ \
    thsrite/medialinker:latest
```

#### [docker-compose](deploy/docker-compose.yml)

#### [unraid模版](deploy/my-MediaLinker.xml)

### 注意事项

- 如开启自动更新，且本地访问github困难，可能会导致更新失败，建议配置`HTTPS_PROXY`环境变量
- 本容器日志会存储到/opt/MediaLinker.log，请注意日志大小，定期清理
- 应某火柴要求，docker分为三个tag：latest为整合版本，默认SERVER=emby可随时切换emby|plex；emby默认SERVER=emby；plex默认SERVER=plex