// ignore_for_file: unnecessary_getters_setters

import 'package:aula/usuario.dart';
import 'package:flutter/material.dart';
//import 'package:my_animes/autenticador.dart';

late EstadoApp estadoApp;
enum CondicaoApp { mostrandoAnimes, mostrandoDetalhes }

class EstadoApp extends ChangeNotifier {

  CondicaoApp _condicaoApp = CondicaoApp.mostrandoAnimes; 
  late int _idAnime;
  Usuario? _usuario;

  void mostrarAnimes() {
    _condicaoApp = CondicaoApp.mostrandoAnimes;
    notifyListeners();
  }

  void mostrarDetalhes(int idAnime) {
    _condicaoApp = CondicaoApp.mostrandoDetalhes;
    _idAnime = idAnime;
    notifyListeners();
  }

  void onLogin(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void onLogout() {
    _usuario = null;
    notifyListeners();
  }

//getters e setters
  CondicaoApp get condicaoApp => _condicaoApp;

  int get idAnime => _idAnime;

  Usuario? get usuario => _usuario;
  set usuario(Usuario? usuario) {
    _usuario = usuario;
  }

}//EstadoApp