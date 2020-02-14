# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Docker

É necessário criar os arquivos com as variáveis de ambiente antes de fazer build
da imagem então rodamos o comando:

```
# se for necessário edite os valores
cp .env.docker.sample .env.docker
```

Agora vamos buildar nossa imagem com o comando:

```
docker-compose build
```

Podemos rodar nosso projeto agora com um `docker-compose up` mas para
desenvolver é mais interessante termos um terminal para rodar `rspec`,
`rubocop`, ou até `rails server`.

Para isso use o comando:

```
# configuração de portas e rodando o serviço web com o comando bash
docker-compose run --service--ports web bash
```

Agora o docker sobe e fica parado esperando seus comandos, você pode rodar
bin/setup executar migrations ou qualquer outra coisa sem a necessidade de nada
na sua máquina. Lembre-se que interações com o git, desenvolvimento, entre
outras coisas fazemos fora do docker.
