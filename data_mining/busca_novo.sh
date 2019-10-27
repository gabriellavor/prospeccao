#!/bin/bash
echo '-Executando busca '$(date +"%d-%m-%Y %H:%M")
BAIXADOS="/home/sistemas/prospeccao/data_mining/baixados/"
BAIXADOSTMP="/home/sistemas/prospeccao/data_mining/baixadostmp/"

cd /home/sistemas/prospeccao/data_mining/termos
totaltermos=$(find -name "termos*" | wc -l)
if [ $totaltermos -gt 0 ];then
	for nome in $(find -name "termos*")
	do
		cd ../
		IFSOLD=$IFS
		IFS=$';'
		TOTAL=0
		TERMOS="/home/sistemas/prospeccao/data_mining/termos"$(echo $nome| cut -d'.' -f 2)".txt"
		
		for nome in `cat $TERMOS`
		do
			TERMO="$nome"
			cd $BAIXADOSTMP
			for i in 0;
			do
				TOTAL=$((TOTAL+1))
				pesquisa="https://www.google.com.br/search?q=CNPJ empresa "$TERMO"&num=1000&start="$i
				wget --reject jpg,png,flv,pdf,xls  --header="Accept: text/html" --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3205.0 Safari/537.36" $pesquisa								
				sleep 2
			done
			cd ../
		done
		cd $BAIXADOSTMP
		mv * $BAIXADOS
		cd ../
		rm $TERMOS
		break
	done
else
	cd ../
	echo '------------------------------------------------- '$(date +"%d-%m-%Y %H:%M")'-------------------------------------------------'
	python3 /home/sistemas/prospeccao/data_mining/ia/importa_termo.py
fi
IFS=$IFSOLD
echo '-Executado Busca '$(date +"%d-%m-%Y %H:%M")