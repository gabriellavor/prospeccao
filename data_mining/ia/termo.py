import peewee 
from models_lead import ModelTermo

class Termo(object):

    def __init__(self, term_descricao=None):
        self.term_descricao = term_descricao

    def lista(self):
        termo = [];
        for termos in ModelTermo.select():
            termo.append([termos.term_descricao])
        return termo
