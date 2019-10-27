import mysql.connector
from peewee import *

#database = MySQLDatabase('scorelea_prospeccao', user='root', password='1234',host='localhost', port=3306)
database = MySQLDatabase('scorelea_prospeccao', user='scorelea_usuario', password='scorelead',host='scorelead.com.br', port=3306)

class ModelCliente(Model):
    clie_codigo = IntegerField(primary_key=True,unique=True)
    clie_razao_social = CharField()
    clie_cnpj = CharField()
    clie_ativo = IntegerField(default=1)
    clie_execao = IntegerField()
    #clie_lead_codigo = peewee.IntegerField(default=null);

    class Meta:
        database = database
        db_table = 'cliente'

class ModelCnae(Model):
    cnae_codigo = IntegerField(primary_key=True,unique=True)
    cnae_codigo_cnae = CharField()
    cnae_descricao = CharField()
    class Meta:
        database = database
        db_table = 'cnae'

class ModelClienteCnae(Model):
    ccna_cnae_codigo = ForeignKeyField(ModelCnae,db_column='ccna_cnae_codigo')
    ccna_clie_codigo = ForeignKeyField(ModelCliente,db_column='ccna_clie_codigo')
    class Meta:
        primary_key = False
        database = database
        db_table = 'cliente_cnae'