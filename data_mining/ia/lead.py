from models_lead import ModelLead

class Lead(object):

    def __init__(self, lead_razao_social=None, lead_cnpj=None,lead_porcentagem=None,lead_endereco=None,lead_cnae_codigo=1):
        self._lead_codigo = None;
        self._lead_razao_social = lead_razao_social
        self._lead_cnpj = lead_cnpj
        self._lead_porcentagem = lead_porcentagem
        self._lead_endereco = lead_endereco        
        self._lead_ativo = 1;
          
    def lista(self):
        re_leads = [];
        for lead in ModelLead.select():
            re_leads.append([lead.lead_codigo, lead.lead_cnpj])
        return re_leads

    def incluir(self):
        cep = str(self._lead_endereco[4]).replace('.','').replace('-','')
        retorno = ModelLead.insert(
            lead_razao_social=self._lead_razao_social,
            lead_cnpj=self._lead_cnpj,
            lead_porcentagem=self._lead_porcentagem,
            lead_rua=self._lead_endereco[0],
            lead_bairro=self._lead_endereco[1],
            lead_cidade=self._lead_endereco[2],
            lead_uf=self._lead_endereco[3],
            lead_cep=cep
        )
        return retorno.execute()