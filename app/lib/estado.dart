// ignore_for_file: unnecessary_getters_setters

import 'package:aula/usuario.dart';
import 'package:flutter/material.dart';
//import 'package:my_animes/autenticador.dart';

enum CondicaoApp { mostrandoAnimes, mostrandoDetalhes }

// Classe que gerencia o estado global do aplicativo e notifica widgets sobre mudanças.
class EstadoApp extends ChangeNotifier {
  
   // Define a condição inicial do aplicativo.
  CondicaoApp _condicaoApp = CondicaoApp.mostrandoAnimes;

  double _altura = 0, _largura = 0;
  double get altura => _altura;
  double get largura => _largura;

  late int _idAnime;
  int get idAnime => _idAnime;

  Usuario? _usuario;
  Usuario? get usuario => _usuario;

  void setDimensoes(double altura, double largura) {
    _altura = altura;
    _largura = largura;
  }

// Métodos para mudar o estado  das telas.
  void mostrarAnimes() {
    _condicaoApp = CondicaoApp.mostrandoAnimes;
    notifyListeners();
  }

  bool mostrandoAnimes() {
    return _condicaoApp == CondicaoApp.mostrandoAnimes;
  }

  void mostrarDetalhes(int idAnime) {
    _condicaoApp = CondicaoApp.mostrandoDetalhes;
    _idAnime = idAnime;
    notifyListeners();
  }

 // Método chamado ao realizar login,e logout atualizando o usuário.
  void onLogin(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void onLogout() {
    _usuario = null;
    notifyListeners();
  }
  
  bool mostrandoDetalhes() {
    return _condicaoApp == CondicaoApp.mostrandoDetalhes;
  }

}//EstadoApp

late EstadoApp estadoApp;