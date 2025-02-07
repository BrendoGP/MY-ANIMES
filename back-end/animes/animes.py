from flask import Flask, jsonify
from urllib.request import urlopen
import mysql.connector as mysql
import json

servico = Flask("animes")

DESCRICAO = "serviço de listagem e cadastro de animes!"
VERSAO = "1.0"

SERVIDOR_BANCO = "banco"
USUARIO_BANCO = "root"
SENHA_BANCO = "admin"
NOME_BANCO = "animes"

def get_conexao_com_bd():
    conexao = mysql.connect(
        host = SERVIDOR_BANCO,
        user = USUARIO_BANCO,
        password = SENHA_BANCO,
        database = NOME_BANCO
    )

    return conexao

URL_LIKES = "http://likes:5000/likes_por_produto/"
def get_quantidade_de_likes(produto_id):
    url = f"{URL_LIKES}{produto_id}"
    resposta = urlopen(url)
    resposta = resposta.read()
    resposta = json.loads(resposta)
    
    return resposta["curtidas"]

@servico.get("/")
def get_info():
    return jsonify(descricao = DESCRICAO, versao = VERSAO)

@servico.get("/animes/<int:ultimo_produto>/<int:tamanho_da_pagina>")
def get_animes(ultimo_produto, tamanho_da_pagina):
    animes = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "SELECT feeds.id as produto_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "empresas.id as empresa_id, empresas.nome as nome_empresa, empresas.avatar, animes.nome as nome_produto, animes.descricao, FORMAT(animes.preco, 2) as preco, " +
        "animes.url, animes.imagem1, IFNULL(animes.imagem2, '') as imagem2, IFNULL(animes.imagem3, '') as imagem3 " +
        "FROM feeds, animes, empresas " +
        "WHERE animes.id = feeds.produto " +
        "AND empresas.id = animes.empresa " +
        "AND feeds.id > " + str(ultimo_produto) + " ORDER BY produto_id ASC, data DESC " +
        "LIMIT " + str(tamanho_da_pagina)
    )
    animes = cursor.fetchall()
    if animes:
        for produto in animes:
            produto["likes"] = get_quantidade_de_likes(produto["produto_id"])

    conexao.close()

    return jsonify(animes)

@servico.get("/animes/<int:ultimo_feed>/<int:tamanho_da_pagina>/<string:nome_do_produto>")
def find_animes(ultimo_feed, tamanho_da_pagina, nome_do_produto):
    animes = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "select feeds.id as produto_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "empresas.id as empresa_id, empresas.nome as nome_empresa, empresas.avatar, animes.nome as nome_produto, animes.descricao, FORMAT(animes.preco, 2) as preco, " +
        "animes.url, animes.imagem1, IFNULL(animes.imagem2, '') as imagem2, IFNULL(animes.imagem3, '') as imagem3 " +
        "FROM feeds, animes, empresas " +
        "WHERE animes.id = feeds.produto " +
        "AND empresas.id = animes.empresa " +
        "AND animes.nome LIKE '%" + nome_do_produto + "%' "  +
        "AND feeds.id > " + str(ultimo_feed) + " ORDER BY produto_id ASC, data DESC " +
        "LIMIT " + str(tamanho_da_pagina)
    )
    animes = cursor.fetchall()
    if animes:
        for produto in animes:
            produto["curtidas"] = get_quantidade_de_likes(produto['produto_id'])

    conexao.close()

    return jsonify(animes)

@servico.get("/produto/<int:id>")
def find_produto(id):
    produto = {}

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "select feeds.id as produto_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "empresas.id as empresa_id, empresas.nome as nome_empresa, empresas.avatar, animes.nome as nome_produto, animes.descricao, FORMAT(animes.preco, 2) as preco, " +
        "animes.url, animes.imagem1, IFNULL(animes.imagem2, '') as imagem2, IFNULL(animes.imagem3, '') as imagem3 " +
        "FROM feeds, animes, empresas " +
        "WHERE animes.id = feeds.produto " +
        "AND empresas.id = animes.empresa " +
        "AND feeds.id = " + str(id)
    )
    produto = cursor.fetchone()
    if produto:
        produto["curtidas"] = get_quantidade_de_likes(id)

    conexao.close()

    return jsonify(produto)


if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)