#! /bin/bash

#引数に実行するpythonファイルの名前を拡張子なしで入力する
name=$1

path="reserch_data/${name}"
mkdir ${path}
touch ${path}/train_score.txt
touch ${path}/test_score.txt
touch ${path}/confusion.txt
touch ${path}/accuracy_score.txt
touch ${path}/precision_score.txt
touch ${path}/recall_score.txt
touch ${path}/f1_score.txt

for a in `seq 1 1000`
	do
		python3 ${name}.py > cash/${name}.txt
		echo "`awk 'NR==1' cash/${name}.txt` " >> ${path}/train_score.txt
		echo "`awk 'NR==2' cash/${name}.txt` " >> ${path}/test_score.txt 
		echo "`awk 'NR==3' cash/${name}.txt` " >> ${path}/confusion.txt 
		echo "`awk 'NR==4' cash/${name}.txt` " >> ${path}/accuracy_score.txt 
		echo "`awk 'NR==5' cash/${name}.txt` " >> ${path}/precision_score.txt 
		echo "`awk 'NR==6' cash/${name}.txt` " >> ${path}/recall_score.txt 
		echo "`awk 'NR==7' cash/${name}.txt` " >> ${path}/f1_score.txt  
	done

rm cash/${name}.txt
