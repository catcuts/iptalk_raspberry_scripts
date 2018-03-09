# correct_source.sh
echo -e "\n\t\t\t-------- correct_sources.sh started --------\n\t\t\t" && \
    sudo cp -p /etc/apt/sources.list /etc/apt/sources_bkup.list && \
    #echo -e "deb http://archive.raspbian.org/raspbian jessie main contrib non-free\ndeb-src http://archive.raspbian.org/raspbian jessie main contrib non-free" > /etc/apt/sources.list && \
    sed -i "1ideb http://mirrors.aliyun.com/raspbian/raspbian/ wheezy main non-free contrib\ndeb-src http://mirrors.aliyun.com/raspbian/raspbian/ wheezy main non-free contrib" /etc/apt/sources.list && \
    sudo apt-get update -y && \
echo -e "\n\t\t\t-------- correct_source.sh started --------\n\t\t\t"
