# yobot_docker
本项目为在Linux下使用docker-compose部署 [yobot](https://github.com/pcrbot/yobot) 的模板,使用 [go-cqhttp](https://github.com/Mrs4s/go-cqhttp) 作为宿主.

# 部署

1. 前往 https://github.com/Mrs4s/go-cqhttp/releases 下载对应版本go-cqhttp, 解压后将go-cqhttp可执行文件放置到本项目的go-cqhttp文件夹中
1. 在本项目根目录下 `git clone https://github.com/pcrbot/yobot.git`
1. 将./go-cqhttp/config_template.json复制为./go-cqhttp/config.json
1. 修改./go-cqhttp/config.json中对应qq号和密码，并且参照yobot文档进行相关配置, 如果提供外网web访问, 还需要设置 `access_token` 相关项目.
1. 使用 `id` 命令查看当前用户uid, 如果不是默认值1000, 请执行命令 `echo "PUID=$UID" > .env` 生成.env文件
1. 执行 `sudo docker-compose up -d` 开始构建

# 一键部署脚本

本项目为懒人和新手提供了自动部署脚本 `install.sh`, 不建议高级用户使用.

1. 部署脚本依赖组件 `wget git docker openssl`, 请提前安装.
1. 请在本项目根目录使用**非root用户**执行 `./install.sh` , 然后根据提示输入相关数据.
1. (可选)由于脚本修改了 `yobot/src/client/packedfiles/default_config.json` 以写入access_token, 会影响yobot自动更新, 请在机器人功能验证无误后, 进入yobot目录执行命令 `git checkout -f src/client/packedfiles/default_config.json` 清除修改.

注意: 考虑到安全性, 容器内部使用普通用户(uid=1000)运行go-cqhttp, 所以使用root用户(uid=0)构建本项目会在启动bot过程中产生权限错误, 如果您坚持使用root用户构建本项目, 请自行修改 `install.sh` 并解决访问权限问题.

# 第一次构建后的登录验证

构建完成后, 请执行 `sudo docker logs 生成的实例名` 查看日志, 如果是第一次构建运行, 日志中会提示需要登录验证, 请执行命令 `sudo docker attach 生成的实例名` 进入容器完成验证程序, 如果验证码显示不清晰, 可以按回车键刷新验证码, 完成验证流程后按 `ctrl-c` 直接退出即可, 容器会自动重启.

实例名会在部署的最后阶段显示在终端中, 格式为 `Creating 实例名 ... done`, 也可以使用命令 `sudo docker ps` 查询.

# 卸载
  在本项目根目录下执行命令 `sudo docker-compose down` 停止实例, 然后使用 `sudo docker images` 查看生成的镜像, 使用 `sudo docker rmi 镜像名` 删除镜像.