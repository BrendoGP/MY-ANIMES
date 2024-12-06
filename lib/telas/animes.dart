import 'dart:convert';
import 'package:aula/autenticador.dart';
import 'package:aula/componentes/cartaoanime.dart';
import 'package:aula/estado.dart';
//import 'package:my_animes/autenticador.dart';
//import 'package:my_animes/componentes/cartaoanime.dart';
//import 'package:my_animes/estado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flat_list/flat_list.dart';
import 'package:toast/toast.dart';

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
  late dynamic _feedEstatico;
  List<dynamic> _animes = [];

  int _proximaPagina = 1;
  bool _carregando = false;

  late TextEditingController _controladorFiltragem;
  String _filtro = "";

  @override
  void initState() {
    super.initState();

    ToastContext().init(context);

    _controladorFiltragem = TextEditingController();
    _lerFeedEstatico();
  }

  // Carrega o feed estático de animes a partir de um arquivo JSON.
  Future<void> _lerFeedEstatico() async {
    final String conteudoJson =
        await rootBundle.loadString("lib/recursos/json/feed.json");
    _feedEstatico = await json.decode(conteudoJson);
    _carregarAnimes();
  }

  // Filtra ou pagina os animes dependendo do estado do filtro.
  void _carregarAnimes() {

    setState(() { _carregando = true; });
    var maisAnimes = [];

    if (_filtro.isNotEmpty) {
        _feedEstatico["animes"].where((item) {
        String nome = item["anime"]["nome"];

        return nome.toLowerCase().contains(_filtro.toLowerCase());
      }).forEach((item) { maisAnimes.add(item); });
      } else {
        maisAnimes = _animes;
        final totalAnimesParaCarregar = _proximaPagina * tamanhoPagina;

        if (_feedEstatico["animes"].length >= totalAnimesParaCarregar) {
        maisAnimes = _feedEstatico["animes"].sublist(0, totalAnimesParaCarregar); }
      }

    setState(() {
      _animes = maisAnimes;
      _proximaPagina = _proximaPagina + 1;
      _carregando = false; });
      
  }//_carregarAnime

  // Atualiza a lista de animes reiniciando a paginação.
  Future<void> _atualizarAnimes() async {
    _animes = [];
    _proximaPagina = 1;
    _carregarAnimes();
  }

  @override
  Widget build(BuildContext context) {
    bool usuarioLogado = estadoApp.usuario != null;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 60, right: 20),
                    child: TextField(
                      controller: _controladorFiltragem,
                      onSubmitted: (descricao) {
                        _filtro = descricao;

                        _atualizarAnimes();
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
        body: FlatList(
            data: _animes,
            numColumns: 2,
            loading: _carregando,
            onRefresh: () {
              _filtro = "";
              _controladorFiltragem.clear();

              return _atualizarAnimes();
            },
            onEndReached: () => _carregarAnimes(), // !!!! lazy loading !!!!
            buildItem: (item, int indice) {
              return SizedBox(height: 400, child: AnimeCartao(anime: item));
            }));
  }
}
