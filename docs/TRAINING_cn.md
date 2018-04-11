### 树莓派与LINUX速成

#### 注

    1. 本次速成将更多关注实践，忽略技术细节
    2. I'm also a learner but only started a little bit earlier 

#### 内容
    
    1. 熟悉树莓派
        1) 什么是树莓派?
            1> 小型电脑, 运行 unix 或 unix-like 系统 (解释)
                >> 它的结构: ...
            2> 树莓派很便宜，并且在一些应用场合中具备足够的性能 (举例: 搭建个人翻墙服务器, 对比租用搬瓦工服务器)
                (这意味着, 在某些应用场合中，树莓派的性价比很高)
            3> 对于 IPtalk 产品, 树莓派为不愿意自行购买服务器的客户提供了可选项

        2) 树莓派能做什么?
            1> 学习 Linux 命令行操作系统 (有助测试和运维提高)
                (如果想学 Linux, 一个选择是租用服务器, 另一个选择就是购买一块树莓派)
            2> 作为服务器运行所需程序 (比如 iptalk 程序)
            3> 作为 DIY 的核心材料(有兴趣的话, 可以谷歌上搜索)

        3) 如何使用树莓派? —— 快速入门指南
            1> Prepare a RPi and its auxiliaries (power cable, network cable)
            2> Download an image from official website (https://www.raspberrypi.org/downloads/)
            3> Write this image into an SD card by tools (SDFormatter and Win32DiskImager)
                Note: To set an available ip address that we know and touch an empty file named ssh (no ext.)
                        so that we can access the RPi by ssh
            4> Network connected, power on, ssh it, you have accessed in RPi system (Putty or Cmder)
            5> Shutdown or Reboot the RPi (better not to plug off power)
            6> Use it for iptalk
            7> Some tips
                1>> How to config the network
                    —— edit /etc/dhcpcd.conf
                    —— note: editing /etc/network/interface not works
                2>> How to check if the network is available
                    —— use command `curl`
                    —— eg.: curl www.baidu.com
                3>> How to check if a process is running
                    —— use command `ps`
                    —— eg.: ps -aux | grep iptalk  # Check if iptalk is running
                4>> How to kill a process?
                    —— kill -9 `PID` (why -9?)
                    —— eg.: kill -9 `iptalk PID getten from command ps`
                5>> How to autorun some script as system boot
                    —— edit /etc/rc.local
                    —— eg.: autorun iptalk
                6>> How to install/remove packages
                    —— use command apt-get or apitude
                    —— eg.: sudo apitude install -y mysql-server  # install mysql-server for iptalk
                        (whaty sudo? whaty -y? why not apt-get —— based on best practice on RPi, not for all linux releases)
                7>> Don't ignore the running outputs
                    —— there maybe errors or warnings inside needed to pay attention on
                8>> Use shell scripts to help works more efficient
                    —— we will see in the next section how to get a quick start on shell scripts
                9>> How to mount an external hard drive to RPi?
                    —— left as an exercise for your homework

        4) How to expand your knowledge base on RPi? 
            —— Practices with Questioning and Asking (experenced People or Google)
            —— Some awesome websites for further learning and references
                1>> Official Website: www.raspberrypi.org
                2>> Search Engine: Google is always the best, Baidu is less recommended
                3>> Technical Q&A: SegmentFault, Stack Overflow, Zhihu ...
                    (but we often access them through the searching results offerred by Google)

    2. Get familiar with Linux
        1) What is Linux, and why not Windows?
            1> Linux is a kind of operation system different from Windows
            2> Actually I don't have a very clear idea about why to use linux but not windows
                (currently the reason is the work pushs me to use linux)

        2) What can a Linux do?

        3) How to use Linux? (some commands mentioned, here focus on shell scripts)
            A quick start
            1> New and edit an empty file: nano / vi hello.sh
            2> Writing header: #!/bin/bash or #!/bin/sh (latter one is more campaticable between poxis system)
            3> Writing scripts: (simple hello-world)
```shell 
#!/bin/sh
HELLO_FILE=./hello.txt
if [ ! -f $HELLO_FILE ]; then
    touch $HELLO_FILE
    echo "$HELLO_FILE is created"
else
    echo "$HELLO_FILE is existed"
fi
HELLO_FILE_RP=`readlink -f $HELLO_FILE`
echo 'hello world' |& tee $HELLO_FILE  # actually this will create file if not exited
echo "$HELLO_FILE_RP \
finished writing"  # trap: double quotation marks
echo 'goodbye'
```
            4> Save and run
            5> Script used for starting iptalk
```shell
#!/usr/bin/bash

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)
LOGDIR="/home/pi/logs"
_DATE="_$DATE"
_TIME="_$TIME"
LOGFILE="/home/pi/logs/log$_DATE$_TIME.log"
# LOGFILE=$LOGDIR/log_$DATE_$TIME.log

{
    bash ./stop.sh
} || {
    echo ''
} && \

if [ ! -d $LOGDIR ]; then
    mkdir -p $LOGDIR
fi && \

if [ -f $LOGFILE ]; then
    echo '' > $LOGFILE
else
    touch $LOGFILE
fi && \

echo -e "\n\t\t\t ====== IPTALK RUNNING ======\n\
\n\t\t\t ======   $DATE   ====== \n\t\t\t\
\n\t\t\t ======    $TIME    ====== \n\t\t\t" && \

# {  # your 'try' block
#     wget && \
#     bash supervior.sh
# } || {  # your 'catch' block
#     echo 'supervisor error'
# }

python /home/pi/src/iptalk.py |& tee -a $LOGFILE
```
        
        6) How to expand your knowledge base on RPi?  
            —— Practices with Questioning and Asking (experenced People or Google)
            —— Some awesome websites for further learning and references
                1>> Start guide: cn.linux.vbird.org + a linux system for practice by free hand
                2>> Shell scripts manual: https://wenku.baidu.com/view/a41f837acaaedd3383c4d3b4.html
                2>> Search Engine: Google is always the best, Baidu is also recommended
                3>> Technical Q&A: SegmentFault, Stack Overflow, Zhihu ...
                    (but we often access them through the searching results offerred by Google)
