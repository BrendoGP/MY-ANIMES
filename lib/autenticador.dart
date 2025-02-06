// ignore_for_file: unnecessary_getters_setters

import 'package:aula/usuario.dart';

class Autenticador {
  static Future<Usuario> login() async {
    // final gUser = await GoogleSignIn().signIn();
    // final usuario = Usuario(gUser!.displayName, gUser.email);
    final usuario = Usuario("Brendo Gomes", "brendo.bgp1@gmail.com");

    return usuario;
  }

  static Future<Usuario?> recuperarUsuario() async {
    // Usuario? usuario;

    // final gSignIn = GoogleSignIn();
    // if (await gSignIn.isSignedIn()) {
    //   await gSignIn.signInSilently();

    //   final gUser = gSignIn.currentUser;
    //   if (gUser != null) {
    //     usuario = Usuario(gUser.displayName, gUser.email);
    //   }
    // }
    
    final usuario = Usuario("Brendo Gomes", "brendo.bgp1@gmail.com");

    return usuario;
  }

  static Future<void> logout() async {
    // await GoogleSignIn().signOut();
  }
}
