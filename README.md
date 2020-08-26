# yobot_docker
本项目为在Linux下使用docker-compose部署 [yobot](https://github.com/pcrbot/yobot) 的模板,使用 [go-cqhttp](https://github.com/Mrs4s/go-cqhttp) 作为宿主.

# 部署方法

1. 前往 https://github.com/Mrs4s/go-cqhttp/releases 下载对应版本go-cqhttp, 解压后将go-cqhttp可执行文件放置到本项目的go-cqhttp文件夹中
2. 在本项目根目录下 `git clone https://github.com/pcrbot/yobot.git`
3. 修改./go-cqhttp/config.json中对应qq号和密码，并且参照yobot进行相关配置, 如果提供外网web访问, 还需要设置 `access_token` 相关项目.
4. 执行 `sudo docker-compose up -d` 开始构建
5. 构建完成后, 执行 `sudo docker attach 生成的实例名`, 进行第一次登录QQ的验证程序.

# 一键脚本

本项目为懒人和新手提供了自动部署脚本 `install.sh`, 不建议高级用户使用.

脚本依赖组件 `wget git docker openssl`, 请提前安装.

请使用**非root用户**执行 `./install.sh` , 然后根据提示输入qq号和密码.

部署完成后使用命令 `sudo docker logs 实例名` 查看日志, 如果提示需要输入验证码或前往网址验证,请使用命令 `sudo docker attach 实例名` 进入容器完成登录验证程序, 实例名在部署过程中有显示, 或者使用命令 `sudo docker ps` 查看.