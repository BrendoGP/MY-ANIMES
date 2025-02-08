import unittest
import urllib.request
import json

URL_ANIMES = "http://localhost:5001/animes"
URL_ANIME = "http://localhost:5001/anime"

TAMANHO_DA_PAGINA = 3
NOME_DO_ANIME = "Naruto"

class TesteAnimes(unittest.TestCase):

    def acessar(self, url):
        resposta = urllib.request.urlopen(url)
        dados = resposta.read()
        return dados.decode("utf-8")
        
    def testar_01_lazy_loading(self):
        dados = self.acessar(f"{URL_ANIMES}/0/{TAMANHO_DA_PAGINA}")
        animes = json.loads(dados)

        self.assertLessEqual(len(animes), TAMANHO_DA_PAGINA)
        self.assertEqual(animes[TAMANHO_DA_PAGINA - 1]['anime_id'], TAMANHO_DA_PAGINA)

        dados = self.acessar(f"{URL_ANIMES}/3/{TAMANHO_DA_PAGINA}")
        animes = json.loads(dados)

        self.assertLessEqual(len(animes), TAMANHO_DA_PAGINA)
        self.assertEqual(animes[TAMANHO_DA_PAGINA - 1]['anime_id'], TAMANHO_DA_PAGINA * 2)

    def testar_02_pesquisa_anime_pelo_id(self):
        dados = self.acessar(f"{URL_ANIME}/1")
        anime = json.loads(dados)

        self.assertEqual(anime['anime_id'], 1)

    def testar_03_pesquisa_anime_pelo_nome(self):
        dados = self.acessar(f"{URL_ANIMES}/0/{TAMANHO_DA_PAGINA}/{NOME_DO_ANIME}")
        animes = json.loads(dados)

        for anime in animes:
            self.assertIn(NOME_DO_ANIME, anime['nome_anime'].lower())