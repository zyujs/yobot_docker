# yobot_docker
本项目为在Linux下使用docker-compose部署 [yobot](https://github.com/pcrbot/yobot) 的模板,使用 [go-cqhttp](https://github.com/Mrs4s/go-cqhttp) 作为宿主.

# 部署

1. 前往 https://github.com/Mrs4s/go-cqhttp/releases 下载对应版本go-cqhttp, 解压后将go-cqhttp可执行文件放置到本项目的go-cqhttp文件夹中
1. 在本项目根目录下 `git clone https://github.com/pcrbot/yobot.git`
1. 将./go-cqhttp/config_template.json复制为./go-cqhttp/config.json
1. 修改./go-cqhttp/config.json中对应qq号和密码，并且参照yobot文档进行相关配置, 如果提供外网web访问, 还需要设置 `access_token` 相关项目.
1. 使用 `id` 命令查看当前用户uid, 如果不是默认值1000, 请执行命令 `echo "PUID=$UID" > .env` 生成.env文件
1. 执行 `sudo docker-compose up -d` 开始构建
1. 构建完成后, 执行 `sudo docker attach 生成的实例名`, 进行第一次登录QQ的验证程序.

# 一键部署脚本

本项目为懒人和新手提供了自动部署脚本 `install.sh`, 不建议高级用户使用.

脚本依赖组件 `wget git docker openssl`, 请提前安装.

请使用**非root用户**执行 `./install.sh` , 然后根据提示输入qq号和密码.

部署完成后使用命令 `sudo docker logs 实例名` 查看日志, 如果提示需要输入验证码或前往网址验证,请使用命令 `sudo docker attach 实例名` 进入容器完成登录验证程序, 实例名在部署过程中有显示, 或者使用命令 `sudo docker ps` 查看.

由于脚本修改了 `yobot/src/client/packedfiles/default_config.json` 以写入access_token, 会影响yobot自动更新, 请在机器人功能验证无误后, 在yobot目录中执行命令 `git checkout -f src/client/packedfiles/default_config.json` 清除修改.

# 卸载
  在本项目根目录下执行命令 `sudo docker-compose down` 停止实例, 然后执行 `sudo docker rmi yobotdocker_bot` 删除生成的镜像文件