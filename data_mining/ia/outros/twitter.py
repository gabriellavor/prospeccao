
import tweepy
import csv
import time

consumer_key="0YAk2x5FzvZybZ1prK3CiphqW"
consumer_secret="LUTEPSh2KEqMVbNkOCFdFppfXXC22yX7HS0V8T5oUbTldkKBWy"
acess_token="2424445754-IV21rSs2egcqbd3nxhFczJmdP2jlhASt0W1ZBbw"
acess_token_secret="nQByM24q2yAw83Y2otCNQbrK9kzHQpDdk3am3XcfQ6lGD"

auth = tweepy.OAuthHandler(consumer_key,consumer_secret)
auth.set_access_token(acess_token,acess_token_secret)

api = tweepy.API(auth)

# Onde os dados coletados serao salvos
arq   = csv.writer(open("base_teste.csv","w"))
arq2  = open("base_teste_json.json","w")


row=[]
# lang e o parametro do idioma
statuses = tweepy.Cursor(api.search,q='#varejo').items()

while True:
    try:
        # Lendo os tweets
        status = statuses.next()
        # capturando so alguns parametros
        a = str(status.text.encode('utf-8'))
        row=str(status.user.screen_name),str(status.created_at),a,status.geo
        # Escrevendo no CSV
        arq.writerow(row)
        # Salvando o JSON
        arq2.write(str(status))
        arq2.write("\n")
       # exit()

    except tweepy.TweepError:
        # Devido a limitacao a cada 3200 tweets e necessario esperar 15 minutos
        print("wait 15 minutes...")
        time.sleep(60*15)
        continue
    except StopIteration:
        print("Acabou!!")
        break