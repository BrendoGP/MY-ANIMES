import unittest
import urllib.request
import json

# URLs para acessar os endpoints de animes
URL_ANIMES = "http://localhost:5001/animes"
URL_ANIME = "http://localhost:5001/anime"

TAMANHO_DA_PAGINA = 3
NOME_DO_ANIME = "Naruto"

class TesteAnimes(unittest.TestCase):

    # Função para acessar uma URL e retornar os dados como string
    def acessar(self, url):
        resposta = urllib.request.urlopen(url)
        dados = resposta.read()
        return dados.decode("utf-8")
        
    # Teste para verificar o carregamento preguiçoso (lazy loading) dos animes
    def testar_01_lazy_loading(self):
        dados = self.acessar(f"{URL_ANIMES}/0/{TAMANHO_DA_PAGINA}")
        animes = json.loads(dados)

        # Verifica se o número de animes retornados é menor ou igual ao tamanho da página
        self.assertLessEqual(len(animes), TAMANHO_DA_PAGINA)
        self.assertEqual(animes[TAMANHO_DA_PAGINA - 1]['anime_id'], TAMANHO_DA_PAGINA)

        dados = self.acessar(f"{URL_ANIMES}/3/{TAMANHO_DA_PAGINA}")
        animes = json.loads(dados)

        # Verifica se o número de animes retornados é menor ou igual ao tamanho da página
        self.assertLessEqual(len(animes), TAMANHO_DA_PAGINA)
        self.assertEqual(animes[TAMANHO_DA_PAGINA - 1]['anime_id'], TAMANHO_DA_PAGINA * 2)

    # Teste para pesquisar um anime pelo ID
    def testar_02_pesquisa_anime_pelo_id(self):
        dados = self.acessar(f"{URL_ANIME}/1")
        anime = json.loads(dados)

        self.assertEqual(anime['anime_id'], 1)

    # Teste para pesquisar animes pelo nome
    def testar_03_pesquisa_anime_pelo_nome(self):
        dados = self.acessar(f"{URL_ANIMES}/0/{TAMANHO_DA_PAGINA}/{NOME_DO_ANIME}")
        animes = json.loads(dados)

        for anime in animes:
            self.assertIn(NOME_DO_ANIME, anime['nome_anime'].lower())