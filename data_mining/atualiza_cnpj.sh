#!/bin/bash
CNPJ="/home/sistemas/prospeccao/data_mining/cnpjs/"
echo '----Executando remove cnpj errado '$(date +"%d-%m-%Y %H:%M") 
for arq in $(ls $CNPJ)
do
    QTD=$(egrep -c 'Too many request' /home/sistemas/prospeccao/data_mining/cnpjs/$arq)
    if [ "$QTD" -gt 0 ]
    then
        rm /home/sistemas/prospeccao/data_mining/cnpjs/$arq
    fi

    QTD=$(egrep -c 'atividade_principal' /home/sistemas/prospeccao/data_mining/cnpjs/$arq)
    if [ "$QTD" -gt 1 ]
    then
        rm /home/sistemas/prospeccao/data_mining/cnpjs/$arq
    fi
    
done
echo '----Executado remove cnpj errado '$(date +"%d-%m-%Y %H:%M") 