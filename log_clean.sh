#!/bin/bash

#########################################
# Script desenvolvido por Sérgio Cabral #
# Para Backup e limpeza de logs         #
#########################################

LANG=pt_BR.UTF8
DATALOG=$(date +%Y-%m-%d)
SERVER=$(hostname)

export AWS_ACCESS_KEY_ID=AKIAUHHEWN7UJBHRCJNF
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=us-east-1

cd /var/log/m2m

# Realizando Upload para o S3
for file in *.log*;
do
        aws s3 cp $file s3://sonda-api-logs/$SERVER/$DATALOG/
done

# Removendo rotações de log
rm *.txt
rm *.gz
rm *.log.*
rm m2m-*[0-9].log
# Limpando conteudo dos arquivos com mais de 5MB
#find -size +5M | xargs -i bash -c "> {}"
find -size +5M -exec > {} \;
