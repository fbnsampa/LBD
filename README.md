# LBD
Este projeto foi criado para o trabalho semestral da disciplina de Laboratório de Banco de Dados do curso de Sistemas de Informação da EACH-USP.

## Arguivos:
* tables.sql - cria as tabelas do schema
* test.sql - popula com tuplas de teste
* clear.sql - comando de limpar schema public
* datafiller.py - ferramenta para criação de tuplas de teste

## População de tabelas
O arguivo tables.sql contém sintaxe para uso com a ferramenta [datafiller](https://www.cri.ensmp.fr/people/coelho/datafiller.html)

A versão do datafiller clonada neste repositório contém uma mudança no código para suportar campos do tipo MONEY.

A ferramenta foi usada para gerar o arquivo test.sql, que popula as tabelas descritas em tables.sql.

## Usagem
Para gerar e utilizar os arquivos, foram utilizados os seguintes comandos em ambiente Linux/bash:

* `cat clear.sql | psql postgres`: (opcional) limpa a schema para novas tabelas
* `cat tables.sql | psql postgres`: cria tabelas
* `python3 datafiller.py --size=1000 tables.sql > test.sql`: cria arquivo para população de 10000 tuplas por tabela
* `cat test.sql | psql postgres`: popula tabelas