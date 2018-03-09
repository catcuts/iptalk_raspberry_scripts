#!/usr/bin/bash

# check whether it is needed to removing existed low-version pip
echo -e "\n\t\t\t-------- install_./packages.sh started --------\n\t\t\t" && \
dpkg -l pip > /dev/null
if [ $? -eq 0 ]
then echo "removing existed pip ..." && \
  sudo apt-get remove -y pip && \
  echo "pip removed. Updating ..."
else echo "Updating ..."
fi && \

cd ./packages

# install setuptools first
echo -e "\tsetuptools unzipped. Installing setuptools ..." && \
  unzip -o setuptools-36.6.0 && \
  python setuptools-36.6.0/setup.py install && \
echo -e "\tsetuptools installed." && \

# install pip after setuptools
echo -e "\tinstalling pip ..." && \
  tar -xzf pip-9.0.1.tar.gz && \
  python pip-9.0.0/setup.py install && \
echo -e "\tpip installed. \n\tcorrecting pip path ..." && \
  type pip && \
  sleep 1 && \
  hash -r && \
  sleep 1 && \
echo -e "\t\tpip path corrected." && \

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
  cat ./packages/requirements.txt | while read line
  do
   	echo -e "\tinstalling" $line " ..." && \
   	# pip install $line -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
   	pkg=`tr A-Z a-z <<< $line`
   	if [[ $pkg =~ twisted\>\=.* ]]
   	then pip install Twisted -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
   	else sudo pip install --no-index --find-links=./packages $line 
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
`cat ./packages/requirements.txt`
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
