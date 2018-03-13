### TRAINING OF QUICK START OF RPI & LINUX 

#### Notes

    1. We'll talk more about practices than technical details
    2. I'm also a learner but only started a little bit earlier 

#### Goals for this training
    
    1. Get familiar with Raspberry Pi
        1) What and why is RPi?
            1> RPi is a small computer running unix or unix-like system
                >> its structure: ...
            2> RPi is cheap and have enough performances for using in some cases
                (which means RPi is cost-effective in some cases)
            3> RPi is used to run iptalk for customers who don't want to afford a server
        2) What can a RPi do? 
            1> RPi can help learning Linux operation system
                (if you want to learn linux, you can rent a server, the second choise is to own a RPi)
            2> RPi can act like a server (that's why we can run iptalk on it)
            3> RPi can be a meterial of DIY 
                (if you are instresting in DIY, google it to inspire your DIY mind)
        3) How to use RPi? —— A quick start guide
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
                2>> How to check if a process is running
                    —— use command `ps`
                    —— eg.: ps -aux | grep iptalk  # Check if iptalk is running
                3>> How to kill a process?
                    —— kill -9 `PID` (why -9?)
                    —— eg.: kill -9 `iptalk PID getten from command ps`
                4>> How to autorun some script as system boot
                    —— edit /etc/rc.local
                    —— eg.: autorun iptalk
                5>> How to install/remove packages
                    —— use command apt-get or apitude
                    —— eg.: sudo apitude install -y mysql-server  # install mysql-server for iptalk
                        (whaty sudo? whaty -y? why not apt-get —— based on best practice on RPi, not for all linux releases)
                6>> Don't ignore the running outputs
                    —— there maybe errors or warnings inside needed to pay attention on
                7>> Use shell scripts to help works more efficient
                    —— we will see in the next section how to get a quick start on shell scripts
                8>> How to mount an external hard drive to RPi?
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
            3> Writing scripts: (simple)
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
