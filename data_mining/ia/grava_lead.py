#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Base de dados para treinamento
Esta base ira treinar o programa para 0 - medio,1 - Bom ,-1 ruim
"""
import nltk

import unicodedata
import json

from nltk.corpus import treebank

nltk.download('rslp')
nltk.download('stopwords')

from lead import Lead
from lead_cnae import LeadCnae
from cnae import Cnae
from contato import Contato
from cliente import Cliente
from configuracao import Configuracao

from unicodedata import normalize 

import os
#ler tabela de clintes
def ler_base():
        base = []
        clientes = Cliente().lista()
        for item in clientes:
                execao = str(not(item[3]))
                base.append((item[2].replace(',','').encode('utf-8'),execao.encode('utf-8')))
        return base
#ler tabela de clintes
def ler_dicionario(base):
        arquivo_txt = open('/home/sistemas/prospeccao/data_mining/dicionario_cnae.txt','r')
        for linha in arquivo_txt:
                n_linha = []
                if(linha != ''):                        
                        n_linha.append((linha.encode('utf-8'),'False'))
                        frases_stemmer = stemmer(n_linha)
                        compara = []
                        for x in frases_stemmer[0][0]:
                                compara = x
                        for b in base:
                                possui = False
                                for bc in b[0]:
                                        if(bc == compara):
                                                possui = True
                        if(possui == False):
                                base.append((compara,'False'))
        return base

def retirarCarecteres(palav):
        p = str(palav,'utf-8')
        p.replace(',','')
        return p


def stemmer(texto):
        stemmer = nltk.stem.RSLPStemmer()
        frases = []
        for (palavras,emocao) in texto:
                palav = retirarAcento(palavras)
                palav = retirarCarecteres(palav)
                comStemmer = [str(stemmer.stem(p)) for p in palav.split() if str(stemmer.stem(p)) not in stopwords and len(stemmer.stem(p)) > 2]
                if(type(emocao) == str):
                        frases.append((comStemmer,emocao))
                else:
                        frases.append((comStemmer,str(emocao,'utf-8')))
        return frases

def buscaPalavras(frases):
        todasPalavras = []
        for(palavras,emocao) in frases:
                if(len(palavras) > 2):
                        if(type(palavras) == str):
                                todasPalavras.append(palavras)
                        else:
                                todasPalavras.extend(palavras)
        return todasPalavras

def buscaFrequencia(palavras):
        palavras = nltk.FreqDist(palavras)
        return palavras

def buscaPalavrasUnicas(palavras):
        freq = frequencia.keys()
        return freq

def extratorPalavras(documento):
        doc = set(documento)
        caracteristicas = {}
        for palavras in palavrasUnicas:
                caracteristicas['%s' % palavras] = (palavras in doc)        
        return caracteristicas

def radical(texto):
        stemmer = nltk.stem.RSLPStemmer()
        frases = []
        for (palavras) in texto.split():
                palavras = str(palavras,'utf-8')
                comStemmer = [p for p in palavras.split()]
                frases.append(str(stemmer.stem(comStemmer[0])))
        return frases        

def retirarAcento(texto):
        if(type(texto) == str):
                return normalize('NFKD', texto).encode('ASCII','ignore')
        else:
                return normalize('NFKD', texto.decode('utf-8')).encode('ASCII','ignore')         

#ler arquivo
def ler_arquivo_atividades(arquivo,tipo='text'):
        try:
                arquivo_json = open('/home/sistemas/prospeccao/data_mining/empresas/'+str(arquivo),'r')
                dados_json = json.load(arquivo_json)
                if dados_json['status'] == 'OK':
                        atividades = dados_json['atividade_principal']
                        return atividades[0][tipo]
                else:
                        return False
        except:
                return False
        

def ler_arquivo_codigo_atividades(arquivo,tipo='code'):
        try:
                arquivo_json = open('/home/sistemas/prospeccao/data_mining/empresas/'+str(arquivo),'r')
                dados_json = json.load(arquivo_json)
                codigos = []
                if dados_json['status'] == 'OK':
                        atividades = dados_json['atividade_principal']
                        codigos.append(atividades[0][tipo])
                        atividades_secundarias = dados_json['atividades_secundarias']
                        for ativ in atividades_secundarias:
                                codigos.append(ativ[tipo])
                return codigos
        except:
                return False
        

def ler_arquivo(arquivo,tipo='nome'):
        try:
                arquivo_json = open('/home/sistemas/prospeccao/data_mining/empresas/'+str(arquivo),'r')
                dados_json = json.load(arquivo_json)
                if dados_json['status'] == 'OK':
                        return dados_json[tipo]
                else:
                        return False
        except:
                return False
        
                
def ler_pasta():
        for _, _, arquivo in os.walk('/home/sistemas/prospeccao/data_mining/empresas/'):
                return arquivo           

#Tratar palavra
def prepara_palavra(arquivo):
        teste = ler_arquivo_atividades(str(arquivo))
        if teste != False:
                nradical = radical(retirarAcento(teste))
                
                frases = []
                for (palavras) in nradical:
                        palav = retirarAcento(palavras)
                        palav = retirarCarecteres(palav)
                        if palav != '' and palav not in stopwords:
                                frases.append(palav)
                if not frases:
                        return False
                return extratorPalavras(frases)
        else:
                return False        

def retorna_codigo(arquivo,tipo):
        codigo = ler_arquivo_atividades(str(arquivo),tipo)
        if codigo != False:
                return codigo
        else:
                return False 

def retorna_nome(arquivo,tipo):
        retorno = ler_arquivo(str(arquivo),tipo)
        if retorno != False:
                return retorno
        else:
                return False

def prepara_telefone(telefone):
        return telefone.split('/') 

base = ler_base()
stopwords = nltk.corpus.stopwords.words('portuguese')
stopwords.append('geral')
stopwords.append('ativ')
stopwords.append('comerci')
stopwords.append('excet')
stopwords.append('nao')
stopwords.append('par')
stopwords.append('uso')
stopwords.append('produt')

conf = Configuracao().retorna_porcentagem()

if base:
        frases_stemmer = stemmer(base)
        frases_stemmer = ler_dicionario(frases_stemmer)
        frequencia = buscaFrequencia(buscaPalavras(frases_stemmer))      
        palavrasUnicas = buscaPalavrasUnicas(frequencia)
        
        base_completa = nltk.classify.apply_features(extratorPalavras,frases_stemmer)
        
        classificador = nltk.NaiveBayesClassifier.train(base_completa)
        
        #print(classificador.show_most_informative_features(30))
        arquivos = ler_pasta()
        #if(os.path.isfile('/home/sistemas/prospeccao/data_mining/executado_consulta_novo.txt') == True): 
        print('Executando Grava')
        #arq = open("/home/sistemas/prospeccao/data_mining/rodando_grava_lead.txt", "w")
        #arq.close()
        #os.remove('/home/sistemas/prospeccao/data_mining/executado_consulta_novo.txt')
        
        for arquivo in arquivos:
                try:   
                        novo = prepara_palavra(arquivo)
                        code = ler_arquivo_codigo_atividades(arquivo,'code')
                        nome = retorna_nome(arquivo,'nome')
                        email = retorna_nome(arquivo,'email')
                        endereco = []
                        endereco.append(retorna_nome(arquivo,'logradouro'))
                        endereco.append(retorna_nome(arquivo,'bairro'))
                        endereco.append(retorna_nome(arquivo,'municipio'))
                        endereco.append(retorna_nome(arquivo,'uf'))
                        endereco.append(retorna_nome(arquivo,'cep'))
                        
                        telefone = retorna_nome(arquivo,'telefone')
                        if(telefone):
                                telefones = prepara_telefone(telefone)
                        
                        if novo != False:
                                distribuicao = classificador.prob_classify(novo)
                                for classe in distribuicao.samples():
                                        print("%s: %f " % (classe,distribuicao.prob(classe)))
                                        #print(classificador.classify(novo))
                                        #print(distribuicao.prob(classe))
                                        if(classificador.classify(novo) == 'True' and distribuicao.prob(classe) * 100 > conf):
                                                if code[0] != '00.00-0-00':
                                                        porcentagem = float(distribuicao.prob(classe) * 100)
                                                        leads = Lead(nome,arquivo[:-5],porcentagem,endereco)
                                                        codigo_lead = leads.incluir()
                                                        
                                                        for codigo in code:
                                                                if codigo != '00.00-0-00':
                                                                        codigo_cnae = Cnae().retorna_codigo_cnae(codigo)
                                                                        lead_cnae = LeadCnae(codigo_cnae,codigo_lead)
                                                                        lead_cnae.incluir()
                                                        for tel in telefones:
                                                                if(tel != ''):
                                                                        contato = Contato(codigo_lead,1,tel)
                                                                        contato.incluir()
                                                        if(email != ''):
                                                                contato_email = Contato(codigo_lead,2,email)
                                                                contato_email.incluir()        
                        else:
                                print('Leitura invalida para arquivo '+arquivo)
                except:
                        print('cnpj ja existe')
        dir = os.listdir('/home/sistemas/prospeccao/data_mining/empresas')
        for file in dir:
                os.remove('/home/sistemas/prospeccao/data_mining/empresas/'+file)
        #os.remove('/home/sistemas/prospeccao/data_mining/rodando_grava_lead.txt')
else:
        print('Clientes nao cadastrados')
        