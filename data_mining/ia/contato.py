import peewee 
from models_lead import ModelContato

class Contato(object):

    def __init__(self, cont_lead_codigo=None, cont_tcon_codigo=None,cont_descricao=None):
        self._cont_lead_codigo = cont_lead_codigo
        self._cont_tcon_codigo = cont_tcon_codigo
        self._cont_descricao = cont_descricao
    

    def incluir(self):
        retorno = ModelContato.insert(
            cont_lead_codigo=self._cont_lead_codigo,
            cont_tcon_codigo=self._cont_tcon_codigo,
            cont_descricao=self._cont_descricao
        )
        return retorno.execute()