import csv
import re
import nltk
import string
import unicodedata
import sys
from sklearn import tree
reload(sys)
sys.setdefaultencoding('utf-8')
new_file = csv.reader(open('ia/dados.csv','r'),delimiter=";")

list_docs=[]
list_label=[]
#nltk.download('stopwords')
def remove_stop_words(text):
    regex = re.compile('[%s]' % re.escape(string.punctuation))
    a=[]
    words= text.split()
    for t in words:
        new_token = regex.sub(u'',t)
        if not new_token == u'':
            a.append(new_token)

    stopwords = nltk.corpus.stopwords.words('portuguese')
    content = [w for w in a if w.lower().strip() not in stopwords]        

    clean_text=[]
    for word in content:
        norm = unicodedata.normalize('NFKD',word)
        palavraSemAcento= u''.join([c for c in norm if not unicodedata.combining(c)])
        q = re.sub('[^a-zA-Z0-9 \\\]',' ',palavraSemAcento)
        clean_text.append(q.lower().strip())

    tokens = [t for t in clean_text if len(t)>2 and not t.isdigit()]    
    ct = ' '.join(tokens)
    return ct



for row in new_file:
    word = remove_stop_words(unicode(row[0]))
    pomar = ([word,row[1]])
    resultado = [row[1]]
    clf = tree.DecisionTreeClassifier()
    print pomar
    print resultado
    clf = clf.fit(pomar,resultado)


#resultado = clf.predict([('logistico',1)])
#print resultado
    