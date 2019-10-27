import peewee 
from models_lead import ModelConfiguracao

class Configuracao(object):

    def __init__(self, conf_porcentagem=None):
        self._conf_codigo = None;
        self._conf_porcentagem = conf_porcentagem

    def retorna_porcentagem(self):
        conf = ModelConfiguracao.select()
        return conf[0].conf_porcentagem