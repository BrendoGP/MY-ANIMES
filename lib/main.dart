import 'package:aula/estado.dart';
import 'package:aula/telas/animes.dart';
import 'package:aula/telas/detalhes.dart';
//import 'package:my_animes/estado.dart';
//import 'package:my_animes/telas/animes.dart';
//import 'package:my_animes/telas/detalhes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => EstadoApp(),
        child: MaterialApp(
          title: "My Animes",
          theme: ThemeData(
              colorScheme: const ColorScheme.light(), useMaterial3: true),
          home: const Tela(),
        ));
  }
}//App

class Tela extends StatefulWidget {
  const Tela({super.key});
  @override
  State<Tela> createState() => _TelaState();
}//Tela

class _TelaState extends State<Tela> {
  void _exibirComoRetrato() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
  
  @override
  Widget build(BuildContext context) {
    _exibirComoRetrato();

    estadoApp = context.watch<EstadoApp>();

    Widget tela = const SizedBox.shrink();
    if (estadoApp.condicaoApp == CondicaoApp.mostrandoAnimes) {
      tela = const Animes();
    } else if (estadoApp.condicaoApp == CondicaoApp.mostrandoDetalhes) {
      tela = const Detalhes();
    }
    return tela;
  }
}//Estado da tela

void main() {
  runApp(const App());
}//main
