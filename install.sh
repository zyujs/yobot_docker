#!/bin/bash
if [ $UID -eq 0 ];then
  echo "请勿使用root用户执行本脚本"
  exit
fi
echo -n "请输入botQQ号:"
read qq
if [ ! -n "$qq" ]; then
  echo "QQ号不能为空"
  exit
fi
echo -n "请输入botQQ密码:"
read password
if [ ! -n "$password" ]; then
  echo "密码不能为空"
  exit
fi

if [ ! -f "go-cqhttp/go-cqhttp" ]; then
  cd go-cqhttp
  wget -O "go-cqhttp.tar.gz" "https://hub.fastgit.org/Mrs4s/go-cqhttp/releases/download/v0.9.22/go-cqhttp-v0.9.22-linux-amd64.tar.gz"
  tar -xzf go-cqhttp.tar.gz
  chmod +x go-cqhttp
  cd ..
fi
git clone https://github.com/pcrbot/yobot.git

token=`openssl rand -hex 16`
echo generate token : $token
if [ ! -f "go-cqhttp/config.json" ]; then
  cp go-cqhttp/config_template.json go-cqhttp/config.json
fi
sed -i 's/\("uin":\).*/\1\ '"$qq"',/' go-cqhttp/config.json
sed -i 's/\("password":\).*/\1\ "'"$password"'",/' go-cqhttp/config.json
sed -i 's/\("access_token":\).*/\1\ "'"$token"'",/' go-cqhttp/config.json
sed -i 's/\("access_token":\).*/\1\ "'"$token"'",/' yobot/src/client/packedfiles/default_config.json
if [ -f "yobot/src/client/yobot_data/yobot_config.json" ]; then
  sed -i 's/\("access_token":\).*/\1\ "'"$token"'",/' yobot/src/client/yobot_data/yobot_config.json
fi

echo "PUID=$UID" > .env

sudo docker-compose up -d
