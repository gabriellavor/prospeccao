#!/bin/bash
echo '---Executando procura '$(date +"%d-%m-%Y %H:%M") 
SITES="/home/sistemas/prospeccao/data_mining/sites/"
EMPRESAS="/home/sistemas/prospeccao/data_mining/empresas/"
#cd sites
for nome in $(grep -R "CNPJ" /home/sistemas/prospeccao/data_mining/sites/ | sed 's/[^0-9A-Z/.-]\+/\n/g' | sed 's/[^0-9]\+//g' | sed '/^$/d')
do
	
	QTD=${#nome}
	if [ "$QTD" -eq 14 ]
	then
		echo  $nome >> /home/sistemas/prospeccao/data_mining/possivelcnpj.txt
	fi
done
if [ -e "/home/sistemas/prospeccao/data_mining/possivelcnpj.txt" ] ; then
	touch /home/sistemas/prospeccao/data_mining/cnpjs.txt
	python3 /home/sistemas/prospeccao/data_mining/validaCnpj.py
fi
echo '---Executado procura '$(date +"%d-%m-%Y %H:%M") 