import peewee 
from models_lead import ModelCnae

class Cnae(object):

    def retorna_codigo_cnae(self,cnae):
        novo_cnae = cnae[:7]+'/'+cnae[8:]
        retorno = (ModelCnae.select().where(ModelCnae.cnae_codigo_cnae == novo_cnae).limit(1))
        if len(retorno) > 0:
            return retorno[0]
        else:
            return 1