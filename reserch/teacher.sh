#! /bin/bash

#教師データのカウンター
t1=0
t2=0
t3=0

#学習データのカウンター
learn_counter=0

#1コンフリクトのファイル数を数える
#2シードファイル(コンフリクトの再現)を作成する
#3diffのファイルをシードファイルに入れる
		f_count=`ls conflict/  -F | grep -v / | wc -l` #コンフリクトファイルの数
		for d in `seq 0 109`
do
if [ -f ./conflict/conflict$d.txt ] && [ -f ./fix/fix$d.txt  ]; then
		touch seed.txt 

#コンフリクト箇所の行数を取得
		text1=(`grep -e "<<<<<<< HEAD" -n conflict/conflict$d.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop s/\n/ /g'`)
		text2=(`grep -e ">>>>>>> " -n conflict/conflict$d.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop; s/\n/ /g'`)
		text3=(`grep -e "=======" -n conflict/conflict$d.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop; s/\n/ /g'`)

		data=`diff conflict/conflict$d.txt fix/fix$d.txt > seed.txt `
#差分ファイル中からコンフリクトの最初と最後の行の行番号とその間の”＝”の行番号を抽出
		top=(`grep -e "< <<<<<<< HEAD" -n seed.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop; s/\n/ /g'`)
		center=(`grep -e "< =======" -n seed.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop; s/\n/ /g'`)
		last=(`grep -e "< >>>>>>> " -n seed.txt | sed -e 's/:.*//g' | sed -e ':loop; N; $!b loop; s/\n/ /g'`)

#教師データ付与
#ファイル内のコンフリクトの数だけ回す
		counter=0
		tfeature=()

		for c in ${top[@]}
		do
		flag=0 #教師データとして与える番号
		
		#チェックに使う各２行上の行
		checker1=$((${center[$counter]}-2))
		checker2=$((${last[$counter]}-2))

#first check
		if [ "$checker1" == "${top[$counter]}" ] && [ "$checker2" != "${center[$counter]}" ]; then
		 #echo "1に入りました"
		 check_seed=(`cat seed.txt | sed -n ${center[$counter]},${last[$counter]}p | cut -c 1 | sed -e ':loop; N; $!b loop; s/\n/ /g'`)
		 first_check=(0 0)
		for a in `seq 0 $((${last[$counter]}-${center[$counter]}))`
		 do
		  if [ "${check_seed[$a]}" = "<" ]; then
		  first_check[0]=$((first_check[0]+1))
		  fi
		 first_check[1]=$((first_check[1]+1))
		 done 
		 if [ "${first_check[0]}" == "${first_check[1]}" ] && [ "${first_check[0]}" != "0" ]; then
		  flag=$((flag+1))
		  t1=$((t1+1))
		 fi
		fi

#second check
		if [ "$checker2" == "${center[$counter]}" ] && [ "$checker1" != "${top[$counter]}" ]; then
		 #echo "2に入りました"
		 check_seed=(`cat seed.txt | sed -n ${top[$counter]},${center[$counter]}p | cut -c 1 | sed -e ':loop; N; $!b loop; s/\n/ /g'`)
		 second_check=(0 0)
		 for b in `seq 0 $((${center[$counter]}-${top[$counter]}))`
		  do
		   if [ "${check_seed[$b]}" = "<" ]; then
		    second_check[0]=$((second_check[0]+1))
		   fi
		   second_check[1]=$((second_check[1]+1))
		  done
		 if [ "${second_check[0]}" == "${second_check[1]}" ] && [ "${second_check[0]}" != "0" ]; then
		  flag=$(($flag+2))
		  t2=$((t2+1))
		 fi
		fi

#last check
		if [ "$flag" == "0" ]; then
		 flag=$(($flag+3))
		 t3=$((t3+1))
		 #echo "3に入りました"
		fi

#コンフリクト箇所の行数比較
		tfeature[$counter]=$((${text2[$counter]}-${text1[$counter]}))	


conflict_dataA=`sed -n $((${text1[$counter]}+1)),$((${text3[$counter]}-1))p conflict/conflict$d.txt`
conflict_dataB=`sed -n $((${text3[$counter]}+1)),$((${text2[$counter]}-1))p conflict/conflict$d.txt`

conflict_dataA=`python3 format.py "$conflict_dataA" | sed -e ':loop; N; $!b loop; s/\n//g'`
conflict_dataB=`python3 format.py "$conflict_dataB" | sed -e ':loop; N; $!b loop; s/\n//g'`

tcount=${tfeature[$counter]}

#コンフリクト箇所のn-gramによる確率を取得
		ngram=`python3 n-Gram.py $conflict_dataA $conflict_dataB`

#コンフリクト箇所のレーベんシュタイン距離を取得
		leven=`python3 leven.py $conflict_dataA $conflict_dataB`
		
		#echo "ngram=$ngram"
		#echo "leven=$leven"
		#echo "tcount=$tcount"
		#echo "flag=$flag"
		#echo ""

		learn_file_name="learn${learn_counter}.txt"
		touch /home/ryuhei/new_reserch/reserch/learn_data/${learn_file_name}
		seed=`cat /home/ryuhei/new_reserch/reserch/seed_data/feature$d.txt`
		echo "$seed$ngram $leven $tcount $flag" > /home/ryuhei/new_reserch/reserch/learn_data/${learn_file_name}

		learn_counter=$((learn_counter+1))
		counter=$((counter+1))		
		done
		
		unset top[@]
		unset center[@]
		unset last[@]
		unset text1[@]
		unset text2[@]
		unset text3[@]

		rm seed.txt
else
 echo "ファイルが存在しませんでした"
 echo ""
fi
done

echo "1=$t1 回"
echo "2=$t2 回"
echo "3=$t3 回"
