#!/usr/bin/bash

# check whether it is needed to removing existed low-version pip
echo -e "\n\t\t\t-------- install_./packages.sh started --------\n\t\t\t" && \
dpkg -l pip > /dev/null
if [ $? -eq 0 ]; then
  echo "removing existed pip ..." && \
  sudo apt-get remove -y pip
fi && \

cd ./packages && \

# install pip and setuptools and wheel
if [ ! -f ./get-pip.py ]; then
  wget https://bootstrap.pypa.io/get-pip.py
fi && \
python get-pip.py && \

# install dev environments
echo -e "\tinstalling dev environments ..." && \
  for dev in python-dev libmysqld-dev libffi-dev libssl-dev
  do
  	found=`dpkg -l | grep $dev`
    if [ -z "$found" ]; then
      sudo apt-get install -y $dev 
  	fi
  done && \
echo -e "\tdev environments installed" && \

# install packages
echo -e "\tinstalling packages ..." && \
  cat ../requirements.txt | while read line
  do
   	echo -e "\tinstalling" $line " ..." && \
   	# pip install $line -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
   	pkg=`tr A-Z a-z <<< $line`
   	if [[ $pkg =~ twisted\>\=.* ]]; then
      pip install Twisted -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
      # sudo pip install --no-index --find-links=./ Twisted
   	else
      sudo pip install --no-index --find-links=./ $line 
   	fi && \
   	echo -e "\t----------" $line "installed. ----------" 
  done && \
echo -e "\n\t\t\t-------- final check --------\n\t\t\t" && \

# finnally check

requirements=()
while read line
do
  line=${line/%>=*/""}
  line=${line/%==*/""}
  requirements+=($line)
done << EOT
`cat ../requirements.txt`
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

all_installed=1
for r in ${requirements[@]}
do
  #echo $r
  if ! [[ "${installed[@]}" =~ $r ]]; then 
    echo $r is not installed
    # echo -e "\t" installing ... && \
    # pip install $r && \
    # echo -e "\t" $r is installed
    all_installed=0
  fi
done
if [ $all_installed -eq 1 ]; then
  echo all packages installed.
fi

# cat /home/pi/iptalk_resources/requirements.txt | while read line
# do
#   line=${line/%>=*/""}
#   installed=`pip list --format=legacy | grep $line`
#   if [ -z "$installed" ]
#   then echo $line is not installed
#   fi
# done && \

cd ..

echo -e "\n\t\t\t-------- install_packages.sh finished --------\n\t\t\t"
