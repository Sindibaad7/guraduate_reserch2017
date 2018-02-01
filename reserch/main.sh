#!/bin/bash

#urlの数値を変更させる
#既存のリポジトリ番号に続けてやる

url=`cat ~/new_reserch/api_result/10-20.json  | jq .items[].clone_url | sed -e "s/\"//g"` 

count=0
for a in $url
do
 id[$count]=$a
 count=$((count+1))
done

#echo "${id[0]}"
cd clone
count=0
for b in $url
do
 git clone ${id[$count]} $count
 count=$((count+1))
done
