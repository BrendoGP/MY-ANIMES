import unittest
import urllib.request
import sys
import json

# URLs para acessar os endpoints de comentários
URL_COMENTARIOS = "http://localhost:5002/comentarios"
URL_ADICIONAR_COMENTARIO = "http://localhost:5002/adicionar"
URL_REMOVER_COMENTARIO = "http://localhost:5002/remover"

TAMANHO_DA_PAGINA = 4
NOVO_COMENTARIO = "TESTE_DE_COMENTÁRIO_TESTE_DE_COMENTÁRIO"

class TesteComentarios(unittest.TestCase):

    # Função para acessar uma URL e retornar os dados como string
    def acessar(self, url):
        resposta = urllib.request.urlopen(url)
        dados = resposta.read()

        return dados.decode("utf-8")

    # Função para enviar uma requisição HTTP com um método específico (POST, DELETE)
    def enviar(self, url, metodo):
        requisicao = urllib.request.Request(url, method=metodo)
        resposta = urllib.request.urlopen(requisicao)
        dados = resposta.read()
        return dados.decode("utf-8")

    # Teste para verificar o carregamento preguiçoso (lazy loading) dos comentários
    def testar_01_lazy_loading(self):
        dados = self.acessar(f"{URL_COMENTARIOS}/1/{sys.maxsize}/{TAMANHO_DA_PAGINA}")
        comentarios = json.loads(dados)

        self.assertLessEqual(len(comentarios), TAMANHO_DA_PAGINA)
        for comentario in comentarios:
            # Verifica se todos os comentários pertencem ao anime com ID 1
            self.assertEqual(comentario['anime_id'], 1)

    # Teste para enviar um novo comentário
    def testar_02_enviar_comentario(self):
        nome = urllib.parse.quote("brendo gomes")
        comentario = urllib.parse.quote(NOVO_COMENTARIO)

        resposta = self.enviar(f"{URL_ADICIONAR_COMENTARIO}/1/{nome}/brendogomes@gmail.com/{comentario}", "POST")
        resposta = json.loads(resposta)
        self.assertEqual(resposta['situacao'], "ok")

        dados = self.acessar(f"{URL_COMENTARIOS}/1/{sys.maxsize}/{TAMANHO_DA_PAGINA}")
        comentarios = json.loads(dados)

        # Verifica se o comentário mais recente é o novo comentário
        self.assertEqual(comentarios[0]['comentario'], NOVO_COMENTARIO)

    # Teste para remover um comentário
    def testar_03_remover_comentario(self):
    
        dados = self.acessar(f"{URL_COMENTARIOS}/1/{sys.maxsize}/{TAMANHO_DA_PAGINA}")
        comentarios = json.loads(dados)
        comentario_id = comentarios[0]['comentario_id']

        resposta = self.enviar(f"{URL_REMOVER_COMENTARIO}/{comentario_id}", "DELETE")
        resposta = json.loads(resposta)

        self.assertEqual(resposta['situacao'], "ok")
