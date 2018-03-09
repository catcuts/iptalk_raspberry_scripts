# correct_source.sh
echo -e "\t-------- correct_sources.sh started --------" && \
sudo cp -p /etc/apt/sources.list /etc/apt/sources_bkup.list && \
#echo -e "deb http://archive.raspbian.org/raspbian jessie main contrib non-free\ndeb-src http://archive.raspbian.org/raspbian jessie main contrib non-free" > /etc/apt/sources.list && \
echo -e "deb http://mirrors.aliyun.com/raspbian/raspbian/ wheezy main non-free contrib\ndeb-src http://mirrors.aliyun.com/raspbian/raspbian/ wheezy main non-free contrib" > /etc/apt/sources.list && \
sudo apt-get update -y && \
#sudo apt-get upgrade -y && \
echo -e "\t-------- correct_source.sh started --------"
