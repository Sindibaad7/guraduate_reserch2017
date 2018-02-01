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
touch ${path}/feature_commit.txt
touch ${path}/feature_line.txt
touch ${path}/feature_message.txt
touch ${path}/feature_time.txt
touch ${path}/feature_ngram.txt
touch ${path}/feature_leven.txt
touch ${path}/feature_code.txt

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
		echo "`awk 'NR==8' cash/${name}.txt` " >> ${path}/feature_commit.txt  
		echo "`awk 'NR==9' cash/${name}.txt` " >> ${path}/feature_line.txt  
		echo "`awk 'NR==10' cash/${name}.txt` " >> ${path}/feature_message.txt  
		echo "`awk 'NR==11' cash/${name}.txt` " >> ${path}/feature_time.txt  
		echo "`awk 'NR==12' cash/${name}.txt` " >> ${path}/feature_ngram.txt  
		echo "`awk 'NR==13' cash/${name}.txt` " >> ${path}/feature_leven.txt  
		echo "`awk 'NR==14' cash/${name}.txt` " >> ${path}/feature_code.txt  
	done

rm cash/${name}.txt
