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

cd go-cqhttp
wget -O "go-cqhttp.tar.gz" "https://github.com/Mrs4s/go-cqhttp/releases/download/v0.9.22/go-cqhttp-v0.9.22-linux-amd64.tar.gz"
tar -xzf go-cqhttp.tar.gz
chmod +x go-cqhttp
cd ..
git clone https://github.com/pcrbot/yobot.git

token=`openssl rand -hex 16`
echo generate token : $token
cp go-cqhttp/config_template.json go-cqhttp/config.json
sed -i 's/\("uin":\).*/\1\ '"$qq"',/' go-cqhttp/config.json
sed -i 's/\("password":\).*/\1\ "'"$password"'",/' go-cqhttp/config.json
sed -i 's/\("access_token":\).*/\1\ "'"$token"'",/' go-cqhttp/config.json
sed -i 's/\("access_token":\).*/\1\ "'"$token"'",/' yobot/src/client/packedfiles/default_config.json
if [ -f "$file" ]; then
  sed -i 's/\("access_token":\).*/\1\ "'"$token"'",/' yobot/src/client/yobot_data/yobot_config.json
fi

sudo docker-compose up -d
