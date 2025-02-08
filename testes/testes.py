import unittest
from teste_animes import *
from teste_comentarios import *

if __name__ == "__main__":
    carregador = unittest.TestLoader()
    testes = unittest.TestSuite()

    testes.addTest(carregador.loadTestsFromTestCase(TesteAnimes))
    testes.addTest(carregador.loadTestsFromTestCase(TesteComentarios))

    executor = unittest.TextTestRunner()
    executor.run(testes)