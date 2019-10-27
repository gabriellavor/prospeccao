import mysql.connector
from peewee import *

#database = MySQLDatabase('scorelea_prospeccao', user='root', password='1234',host='localhost', port=3306)
database = MySQLDatabase('scorelea_prospeccao', user='scorelea_usuario', password='scorelead',host='scorelead.com.br', port=3306)
class ModelCnae(Model):
    cnae_codigo = IntegerField(primary_key=True,unique=True)
    cnae_codigo_cnae = CharField()
    cnae_descricao = CharField()
    class Meta:
        database = database
        db_table = 'cnae'

class ModelLead(Model):
    lead_codigo = IntegerField(primary_key=True,unique=True)
    lead_razao_social = CharField(unique=True)
    lead_cnpj = CharField()
    lead_ativo = IntegerField(default=1)
    lead_porcentagem = DecimalField(15,12)
    lead_rua = CharField()
    lead_bairro = CharField()
    lead_cidade = CharField()
    lead_uf = CharField()
    lead_cep = CharField()
    class Meta:
        database = database
        db_table = 'lead'

class ModelLeadCnae(Model):
    lcna_cnae_codigo = ForeignKeyField(ModelCnae,db_column='lcna_cnae_codigo')
    lcna_lead_codigo = ForeignKeyField(ModelLead,db_column='lcna_lead_codigo')
    class Meta:
        database = database
        db_table = 'lead_cnae'

class ModelTipoContato(Model):
    tcon_codigo = IntegerField(primary_key=True,unique=True)
    tcon_descricao = CharField()
    class Meta:
        database = database
        db_table = 'tipo_contato'

class ModelContato(Model):
    cont_lead_codigo = ForeignKeyField(ModelLead,db_column='cont_lead_codigo')
    cont_tcon_codigo = ForeignKeyField(ModelTipoContato,db_column='cont_tcon_codigo')
    cont_descricao = CharField()
    class Meta:
        database = database
        db_table = 'contato'

class ModelTermo(Model):
    term_codigo = IntegerField(primary_key=True,unique=True)
    term_descricao = CharField()
    class Meta:
        database = database
        db_table = 'termo'

class ModelConfiguracao(Model):
    conf_codigo = IntegerField(primary_key=True,unique=True)
    conf_porcentagem = IntegerField()
    class Meta:
        database = database
        db_table = 'configuracao'

