#!/usr/bin/bash
step=1
#↑ 停留在第几步, 该步之前已经执行完毕
echo -e "当前在第 $step 步 ."
max_step=10

echo -ne "[ info ] 确认以下步骤:\n \
1. SD 卡扩容\n \
2. apt-get update && apt-get upgrade\n \
3. reboot\n \
4. 停止 mysql 服务\n \
已完成 ? [yes/no] "
    read done_prepare
    if [ "$done_prepare" != "yes" ]; then
        echo -e "你选择了未完成($done_prepare 而非 yes) . 中止 . 确认完成以上步骤后再重试 ."
        exit 1
    fi

# ____________________________________________________________________________

echo -e "[ info ] 检查网络 ..."

    ret_code=`curl -I -s --connect-timeout 5 www.baidu.com -w %{http_code} | tail -n1`
    # ret_code maybe none so insert an x
    if [ "$ret_code" != "200" ]; then
        echo -e "[ info ] 检查网络 异常 . 中止 ."
        exit 1
    fi

echo -e "[ info ] 检查网络 正常 ."

sbs="yes"
if [ "$1" == "notstepbystep" ]; then
    sbs="no"
else
    echo -e "[ info ] step-by-step mode ."
fi

next(){
    last_step=$step
    if [ $step -le $max_step ]; then
        ((step++))
    fi
    sed -i "2s/step=$last_step/step=$step/" $0
    if [ "$sbs" == "yes" ]; then
        echo -ne "[ stage ] 继续 ? [y/n] "
        read sbs_cmd
        if [ "$sbs_cmd" != "y" ]; then
            echo "中止 ."
            exit 1
        fi
    fi
}

PARTUUID1=`blkid /dev/mmcblk0p1 | sed 's/.*PARTUUID=\"\(.*\)\"/\1/'`
PARTUUID2=`blkid /dev/mmcblk0p2 | sed 's/.*PARTUUID=\"\(.*\)\"/\1/'`

# ____________________________________________________________________________

step1(){
    echo -e "[ info ] 修改 /boot/cmdline.txt ..."

        # original: PARTUUID=992231d4-02 instead of /dev/mmcblk0p2 
        sed -i "s/PARTUUID=$PARTUUID2/\/dev\/mmcblk0p2/" /boot/cmdline.txt

    echo -e "[ info ] 修改 /boot/cmdline.txt 完毕 ."

    echo -e "[ info ] 修改 /etc/fstab ..."

        sed -i "s/\(PARTUUID=$PARTUUID1.*defaults\)\(\s*.*\)/\1,ro\2/" /etc/fstab

        sed -i "s/\(PARTUUID=$PARTUUID2.*defaults,noatime\)\(\s*.*\)/\1,ro\2/" /etc/fstab

        # original: PARTUUID=992231d4-02 instead of /dev/mmcblk0p2 
        sed -i "s/PARTUUID=$PARTUUID1/\/dev\/mmcblk0p1/" /etc/fstab
        sed -i "s/PARTUUID=$PARTUUID2/\/dev\/mmcblk0p2/" /etc/fstab

        echo -e "\
    \n# For Debian Jessie \
    \ntmpfs           /tmp            tmpfs   nosuid,nodev         0       0 \
    \ntmpfs           /var/log        tmpfs   nosuid,nodev         0       0 \
    \ntmpfs           /var/tmp        tmpfs   nosuid,nodev         0       0 \
    " >> /etc/fstab

    echo -e "[ info ] 修改 /etc/fstab 完毕 ."
}

# ____________________________________________________________________________

step2(){
    echo -e "[ info ] 移除无关软件与服务 ..."

        apt-get remove --purge \ 
            wolfram-engine \
            triggerhappy \
            anacron \
            logrotate \
            dphys-swapfile \
            xserver-common \
            lightdm && \

        insserv -r x11-common && \
        apt-get autoremove --purge

    echo -e "[ info ] 移除无关软件与服务 完毕 ."
}

# ____________________________________________________________________________

step3(){
    echo -e "[ info ] 用 busybox 替代默认日志管理器 ..."

        apt-get install busybox-syslogd && dpkg --purge rsyslog

    echo -e "[ info ] 用 busybox 替代默认日志管理器 完毕 ."
}

# ____________________________________________________________________________

step4(){
    echo -e "[ info ] 停用关于 交换分区 和 文件系统 的检查, 并设置为 只读 ..."

        sed -i 's/$/& fastboot noswap ro/g' /boot/cmdline.txt
        cat /boot/cmdline.txt

    echo -e "[ info ] 停用关于 交换分区 和 文件系统 的检查, 并设置为 只读 完毕 ."
}

# ____________________________________________________________________________

step5(){
    echo -e "[ info ] 移动部分系统文件到临时文件系统 开始 ..."

        rm -rf /var/lib/dhcp/ /var/lib/dhcpcd5 /var/run /var/spool /var/lock /etc/resolv.conf
        ln -s /tmp /var/lib/dhcp
        ln -s /tmp /var/lib/dhcpcd5
        ln -s /tmp /var/run
        ln -s /tmp /var/spool
        ln -s /tmp /var/lock
        touch /tmp/dhcpcd.resolv.conf
        ln -s /tmp/dhcpcd.resolv.conf /etc/resolv.conf

    echo -e "[ info ] 移动部分系统文件到临时文件系统 完毕 ."
}

# ____________________________________________________________________________

step6(){
    echo -e "[ info ] 对于 Raspberry PI 3, 移动部分锁定文件到临时文件系统 ..."

        echo -e "[ info ] 针对 /etc/systemd/system/dhcpcd5 ..."
            sed -i "s/PIDFile=\\/run\\/dhcpcd.pid/PIDFile=\\/var\\/run\\/dhcpcd.pid/" /etc/systemd/system/dhcpcd5
            cat /etc/systemd/system/dhcpcd5
        echo -e "[ info ] 好了 ."

        echo -e "[ info ] 针对 /var/lib/systemd/random-seed ..."
            rm /var/lib/systemd/random-seed    
            ln -s /tmp/random-seed /var/lib/systemd/random-seed
            sed -i "/RemainAfterExit=yes/aExecStartPre=\\/bin\\/echo '' >\\/tmp\\/random-seed" /lib/systemd/system/systemd-random-seed.service    
        echo -e "[ info ] 好了 ."

        echo -e "[ info ] daemon reloading ..."
            systemctl daemon-reload
        echo -e "[ info ] daemon reloaded ."

    echo -e "[ info ] 对于 Raspberry PI 3, 移动部分锁定文件到临时文件系统 完毕."
}

# ____________________________________________________________________________

step7(){
    echo -e "[ info ] 修改 /etc/cron.hourly/fake-hwclock ..."

        sed -i "/fake-hwclock save/i\ \ mount -o remount,rw \/" /etc/cron.hourly/fake-hwclock

        sed -i "/fake-hwclock save/a\ \ mount -o remount,ro \/" /etc/cron.hourly/fake-hwclock

    echo -e "[ info ] 修改 /etc/cron.hourly/fake-hwclock 完毕 ."

    echo -e "[ info ] 修改 /etc/ntp.conf ..."

        sed -i "s/driftfile\ \/var\/lib\/ntp\/ntp.drift/driftfile \/var\/lib\/tmp\/ntp.drift/" /etc/ntp.conf

    echo -e "[ info ] 修改 /etc/ntp.conf 完毕 ."
}

# ____________________________________________________________________________

step8(){
    echo -e "[ info ] 移除部分启动脚本 ..."

        insserv -r bootlogs 
        insserv -r console-setup

    echo -e "[ info ] 移除部分启动脚本 完毕 ."
}

# ____________________________________________________________________________

step9(){
    echo -e "[ info ] 增加动态切换 ro <=> rw 命令 ..."

    #     echo -e "\
    # \n# set variable identifying the filesystem you work in (used in the prompt below) \
    # \nset_bash_prompt(){ \
    # \n    fs_mode=$(mount | sed -n -e "s/^\/dev\/.* on \/ .*(\(r[w|o]\).*/\1/p") \
    # \n    PS1='\[\033[01;32m\]\u@\h${fs_mode:+($fs_mode)}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' \
    # \n} \
    # \nalias ro='sudo mount -o remount,ro / ; sudo mount -o remount,ro /boot' \
    # \nalias rw='sudo mount -o remount,rw / ; sudo mount -o remount,rw /boot' \
    # \n# setup fancy prompt \
    # \nPROMPT_COMMAND=set_bash_prompt
    # " >> /etc/bash.bashrc
}

# ____________________________________________________________________________

step10(){
    echo -ne "[ stage ] 重启 ? [yes/no] "

    read cmd
    if [ "$cmd" == "yes" ]; then
        reboot
    else
        echo -e "你选择了不重启($cmd 而非 yes)"
    fi
}

for k in $( seq $step $max_step )
do
    step$k
    next
done