import peewee 
from models_cliente import ModelCliente,ModelClienteCnae,ModelCnae

class Cliente(object):

    def __init__(self, clie_razao_social=None, clie_cnpj=None):
        self._clie_codigo = None
        self._clie_razao_social = clie_razao_social
        self._clie_cnpj = clie_cnpj
        self._clie_ativo = 1
        self._clie_execao = 0
        self._clie_lead_codigo = None
        self.ccna_cnae_codigo = None
        
    def lista(self):
        re_clientes = []
        query = (ModelCliente.select(ModelCliente,ModelClienteCnae,ModelCnae).
        join(ModelClienteCnae,on=(ModelCliente.clie_codigo == ModelClienteCnae.ccna_clie_codigo)).
        join(ModelCnae,on=(ModelClienteCnae.ccna_cnae_codigo == ModelCnae.cnae_codigo)))
        for cliente in query.namedtuples():
            re_clientes.append([cliente.clie_codigo, cliente.clie_cnpj,cliente.cnae_descricao,cliente.clie_execao])
        return re_clientes


    def incluir(self):    
        return ModelCliente.create(
            clie_razao_social=self._clie_razao_social,
            clie_cnpj=self._clie_cnpj
        )

    