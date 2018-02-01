#! /bin/bash

for b in `seq 1 99`
do
if [ -f ./conflict/conflict$b.txt ]; then

text1=()
text2=()
text3=()
tfeature=()

text1=(`grep -e "<<<<<<< HEAD" -n conflict/conflict$b.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop; s/\n/ /g'`)

text2=(`grep -e ">>>>>>> " -n conflict/conflict$b.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop; s/\n/ /g'`)

text3=(`grep -e "=======" -n conflict/conflict$b.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop; s/\n/ /g'`)

echo ${text1[@]}
echo ${text3[@]}
echo ${text2[@]}


count=0
for a in ${text1[@]}
 do
  tfeature[$count]=$((${text2[$count]}-${text1[$count]}))
  #echo 1
  count=$((count+1))
done 

echo ${tfeature[@]}
echo " "

unset text1[@]
unset text2[@]
unset text3[@]

else
echo ""
fi
done
