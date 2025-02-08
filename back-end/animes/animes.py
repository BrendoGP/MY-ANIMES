from flask import Flask, jsonify
from urllib.request import urlopen
import mysql.connector as mysql
import json

# Inicializa o serviço Flask
servico = Flask("animes")

DESCRICAO = "Serviço de listagem e cadastro de animes!"
VERSAO = "1.0"

# Configurações do banco de dados
SERVIDOR_BANCO = "banco"
USUARIO_BANCO = "root"
SENHA_BANCO = "admin"
NOME_BANCO = "animes"

# Função para obter conexão com o banco de dados
def get_conexao_com_bd():
    conexao = mysql.connect(
        host = SERVIDOR_BANCO,
        user = USUARIO_BANCO,
        password = SENHA_BANCO,
        database = NOME_BANCO
    )
    return conexao

# URL para obter a quantidade de curtidas de um anime
URL_LIKES = "http://likes:5000/likes_por_anime/"
def get_quantidade_de_likes(anime_id):
    url = f"{URL_LIKES}{anime_id}"
    resposta = urlopen(url)
    resposta = resposta.read()
    resposta = json.loads(resposta)
    return resposta["curtidas"]

# Rota principal que retorna informações sobre o serviço
@servico.get("/")
def get_info():
    return jsonify(descricao = DESCRICAO, versao = VERSAO)

# Rota para obter a lista de animes com paginação
@servico.get("/animes/<int:ultimo_anime>/<int:tamanho_da_pagina>")
def get_animes(ultimo_anime, tamanho_da_pagina):
    animes = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "SELECT feeds.id as anime_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "estudio.id as estudio_id, estudio.nome as nome_estudio, estudio.avatar, animes.nome as nome_anime, animes.sinopse, animes.nota as nota, " +
        "animes.url, animes.imagem " +
        "FROM feeds, animes, estudio " +
        "WHERE animes.id = feeds.anime " +
        "AND estudio.id = animes.estudio " +
        "AND feeds.id > " + str(ultimo_anime) + " ORDER BY anime_id ASC, data DESC " +
        "LIMIT " + str(tamanho_da_pagina)
    )
    animes = cursor.fetchall()
    if animes:
        for anime in animes:
            anime["likes"] = get_quantidade_de_likes(anime["anime_id"])

    conexao.close()
    return jsonify(animes)

# Rota para buscar animes pelo nome com paginação
@servico.get("/animes/<int:ultimo_feed>/<int:tamanho_da_pagina>/<string:nome_do_anime>")
def find_animes(ultimo_feed, tamanho_da_pagina, nome_do_anime):
    animes = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "SELECT feeds.id as anime_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "estudio.id as estudio_id, estudio.nome as nome_estudio, estudio.avatar, animes.nome as nome_anime, animes.sinopse, animes.nota as nota, " +
        "animes.url, animes.imagem " +
        "FROM feeds, animes, estudio " +
        "WHERE animes.id = feeds.anime " +
        "AND estudio.id = animes.estudio " +
        "AND animes.nome LIKE '%" + nome_do_anime + "%' "  +
        "AND feeds.id > " + str(ultimo_feed) + " ORDER BY anime_id ASC, data DESC " +
        "LIMIT " + str(tamanho_da_pagina)
    )
    animes = cursor.fetchall()
    if animes:
        for anime in animes:
            anime["curtidas"] = get_quantidade_de_likes(anime['anime_id'])

    conexao.close()
    return jsonify(animes)

# Rota para buscar informações de um anime específico
@servico.get("/anime/<int:id>")
def find_anime(id):
    anime = {}

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "SELECT feeds.id as anime_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "estudio.id as estudio_id, estudio.nome as nome_estudio, estudio.avatar, animes.nome as nome_anime, animes.sinopse, animes.nota as nota, " +
        "animes.url, animes.imagem " +
        "FROM feeds, animes, estudio " +
        "WHERE animes.id = feeds.anime " +
        "AND estudio.id = animes.estudio " +
        "AND feeds.id = " + str(id)
    )
    anime = cursor.fetchone()
    if anime:
        anime["curtidas"] = get_quantidade_de_likes(id)

    conexao.close()
    return jsonify(anime)

# Inicia o serviço Flask se o script for executado diretamente
if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)
