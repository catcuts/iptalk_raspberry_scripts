# UIPTALK on RaspberryPi 部署指南（裸机） v1

**目录**
- 一、概述
- 二、准备
- 三、安装及配置树莓派系统
- 四、部署 UIPTALK 运行环境
- 五、运行 UIPTALK
- 六、开启防火墙
- 七、备份 UIPTALK

### 一、概述

　本文介绍树莓派上部署 UIPTALK 的步骤, 从安装树莓派系统开始, 到成功运行 UIPTALK 为止.  
　**注：所有命令,  特别声明外, 末尾一律不带分号(;)**

### 二、准备

| 材料 						| 数量  | 备注 									|
| :------------------------ | :----	| :------------------------------------ |
| SD 卡 					| 1 	| ≥4G 									|
| 读卡器 					| 1 	| - 									|
| 树莓派 					| 1 	| - 									|
| 电源 						| 1 	| 5V ≥2.5A 								|
| 软件 SDFormatter 			| 1 	| -										|
| 软件 Win32DiskImager 		| 1 	| -										|
| 软件 Cmder 				| 1 	| -										|
| 软件 FileZilla			| 1 	| -										|
| 树莓派系统官方镜像 		| 1 	| -										|
| 树莓派系统 UIPTALK 版镜像 | 1 	| 可选 									|

### 三、安装及配置树莓派系统

  1. **安装树莓派 UIPTALK 版系统**

    1) SD 卡插入 PC, 识别后, 打开 SDformatter;  
    2) 使用 SDformatter 格式化该 SD 卡, 完毕后拔出 SD 卡重新插入;  
    	[图1_格式化SD卡]  
    3) 打开 Win32DiskImager, 显示为 SD 卡所在盘符后, 选择树莓派系统 UIPTALK 版镜像后, 点击 write 并等待写入完毕;  
    	[图2_写入树莓派镜像]  
    4) 如果写入成功, 则启动、运行、登录树莓派并直接跳往第五大步; 如果写入异常或发现无法正常启动, 则进入第2小步.  

  2. **安装树莓派官方系统**
    
    1) 同第1小步的第1)分步;  
    2) 同第1小步的第2)分步;  
    3) 打开 Win32DiskImager, 显示为 SD 卡所在盘符后, 选择树莓派系统 **官方** 镜像后, 点击 write 并等待写入完毕;  
    4) 如果写入成功, 则前往第2½小步; 如果写入异常或发现无法正常启动, 则视情况而定.  

  2½. **设置树莓派临时 IP**

	1) 进入 SD 卡所在盘根目录, 打开 cmdline.txt 进行编辑, 在最前面加上 `ip=192.168.x.y ` (其中 x y 为临时设定值, 确保 192.168.x.y 能正常访问);  
	2) 前往第3小步.  

  3. **使能 ssh 远程登录**

	1) 进入 SD 卡所在盘根目录, 在根目录下新建一个空文件, 命名为 ssh (注意没有后缀名. 如果后缀不可见, 应先设置为可见);  
	2) 安全弹出 SD 卡, 插入树莓派 SD 卡槽. 前往第4小步——  

  4. **启动并登录树莓派系统**
    
	1) 打开 `Cmder`, 输入 `ssh root@192.168.x.y` 并回车(x y 为第2½小步设定的值);  
	2) 输入密码 `meeyi` 并回车;  
	3) 若无异常则前往第5小步; 若有异常则按异常处理.   

  5. **配置树莓派系统**

    1) 修改 root 用户权限并登录:   
	　　(1). 在屏幕上输入 `sudo passwd root` 并回车;    
	　　(2). 出现 `Enter new UNIX password`, 输入 `meeyi` 并回车;  
	　　(3). 出现 `Retype new UNIX password`, 再次输入同样的 `meeyi` 并回车;  
	　　(4). 如果提示 `passwd: password updated successfully` 则修改成功, 否则按异常处理;  
	　　(5). 然后输入 `sudo passwd --unlock root` 并回车, 提示 `passwd: password expiry information changed.` 则成功, 否则按异常处理;  
	　　(6). 最后输入 `su` 并回车, 提示 `password:` 输入 `meeyi` 并回车;  
	　　(7). 无异常则进入第2)分步; 如有异常, 按异常处理. 

	2) 设置树莓派静态 IP 和 DNS:  
	　　(1). 在屏幕上输入 `nano /etc/dhcpcd.conf` 并回车进入编辑界面;  
	　　(2). 在最后一行输入以下内容: (注: x y 应填入具体数值, 确保 192.168.x.y 能正常访问)    

			interface eth0  
			 static ip_address=192.168.x.y/24  
			 static routers=192.168.x.1  
			 static domain_name_servers=223.5.5.5 223.6.6.6  

	　　(3). `Ctrl + o` 并回车保存, `Ctrl + x` 退出;  
	　　(4). 在屏幕上输入 `sudo /etc/init.d/networking restart` 并回车以重启网络;  

    3) 允许 root 用户以 `ssh` 远程登录:  
	　　(1). 在屏幕上输入 `nano /etc/ssh/sshd_config` 并回车, 进入编辑界面;  
	　　(2). 将 `PermitRootLogin without-password`  修改为 `PermitRootLogin yes`;  
	　　(3). `Ctrl + o` 并回车保存, 然后 `Ctrl + x` 退出;  
	　　(4). 在屏幕上输入 `sudo shutdown -h now` 并回车以关机树莓派使设置生效. 无异常前往第3½)分步. 

    3½) 撤销临时 IP:  
	　　(1). 进入 SD 卡所在盘根目录, 打开 cmdline.txt 进行编辑, 去掉之前加的 `ip=192.168.x.y ` 并保存退出;  
	　　(2). 安全弹出 SD 卡, 插入树莓派 SD 卡槽, 前往第4)分步.   

	4) 远程登录树莓派:  
	　　(1). 打开 `Cmder`, 输入 `ssh root@192.168.x.y` 并回车(x y 为第2)分步设定的值);  
	　　(2). 输入密码 `meeyi` 并回车;  
	　　(3). 若无异常则前往第5)分步; 若有异常则按异常处理.  

	5) 获取 `iptalk_resources` 到本地:  
	　　(1). 复制以下代码到剪贴板;   

			# download_iptalk_resources.sh  
			echo -e "\t-------- download_iptalk_resources.sh started --------" && \  
			cd /home/pi && \  
  
			git > /etc/null  
			if [ $? -eq 0 ]  
			then echo -e "\tDownloading iptalk_resources ..."  
			else   
				 echo -e "\tinstalling git ..." && \  
				 sudo apt-get update -y && \  
				 sudo apt-get install -y git && \  
			     echo -e "\tgit installed. Downloading iptalk_resources ..."  
			fi  && \  
  
			git clone https://github.com/catcuts/iptalk_resources.git  
			if [ $? -ne 0 ]  
			then cd iptalk_resources && git pull   
			fi && \  
			echo -e "\tiptalk_resources downloaded. Copying src to /home/pi ..."  
			echo -e "\t-------- download_iptalk_resources.sh fishished --------"  

	　　(2). 在屏幕上输入 `nano d.sh` 进入编辑界面;  
	　　(3). 在屏幕上单击右键, 然后在对话框上点击确定, 把所复制的代码粘贴到文件中; (注: 不能使用 `Ctrl + v`)  
	　　(4). `Ctrl + o` 并回车以保存, 然后 `Ctrl + x` 退出;  
	　　(5). 在屏幕上输入 `bash d.sh` 并回车以运行脚本;  
	　　(6). 若无异常则前往第6)分步; 若有异常则按异常处理.  

	6) 校正系统时间:  
	　　(1). 在屏幕上输入 `bash iptalk_resources/scripts/correct_timezone.sh` 并回车;  
	　　(2). 运行完毕, 若无异常则前往第7)分步; 若有异常则按异常处理.  

    7) 修改系统软件来源并更新软件和系统;  
	　　(1). 在屏幕上输入 `bash iptalk_resources/scripts/correct_sources.sh`;  
	　　(2). 这一步可能持续较长时间, 请耐心等候, 并留心是否出现异常;  
	　　(3). 运行完毕, 若无异常则前往第四大步; 若有异常则按异常处理.  

### 四、部署 UIPTALK 运行环境

  1. **安装 mysql**  
	1) 安装 mysql: `bash /home/pi/iptalk_resources/scripts/install_mysql.sh`;(注: 当弹出要求输入 root 用的密码时, 输入 root 全部小写)    
  	2) 配置 mysql: `bash /home/pi/iptalk_resources/scripts/config_mysql.sh`;  
  	3) 无异常进入第2小步.

  2. **安装 python packages**  
  	1) 安装 python packages: `bash /home/pi/iptalk_resources/scripts/install_packages.sh`;  
  	2) 无异常进入第2小步.

  3. **安装 ffmpeg**  
  	1) 安装 ffmpeg: `bash /home/pi/iptalk_resources/scripts/install_ffmpeg.sh`;  
  	2) 无异常进入第4小步.  
  	3) 无异常进入第五大步.

  4. **安装 iptalk**
  	1) 打开 FileZilla 登录到树莓派;  
    	[图3_FileZilla登录到树莓派]  
  	2) 把本机的 iptalk 的 src 复制到 /home/pi 下.  

### 五、试运行与配置 UIPTALK

  1. **试运行 UIPTALK**  
  	1) 在屏幕上输入 `python /home/pi/src/test.py`;  
  	2) 观察运行过程是否异常;  
  	3) 如无异常, 则进入第2小步.

  2. **设置 UIPTALK 开机运行**  
  	1) 在屏幕上输入 `nano /etc/rc.local` 进入编辑界面;  
  	2) 在 `exit 0` 之前加入两条语句如下: (注: 如果发现已经加了, 则不要重复添加)

		sudo /etc/init.d/mysql restart && \  
		sudo python /home/pi/src/test.py   

  3. **设置出厂参数**
  	1) 设置树莓派静态 IP  
	　　(1). 在屏幕上输入 `nano /etc/dhcpcd.conf` 并回车进入编辑界面;  
	　　(2). 在最后一行输入以下内容: (注: x y 应填入出厂数值)    

			interface eth0  
			 static ip_address=192.168.x.y/24  
			 static routers=192.168.x.1  
			 static domain_name_servers=223.5.5.5 223.6.6.6  

	　　(3). `Ctrl + o` 并回车保存, `Ctrl + x` 退出;  
	　　(4). 在屏幕上输入 `sudo /etc/init.d/networking restart` 并回车以重启网络;  

  	2) 设置 UIPTALK 公网 IP  
	　　(1). 在屏幕上输入 `nano /home/pi/src/settings/default.ini` 并回车进入编辑界面;  
	　　(2). 在如下位置修改 `public_network_ip = m.n.x.y` 这行: (注: m n x y 应填入出厂数值)    

			[iptalk]
			register_password = 123
			#服务器公网ip或FTP公网ip
			public_network_ip = m.n.x.y 	

### 六、开启防火墙

　`bash /home/pi/iptalk_resources/scripts/active_ufw.sh`  

### 七、备份 UIPTALK

　打开 Win32DiskImager, 显示为 SD 卡所在盘符后, 选择备份保存路径和文件名, 点击 read 并等待读取完毕.