# yobot_docker
本项目为[yobot](https://github.com/pcrbot/yobot) 的docker-compose一键部署模板, 使用[go-cqhttp](https://github.com/Mrs4s/go-cqhttp) 作为宿主。

# 部署方法

1. 前往 https://github.com/Mrs4s/go-cqhttp/releases 下载对应版本go-cqhttp，解压后将go-cqhttp可执行文件放置到本项目的go-cqhttp文件夹中
2. 在本项目根目录下 `git clone https://github.com/pcrbot/yobot.git`
3. 修改./go-cqhttp/config.json中对应qq号和密码，并且配置好Yobot
4. sudo docker-compose up -d
5. sudo docker attach 生成的实例名, 输入验证码并完成登录验证
