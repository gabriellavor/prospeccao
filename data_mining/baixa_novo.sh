#!/bin/bash
BAIXADOS="/home/sistemas/prospeccao/data_mining/baixados"
SITES="/home/sistemas/prospeccao/data_mining/sites"

echo '--Executando Baixa '$(date +"%d-%m-%Y %H:%M")
touch $SITES"/"links.txt
for nome in `ls $BAIXADOS`
do
    sed 's/>/>\n/g' $BAIXADOS"/"$nome | sed 's/<div class=\"srg\">//' | grep href | sed 's/.*href=\"//' | sed 's/\".*//' | sed 's/.*google//' | sed 's/.*blogger//' | sed 's/.*youtube//' | sed 's/.*pdf//' | sed 's/.*PDF//' |  uniq -u | grep ^http >> $SITES"/"links.txt
done
rm -R $BAIXADOS
mkdir $BAIXADOS
var=0
cd $SITES
for n in $(grep http links.txt)
do
    mkdir $var
    cd $var
    wget --reject jpg,png,flv,pdf,xls  --accept html --timeout 5 --connect-timeout 3 --read-time 3 --tries=2 -A ".html" $n 
    cd $SITES
    var=$((var + 1))
done
rm links.txt
cd ../
echo '--Executado Baixa '$(date +"%d-%m-%Y %H:%M")