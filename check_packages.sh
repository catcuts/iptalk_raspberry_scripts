echo -e "\t-------- final check --------" && \

# finnally check

allinstalled=1
requirements=()
while read line
do
  line=${line/%>=*/""}
  line=${line/%==*/""}
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
    allinstalled=0
  # else
  #   echo $r is installed
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

if [ $allinstalled -eq 1 ]; then echo All packages are installed.; fi

echo -e "\t-------- install_packages.sh finished --------"