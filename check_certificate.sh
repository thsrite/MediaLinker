#!/bin/bash

# 申请证书、检查证书
check_certificate() {
  # 申请证书
  /bin/sh /opt/ssl

  # 检查证书是否被 Let's Encrypt 成功签发
  if ls /.lego/certificates | grep "${SSL_DOMAIN}"; then
      if [ -e /.lego/certificates/"${SSL_DOMAIN}".crt ] && [ -e /.lego/certificates/"${SSL_DOMAIN}".key ]; then
          echo 'The certificate has been successfully issued, and the service is being restarted.'
          # 删除原证书
          rm -rf /opt/fullchain.pem /opt/privkey.key
          # 将证书复制到特定目录
          cp /.lego/certificates/"${SSL_DOMAIN}".crt /opt/fullchain.pem
          cp /.lego/certificates/"${SSL_DOMAIN}".key /opt/privkey.key
          # 软连接证书到 nginx 配置目录
          mkdir -p /etc/nginx/conf.d/cert/
          ln -s /opt/fullchain.pem /etc/nginx/conf.d/cert/fullchain.pem
          ln -s /opt/privkey.key /etc/nginx/conf.d/cert/privkey.key

          # 判断nginx是否正在运行，如果正在运行重启 nginx
          if pgrep nginx >/dev/null; then
              echo "Nginx service is running, reloading..."
              nginx -s reload
              echo 'Nginx service reload success'
          fi
      else
          echo 'The certificate file does not exist, and the certificate issuance has failed.'
          exit 1
      fi
  else
      echo 'Certificate issuance failed.'
      exit 1
  fi
}

if [ "${SSL_ENABLE}" = "true" ]; then
  # 检查 /opt/ssl 文件是否存在
  if [ -e /opt/ssl ]; then

      # 检查证书和私钥文件是否存在
      if [ -e /opt/fullchain.pem ] && [ -e /opt/privkey.key ]; then
          # 获取当前日期和时间
          current_date=$(date +%s)
          # 提取证书的到期日期，并将其转换为 Unix 时间戳
          expiry_date=$(openssl x509 -enddate -noout -in /opt/fullchain.pem | cut -d= -f2 | awk '{sub(/ GMT/, ""); print}' | xargs -I {} date -d "{}" +%s)
          # 计算证书到期的天数
          days_until_expiry=$(( (expiry_date - current_date) / 86400 ))
          echo "Certificate expiry date: $days_until_expiry days from now."

          # 判断证书是否在 30 天内到期
          if [ $days_until_expiry -le 30 ]; then
              echo "The certificate will expire within 30 days, start certificate renewal."
              check_certificate
          else
              echo "The certificate is still valid, no need for renewal."
              # 判断nginx证书是否正确配置
              if [ ! -e /etc/nginx/conf.d/cert/fullchain.pem ] || [ ! -e /etc/nginx/conf.d/cert/privkey.key ]; then
                  # 软连接证书到 nginx 配置目录
                  mkdir -p /etc/nginx/conf.d/cert/
                  ln -s /opt/fullchain.pem /etc/nginx/conf.d/cert/fullchain.pem
                  ln -s /opt/privkey.key /etc/nginx/conf.d/cert/privkey.key
              fi
          fi
      else
          echo "Start applying for domain certificate."
          check_certificate
      fi
  else
      echo "SSL script does not exist."
      exit 1
  fi
else
    echo "SSL is not enabled.Skip certificate check."
fi

