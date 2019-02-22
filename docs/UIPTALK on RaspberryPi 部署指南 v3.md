# UIPTALK on RaspberryPi 部署指南 v3

1. 往 sd 卡写入官方镜像 （2017-06-21-raspbian-jessie-lite.img）
___
2. 进入树莓派操作系统 （ssh 方式或直接）
3. 切换到目录 /home/pi
4. 新建目录 make_env_for_iptalk
5. 进入目录 make_env_for_iptalk
6. 复制 make_env_for_iptalk.zip 到该目录
7. unzip make_env_for_iptalk.zip
8. sudo bash install_iptalk_env.sh （一键部署脚本1）
9. sudo reboot（重启）
___
10. 进入树莓派操作系统 （ssh 方式或直接）
11. 切换到目录 /home/pi
12. 新建目录 make_ro_system_for_rpi3_jessie
13. 进入目录 make_ro_system_for_rpi3_jessie
14. 复制 make_ro_system_for_rpi3_jessie.zip 到该目录
15. unzip make_ro_system_for_rpi3_jessie.zip
16. sudo bash make_ro_system_sp.sh.sh （一键部署脚本2）
___
17. 测试通过
18. 备份

注：如有错误，不应放过。