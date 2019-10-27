#!/bin/bash
SITES="/home/sistemas/prospeccao/data_mining/sites/"
EMPRESAS="/home/sistemas/prospeccao/data_mining/empresas/"

echo '----Executando consulta '$(date +"%d-%m-%Y %H:%M") 
rm -R $SITES
mkdir $SITES
if [ -e "/home/sistemas/prospeccao/data_mining/cnpjs.txt" ] ; then
	cd "/home/sistemas/prospeccao/data_mining"
	for n in `cat cnpjs.txt | uniq -u `
	do		
		cd $EMPRESAS
		FILE=$n".json"
		if [ ! -e "$FILE" ] ; then
			url="https://www.receitaws.com.br/v1/cnpj/"$n
			content="$(curl -s "$url")"
			RANDOM=`od -An -N1 -tu1 /dev/urandom | sed 's/ \+//g'`			
			echo $content >> "/home/sistemas/prospeccao/data_mining/empresas/"$n".json"
			cd ../cnpjs
			echo $content >> "/home/sistemas/prospeccao/data_mining/cnpjs/"$n".json"
			sleep 20
		fi
		cd ../
	done
	rm /home/sistemas/prospeccao/data_mining/cnpjs.txt
	rm /home/sistemas/prospeccao/data_mining/possivelcnpj.txt
else
	echo "Nenhum empresa consultada"
fi
echo '----Executado consulta '$(date +"%d-%m-%Y %H:%M") 