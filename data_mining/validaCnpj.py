#!/usr/bin/env python3
import json
import sys
import os.path
import shutil

def valida_cnpj(cnpj):
    'Recebe um CNPJ e retorna True se formato valido ou False se invalido'
    
    cnpj = parse_input(cnpj)
    if len(cnpj) != 14 or cnpj == "00000000000000":
        return False

    verificadores = cnpj[-2:]
    lista_validacao_um = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    lista_validacao_dois = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    'Calcular o primeiro digito verificador'
    soma = 0
    for numero, ind in zip(cnpj[:-1], range(len(cnpj[:-2]))):
        soma += int(numero) * int(lista_validacao_um[ind])

    soma = soma % 11
    digito_um = 0 if soma < 2 else 11 - soma

    'Calcular o segundo digito verificador'
    soma = 0
    for numero, ind in zip(cnpj[:-1], range(len(cnpj[:-1]))):
        soma += int(numero) * int(lista_validacao_dois[ind])

    soma = soma % 11
    digito_dois = 0 if soma < 2 else 11 - soma

    return verificadores == str(digito_um) + str(digito_dois)


def parse_input(i):
    'Retira caracteres de separacao do CNPJ'

    i = str(i)
    i = i.replace('.', '')
    i = i.replace(',', '')
    i = i.replace('/', '')
    i = i.replace('-', '')
    i = i.replace('\\', '')
    return i


if __name__ == '__main__':
    try:
        arq = open('/home/sistemas/prospeccao/data_mining/possivelcnpj.txt','r')
        texto = arq.readlines()

        
        n_text = []
        for linha in texto :
            
            if valida_cnpj(linha.replace('\n','')):
                arqr = open('/home/sistemas/prospeccao/data_mining/cnpjs.txt', 'r')
                texto_existente = arqr.readlines()
                possui = False
                for linha2 in texto_existente :
                    if(linha2.replace('\n','') == linha.replace('\n','')):
                        possui = True
                if(possui == False):
                    if(os.path.isfile('/home/sistemas/prospeccao/data_mining/cnpjs/'+linha.replace('\n','')+'.json') == False): 
                        arqw = open('/home/sistemas/prospeccao/data_mining/cnpjs.txt', 'w')
                        n_text = []
                        n_text = texto_existente
                        n_text.append(linha)
                        arqw.writelines(n_text)
                        arqw.close()
                    else:
                        shutil.copyfile('/home/sistemas/prospeccao/data_mining/cnpjs/'+linha.replace('\n','')+'.json', '/home/sistemas/prospeccao/data_mining/empresas/'+linha.replace('\n','')+'.json')
                arqr.close()            
        arq.close()
        os.remove('/home/sistemas/prospeccao/data_mining/possivelcnpj.txt')
    except:
        print('arquivo nao existe')