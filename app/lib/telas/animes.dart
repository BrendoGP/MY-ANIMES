//import 'dart:convert';
import 'package:aula/autenticador.dart';
import 'package:aula/componentes/cartaoanime.dart';
import 'package:aula/estado.dart';
//import 'package:my_animes/autenticador.dart';
//import 'package:my_animes/componentes/cartaoanime.dart';
//import 'package:my_animes/estado.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flat_list/flat_list.dart';
import 'package:toast/toast.dart';

import '../api/api.dart';

// Classe principal da tela de animes, configurada como um widget com estado.
class Animes extends StatefulWidget {
  const Animes({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimesState();
  }
}

const int tamanhoPagina = 4;

class _AnimesState extends State<Animes> {
  
  List<dynamic> _animes = [];


  final ScrollController _controladorListaAnimes = ScrollController();
  final TextEditingController _controladorDoFiltro = TextEditingController();

  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;

  // ignore: unused_field
  String _filtro = "";

  late ServicoAnimes _servicoAnimes;
  int _ultimoAnime = 0;

  @override
  void initState() {
    super.initState();

    ToastContext().init(context);
    _servicoAnimes = ServicoAnimes();

    _controladorListaAnimes.addListener(() {
      if (_controladorListaAnimes.position.pixels == _controladorListaAnimes.position.maxScrollExtent) {
          _carregarAnimes();}
    });
     _carregarAnimes();
     _recuperarUsuario();
  }

void _recuperarUsuario() {
    Autenticador.recuperarUsuario().then((usuario) => estadoApp.onLogin(usuario!));
  }

  // Filtra e carregar os animes.
  void _carregarAnimes() {
    _servicoAnimes
        .getAnimes(_ultimoAnime, tamanhoPagina)
        .then((animes) {
      setState(() {
        if (animes.isNotEmpty) {
          _ultimoAnime = animes.last["anime_id"];
        }
        _animes.addAll(animes);
      });
    });
  } //_carregarAnime

  // Atualiza a lista de animes reiniciando a paginação.
  Future<void> _atualizarAnimes() async {
    _animes = [];
    _ultimoAnime = 0;
    _controladorDoFiltro.text = "";
    _filtro = "";
    _carregarAnimes();
  }

  void _aplicarFiltro(String filtro) {
    _filtro = filtro;
    _carregarAnimes();
  }

  @override
  Widget build(BuildContext context) {
    bool usuarioLogado = estadoApp.usuario != null;

    return Scaffold(
        appBar: AppBar(actions: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 60, right: 20),
                  child: TextField(
                    controller: _controladorDoFiltro,
                    onSubmitted: (filtro) {
                      _aplicarFiltro(filtro);
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search)),
                  ))),
            usuarioLogado
                ? IconButton(
                    onPressed: () {
                      Autenticador.logout().then((_){
                      setState(() {
                        estadoApp.onLogout();
                      });

                      Toast.show("Você não está mais conectado",
                          duration: Toast.lengthLong, gravity: Toast.bottom);
                    });
                    },
                    icon: const Icon(Icons.logout))
                : IconButton(
                    onPressed: () {
                      Autenticador.login().then((usuario) {
                      
                      setState(() {
                        estadoApp.onLogin(usuario);
                      });

                      Toast.show("Você foi conectado com sucesso",
                          duration: Toast.lengthLong, gravity: Toast.bottom);
                    });
                    },
                    icon: const Icon(Icons.login))
          ],
        ),
        body: RefreshIndicator(
            color: Colors.blueAccent,
            onRefresh: () => _atualizarAnimes(),
            child: GridView.builder(
                controller: _controladorListaAnimes,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 0.5,
                ),
                itemCount: _animes.length,
                itemBuilder: (context, index) {
                  return AnimeCartao(anime: _animes[index]);
                })));
  }
}