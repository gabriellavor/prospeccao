from termo import Termo
import math

termos = Termo().lista()
texto = ''
i=1
for item in termos:    
    num = math.trunc(i/10)
    arquivo = open('/home/sistemas/prospeccao/data_mining/termos/termos'+str(num)+'.txt', 'w')
    texto = texto + item[0] + ';'    
    arquivo.write(texto)
    arquivo.close()
    i+=1
    if( (math.trunc(i/10) / (i/10)) == 1):
        texto = ''