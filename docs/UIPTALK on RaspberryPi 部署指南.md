
# UIPTALK on RaspberryPi 部署指南

**目录**
* [一、概述](### 一、概述)
* [二、准备](### 二、准备)
* [三、安装/运行/备份](### 三、安装/运行/备份)

### 一、概述

　本文介绍树莓派上部署 UIPTALK 的步骤, 从安装树莓派系统开始, 到成功运行 UIPTALK 为止.  
　**注：所有命令,  特别声明外, 末尾一律不带分号(;)**

### 二、准备

| 材料                        | 数量  | 备注                                  |
| :------------------------ | :---- | :------------------------------------ |
| SD 卡                  | 1     | ≥4G                                   |
| 读卡器                   | 1     | -                                     |
| 树莓派                   | 1     | -                                     |
| 电源                        | 1     | 5V ≥2.5A                              |
| 软件 SDFormatter            | 1     | -                                     |
| 软件 Win32DiskImager        | 1     | -                                     |
| 软件 Putty              | 1     | -                                     |
| 软件 FileZilla          | 1     | -                                     |
| 树莓派系统 UIPTALK 版镜像 | 1     | -                                    |
| 源码文件夹 src           | 1     | -                                  |
| 脚本文件夹 scripts         | 1     | -                                  |

### 三、安装/运行/备份

  1. **安装树莓派 UIPTALK 版系统**

    1) SD 卡插入 PC, 识别后, 打开 SDformatter;  
    2) 使用 SDformatter 格式化该 SD 卡, 完毕后拔出 SD 卡重新插入;  
        [图1_格式化SD卡]  
    3) 打开 Win32DiskImager, 显示为 SD 卡所在盘符后, 选择树莓派系统 UIPTALK 版镜像后, 点击 write 并等待写入完毕;  
        [图2_写入树莓派镜像]  
    4) 如果写入成功, 则放入 SD 卡后上电启动树莓派
<br><br>
  2. **安装 UIPTALK**  
    1) 打开 FileZilla 登录到树莓派;  
        [图3_FileZilla登录到树莓派]  
    2) 把本机的 iptalk 的 src 和 scripts 复制到 /home/pi 下.  
<br><br>
  3. **测试 UIPTALK**  
    1) 用 SmarTTY 登录树莓派，并运行 `bash /home/pi/scripts/start.sh`;  
    2) 观察运行过程是否异常;  
    3) 如需外接移动存储设备(移动硬盘或U盘), 则运行 `bash /home/pi/scripts/mount_disk && bash /home/pi/scripts/stop.sh -r`; 
    4) 如上述两次运行均无异常, 则进入第4小步.
<br><br>
  4. **设置出厂参数**
    注: 如果已经退出(比如外接存储设备时会重启), 则用 SmarTTY 再次登录树莓派. 
    1) 设置树莓派静态 IP  
    　　(1). 在屏幕上输入 `nano /etc/dhcpcd.conf` 并回车进入编辑界面;  
    　　(2). 按需更改以下内容: (注: x y 应填入出厂数值, 如果没有要求, 取值为 x=1, y=100)    
```shell
            interface eth0  
             static ip_address=192.168.x.y/24  
             static routers=192.168.x.1  
             static domain_name_servers=223.5.5.5 223.6.6.6  
```
    　　(3). `Ctrl + o` 并回车保存, `Ctrl + x` 退出;  
    　　(4). 在屏幕上输入 `sudo /etc/init.d/networking restart` 并回车以重启网络;  

    2) 设置 UIPTALK 公网 IP  
    　　(1). 在屏幕上输入 `nano /home/pi/src/settings/default.ini` 并回车进入编辑界面;  
    　　(2). 在如下位置修改 `public_network_ip = m.n.x.y` 这行: (注: m n x y 应填入出厂数值)    
```shell
            [iptalk]
            register_password = 123
            #服务器公网ip或FTP公网ip
            public_network_ip = m.n.x.y     
```
  5. **关机**  
    最好的方法(当你用 SmarTTY 登录树莓派时): `bash /home/pi/scripts/stop.sh -h` 等待绿灯完全不闪持续30秒以上(保险起见);
<br><br>
  6. **备份(如果需要)**
    打开 Win32DiskImager, 显示为 SD 卡所在盘符后, 选择备份保存路径和文件名, 点击 read 并等待读取完毕.  

