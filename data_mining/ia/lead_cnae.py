import peewee 
from models_lead import ModelLeadCnae

class LeadCnae(object):

    def __init__(self, lcna_cnae_codigo=None, lcna_lead_codigo=None):
        self._lcna_cnae_codigo = lcna_cnae_codigo
        self._lcna_lead_codigo = lcna_lead_codigo

    def incluir(self):
        retorno = ModelLeadCnae.insert(
            lcna_cnae_codigo=self._lcna_cnae_codigo,
            lcna_lead_codigo=self._lcna_lead_codigo
        )
        return retorno.execute()