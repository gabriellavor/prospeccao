from cliente import Cliente
import sys

#del sys.modules['Cliente'] 


clientes = Cliente()
lista = clientes.lista()

for cliente in lista:
        print cliente[0]
        print cliente[1]



clientes = Cliente('meu teste','12345678900111')
clientes.incluir()