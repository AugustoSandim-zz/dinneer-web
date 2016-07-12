# Dinneer Web
---------------

O Dinneer é um site que conecta pessoas que amam novas experiências gastronômicas com anfitriões que oferecem almoços e jantares exclusivos em suas casas em todo o Brasil. A plataforma já nasce na esteira do alto desemprego dos brasileiros. Segundo dados do Instituto Brasileiro de Geografia e Estatística (IBGE), a taxa de desemprego no brasil cresceu 8,5% na média do ano passado. Em compensação o mercado de alimentação no Brasil chega a 67 Bilhões.
A ideia surgiu da observação do fundador Flavio Estevam nas redes sociais, principalmente Facebook e Instagram que diariamente são invadidas por fotos de comida, e que os comentários incluíam muitos convites para experimentar os pratos. Estevam também se inspirou no site estrangeiro Airbnb.


## Instalação do Projeto
------------------------

### Dependências

 - Ruby v2.3.1
     - Caso não tenha Ruby intalado em sua máquina, recomendamos o uso do [RVM](https://rvm.io/) para a instalação do mesmo.
 - Rails v4.2.6
 - MySQL
 - NodeJs (Utilizado para tratamento de assets pelo Sprockets)
 - Git e Git Flow
 
**Download**

Acesse via terminal o local dos seus projetos e faça o download do repositório.
```bash
git clone https://AugustoSandim@bitbucket.org/dinneer/dinneer-web.git
```

Para utilização do ambiente de desenvolvimento configure o Git Flow.
```bash
$ sudo apt-get install git-flow
$ git flow init
```
Pressione Enter para todas as opções que serão exibidas. Depois disso você já estara na branch de development.

Caso opte por não utilizar Git Flow, é necessário fazer o download da branch `develop` remota.

**Configuração do Gemset**

Dentro da pasta do projeto, crie os arquivos `.ruby-version` e `.ruby-gemset` e depois entre novamente na pasta para carregar as novas configurações.
```bash
$ echo "ruby-2.3.1" > .ruby-version
$ echo "dinneer-web" > .ruby-gemset
$ cd .
```

**Instalação das dependencias**

A ferramenta `bundle` instalará todas as gems que foram definidas no Gemset do projeto.
```bash
$ bundle install
```

**Configuração do banco de dados**

Primeiramente é necessário criar o arquivo de setup de banco: `config/database.yml`. 
```bash
$ touch config/database.yml
```

Depois copie o conteúdo do arquivo de exemplo `config/database.example.yml`, cole no novo arquivo e altere o usuário e senha de acordo com seu MySQL local.

Por fim, crie o banco de dados e rode as migrations

```bash
$ rake db:create db:migrate db:seed
```

**Testes**

Utilizamos o framework de testes Rspec para execução de testes.

```bash
$ rspec
```

**Start do servidor**
```bash
$ rails s
```
