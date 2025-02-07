// ignore_for_file: unnecessary_getters_setters

class Usuario {
  //variáveis
  String? _nome;
  String? _email;

  //construtor
  Usuario(String? nome, String? email) {
    _nome = nome;
    _email = email;
  }

  //getters & setters
  String? get nome => _nome;
  set nome(String? nome) {
    _nome = nome;
  }

  String? get email => _email;
  set email(String? email) {
    _email = email;
  }
}
