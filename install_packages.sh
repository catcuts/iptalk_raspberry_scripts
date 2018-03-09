#!/usr/bin/bash

# check whether it is needed to removing existed low-version pip
echo -e "\n\t\t\t-------- install_packages.sh started --------\n\t\t\t" && \
dpkg -l pip > /etc/null
if [ $? -eq 0 ]
then echo "removing existed pip ..." && \
	 sudo apt-get remove -y pip && \
     echo "pip removed. Updating ..."
else echo "Updating ..."
fi  && \

# update 
bash /home/pi/iptalk_resources/scripts/correct_sources.sh && \
#sudo apt-get update -y && \
echo "updated. Changing dir to /home/pi ..." && \

# download setuptools and packages
cd /home/pi && \
echo "/home/pi: " && \
echo -e "\tdownloading setuptools and pip packages ..." && \
cd /home/pi/packages > /etc/null
if [ $? -ne 0 ]
then mkdir /home/pi/packages
fi && \
sudo cp -p /home/pi/iptalk_resources/packages/setuptools-36.6.0.zip /home/pi/packages/setuptools-36.6.0.zip && \
sudo cp -p /home/pi/iptalk_resources/packages/pip-9.0.1.tar.gz /home/pi/packages/pip-9.0.1.tar.gz && \
echo -e "\tsetuptools and pip packages downloaded. Changing dir to /home/pi/iptalk_resources/packages ..." && \

# install setuptools first
cd /home/pi/packages && \
echo "/home/pi/packages: " && \
echo -e "\tUnziping setuptools ..." && \
unzip -o setuptools-36.6.0 && \
echo -e "\tsetuptools unzipped. Changing dir to setuptools-36.6.0" && \
cd setuptools-36.6.0 && \
echo "/home/pi/packages/setuptools-36.6.0: "
echo -e "\t\tinstalling setuptools ..." && \
python setup.py install && \
echo -e "\t\tsetuptools installed. Changing dir to /home/pi/packages ..." && \

# install pip after setuptools
cd /home/pi/packages && \
echo "/home/pi/packages: " && \
echo -e "\tunpackaging pip ..." && \
tar -xzf pip-9.0.1.tar.gz && \
echo -e "\tpip unpackaged. Changing dir to pip-9.0.0 ..." && \
cd pip-9.0.1 && \
echo "/home/pi/packages/pip-9.0.0: " && \
echo -e "\t\tinstalling pip ..." && \
python setup.py install && \
echo -e "\t\tpip installed. Correcting pip path" && \
type pip && \
sleep 1 && \
hash -r && \
sleep 1 && \
echo -e "\t\tpip path corrected. Changing dir to /home/pi/iptalk_resources ..." && \

# install other dependencies python packages for iptalk application
cd /home/pi/iptalk_resources && \
echo "/home/pi/iptalk_resources: " && \

echo -e "\tinstalling dev environments ..." && \
for dev in python-dev libmysqld-dev libffi-dev libssl-dev
do
	found=`dpkg -l | grep $dev`
  if [ -z "$found" ]
	then sudo apt-get install -y $dev 
	fi
done && \
echo -e "\tdev environments installed" && \

echo -e "\tinstalling packages ..." && \
cat /home/pi/iptalk_resources/requirements.txt | while read line
do
 	echo -e "\tinstalling" $line " ..." && \
 	# pip install $line -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
 	pkg=`tr A-Z a-z <<< $line`
 	if [[ $pkg =~ twisted\>\=.* ]]
 	then pip install Twisted -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
 	else sudo pip install --no-index --find-links=/home/pi/iptalk_resources/packages $line 
 	fi && \
 	echo -e "\n\t\t\t----------" $line "installed. --------\n\t\t\t--" 
done && \
echo -e "\n\t\t\t-------- final check --------\n\t\t\t" && \

# finnally check

requirements=()
while read line
do
  line=${line/%>=*/""}
  requirements+=($line)
done << EOT
`cat /home/pi/iptalk_resources/requirements.txt`
EOT
#echo -e requirements "\n\t" ${requirements[@]}

installed=()
while read line
do
  #echo $line
  line=${line/%\(*\)/""}
  installed+=($line)
done << EOT
`pip list --format=legacy`
EOT
#echo -e installed "\n\t" ${installed[@]}

for r in ${requirements[@]}
do
  #echo $r
  if ! [[ "${installed[@]}" =~ $r ]]
  then 
  echo $r is not installed
  # echo -e "\t" installing ... && \
  # pip install $r && \
  # echo -e "\t" $r is installed
  fi
done

# cat /home/pi/iptalk_resources/requirements.txt | while read line
# do
#   line=${line/%>=*/""}
#   installed=`pip list --format=legacy | grep $line`
#   if [ -z "$installed" ]
#   then echo $line is not installed
#   fi
# done && \
echo -e "\n\t\t\t-------- install_packages.sh finished --------\n\t\t\t"
