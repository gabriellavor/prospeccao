# Prospecção de Cliente (Leads)
<h2>busca.sh </h2>
Responsavel por realizar a busca por possiveis sites
- O mesmo Realiza o carregamento dos termos a serem procurados pelo arquivo **"importa_termo"**

- O mesmo verifica o arquivo **"configuracoes.txt"** para identicar a quantidade de buscas devem ser por termo

- Grava estes sites baixados no formato json na pasta **"baixados"** , estes arquivos json possuem o link que deve ser acessado pelo proximo passo
<h2>baixa.sh </h2>
Responsavel por realizar grava baixar os sites

- O mesmo le a pasta **"baixados"** e faz o download da página para a pasta "sites"

<h2>procura_empresa.sh </h2>
- Responsavel por validar as empresas na receita e gravar o arquivo baixado da receita na pasta **"empresa"**

<h2>grava_lead.sh </h2>
- Responsavel por gravar os leads da pasta **"empresa"** no banco de dados