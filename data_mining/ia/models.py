import mysql.connector
from peewee import *

#database = MySQLDatabase('prospeccao', user='root', password='1234',host='db', port=3306)
database = MySQLDatabase('scorelea_prospeccao', user='scorelea_usuario', password='scorelead',host='scorelead.com.br', port=3306)

class ModelCliente(Model):
        clie_codigo = IntegerField(primary_key=True,unique=True)
        clie_razao_social = CharField()
        clie_cnpj = CharField()
        clie_ativo = IntegerField(default=1)
        #clie_lead_codigo = peewee.IntegerField(default=null);

        class Meta:
                database = database
                db_table = 'cliente'

class ModelLead(Model):
        lead_codigo = IntegerField(primary_key=True,unique=True)
        lead_razao_social = CharField()
        lead_cnpj = CharField()
        lead_ativo = IntegerField(default=1)

        class Meta:
                database = database
                db_table = 'lead'

if __name__ == "__main__":
    try:
        ModelCliente.create_table()
    except peewee.OperationalError:
        print "Cliente table already exists!"
