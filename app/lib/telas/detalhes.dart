//import 'dart:convert';
import 'package:aula/api/api.dart';
import 'package:aula/estado.dart';
//import 'package:my_animes/estado.dart';
//import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:toast/toast.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DetalhesState();
  }
} //Detalhes

//verificar como esta a situação do Anime
enum _EstadoAnime { naoVerificado, temAnime, semAnime }

const TAMANHO_DA_PAGINA = 4;

class _DetalhesState extends State<Detalhes> {
   _EstadoAnime _temAnime = _EstadoAnime.naoVerificado;
  late dynamic _anime;
  int _ultimoComentario = 0x7FFFFFFFFFFFFFFF;

  List<dynamic> _comentarios = [];
  bool _temComentarios = false;

  final TextEditingController _controladorNovoComentario =
      TextEditingController();
  final ScrollController _controladorListaAnimes = ScrollController();

  late PageController _controladorSlides;
  late int _slideSelecionado;

  late ServicoAnimes _servicoAnimes;
  late ServicoCurtidas _servicoCurtidas;
  late ServicoComentarios _servicoComentarios;

  bool _curtiu = false;

  @override
  void initState() {
    super.initState();

    ToastContext().init(context);

    _servicoAnimes = ServicoAnimes();
    _servicoCurtidas = ServicoCurtidas();
    _servicoComentarios = ServicoComentarios();

    _iniciarSlides();
    _carregarAnime();
    _carregarComentarios();
  }

  void _iniciarSlides() {
    _slideSelecionado = 0;
    _controladorSlides = PageController(initialPage: _slideSelecionado);
  }

// Verifica se tem anime para carregar ou não
  void _carregarAnime() {
   _servicoAnimes.findAnime(estadoApp.idAnime).then((anime) {
      _anime = anime;

      if (estadoApp.usuario != null) {
        _servicoCurtidas
            .curtiu(estadoApp.usuario!, estadoApp.idAnime)
            .then((curtiu) {
          setState(() {
            _temAnime = _anime != null
                ? _EstadoAnime.temAnime
                : _EstadoAnime.semAnime;
            _curtiu = curtiu;
          });
        });
      } else {
        setState(() {
          _temAnime = _anime != null
              ? _EstadoAnime.temAnime
              : _EstadoAnime.semAnime;
          _curtiu = false;
        });
      }
    });
  } //carregarAnime

//Carregar comentários do anime
  void _carregarComentarios() {
    _servicoComentarios
        .getComentarios(
            estadoApp.idAnime, _ultimoComentario, TAMANHO_DA_PAGINA)
        .then((comentarios) {
      _temComentarios = comentarios.isNotEmpty;

      if (_temComentarios) {
        _ultimoComentario = comentarios.last['comentario_id'];
      }

      setState(() {
        _comentarios = comentarios;
      });
    });
  } //carregarComentarios

  Widget _exibirMensagemAnimeInexistente() {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white10,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(children: [
                    Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text("My Animes"))
                  ]),
                  GestureDetector(
                      onTap: () {
                        estadoApp.mostrarAnimes();
                      },
                      child: const Icon(Icons.arrow_back))
                ])),
        body: const SizedBox.expand(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.error, size: 32, color: Colors.red),
          Text("anime inexistente :(",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red)),
          Text("selecione outro anime na tela anterior :)",
              style: TextStyle(fontSize: 14))
        ])));
  } //anime inexistente

  Widget _exibirMensagemComentariosInexistentes() {
    return const Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.error, size: 32, color: Colors.red),
      Text("não existem comentários :(",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red))
    ]));
  } // comentario inexistente

  Widget _exibirComentarios() {
    return ListView.builder(
            controller: _controladorListaAnimes,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _comentarios.length,
            itemBuilder: (context, index) {
              final comentario = _comentarios[index];
              String dataFormatada = DateFormat('dd/MM/yyyy HH:mm')
                  .format(DateTime.parse(comentario["data"]));
              bool usuarioLogadoComentou = estadoApp.usuario != null &&
                  estadoApp.usuario!.email == comentario["conta"];

              return SizedBox(
                  height: 90,
                  child: Dismissible(
                    key: Key(comentario["comentario_id"].toString()),
                    direction: usuarioLogadoComentou
                        ? DismissDirection.endToStart
                        : DismissDirection.none,
                    background: Container(
                        alignment: Alignment.centerRight,
                        child: const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Icon(Icons.delete, color: Colors.red))),
                    child: Card(
                        color: usuarioLogadoComentou
                            ? Colors.green[100]
                            : Colors.white,
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 6, left: 6),
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(comentario["comentario"],
                                      style: const TextStyle(fontSize: 12)))),
                          const Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, left: 6.0),
                                      child: Text(
                                        dataFormatada,
                                        style: const TextStyle(fontSize: 12),
                                      )),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        comentario["nome"],
                                        style: const TextStyle(fontSize: 12),
                                      )),
                                ],
                              )),
                        ])),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        setState(() {
                          _comentarios.removeAt(index);
                        });

                        showDialog(
                            context: context,
                            builder: (BuildContext contexto) {
                              return AlertDialog(
                                title: const Text("Deseja apagar o comentário?",
                                    style: TextStyle(fontSize: 14)),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _comentarios.insert(
                                              index, comentario);
                                        });

                                        Navigator.of(contexto).pop();
                                      },
                                      child: const Text("NÃO",
                                          style: TextStyle(fontSize: 14))),
                                  TextButton(
                                      onPressed: () {
                                        _removerComentario(
                                            comentario["comentario_id"]);

                                        Navigator.of(contexto).pop();
                                      },
                                      child: const Text("SIM",
                                          style: TextStyle(fontSize: 14)))
                                ],
                              );
                            });
                      }
                    },
                  ));
            }));
  }


 Future<void> _atualizarComentarios() async {
    _comentarios = [];
    _ultimoComentario = 0;

    _carregarComentarios();
  } 

  void _adicionarComentario() {
     _servicoComentarios
        .adicionar(estadoApp.idAnime, estadoApp.usuario!,
            _controladorNovoComentario.text)
        .then((resultado) {
      if (resultado["situacao"] == "ok") {
        Toast.show("comentário adicionado!",
            duration: Toast.lengthLong, gravity: Toast.bottom);

        _atualizarComentarios();
      }
    });
  }// adicionar comentario

  void _removerComentario(int idComentario) {
    _servicoComentarios.remover(idComentario).then((resultado) {
      if (resultado["situacao"] == "ok") {
        Toast.show("comentário removido com sucesso!!",
            duration: Toast.lengthLong, gravity: Toast.bottom);
      }
    });
  }//remover comentario

 List<String> _imagensDoSlide() {
    List<String> imagens = [];

    imagens.add(_anime["imagem"]);
    if ((_anime["imagem"] as String).isNotEmpty) {
      imagens.add(_anime["imagem"]);
    }
    if ((_anime["imagem"] as String).isNotEmpty) {
      imagens.add(_anime["imagem"]);
    }

    return imagens;
  }

  Widget _exibirAnime() {
    bool usuarioLogado = estadoApp.usuario != null;
    final slides = _imagensDoSlide();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(children: [
          Row(children: [
            Image.network(formatarCaminhoArquivo(_anime["avatar"]),
                width: 38),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Text(
                  _anime["estudio"],
                  style: const TextStyle(fontSize: 15),
                ))
          ]),
          const Spacer(),
          GestureDetector(
            onTap: () {
              estadoApp.mostrarAnimes();
            },
            child: const Icon(Icons.arrow_back, size: 30),
          )
        ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 230,
            child: Stack(children: [
              PageView.builder(
                itemCount: slides.length,
                controller: _controladorSlides,
                onPageChanged: (slide) {
                  setState(() {
                    _slideSelecionado = slide;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return Image.network(
                    formatarCaminhoArquivo(slides[pagePosition]),
                    fit: BoxFit.cover,
                  );
                },
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Column(children: [
                    usuarioLogado
                        ? IconButton(
                            onPressed: () {
                              if (_curtiu) {
                                _servicoCurtidas
                                    .descurtir(
                                        estadoApp.usuario!, estadoApp.idAnime)
                                    .then((resultado) {
                                  if (resultado["situacao"] == "ok") {
                                    Toast.show("avaliação removida",
                                        duration: Toast.lengthLong,
                                        gravity: Toast.bottom);

                                    setState(() {
                                      _carregarAnime();
                                    });
                                  }
                                });
                              } else {
                                _servicoCurtidas
                                    .curtir(
                                        estadoApp.usuario!, estadoApp.idAnime)
                                    .then((resultado) {
                                  if (resultado["situacao"] == "ok") {
                                    Toast.show("obrigado pela sua avaliação",
                                        duration: Toast.lengthLong,
                                        gravity: Toast.bottom);

                                    setState(() {
                                      _carregarAnime();
                                    });
                                  }
                                });
                              }
                            },
                            icon: Icon(_curtiu
                                ? Icons.favorite
                                : Icons.favorite_border),
                            color: Colors.red,
                            iconSize: 32)
                        : const SizedBox.shrink(),
                    IconButton(
                        onPressed: () {
                          final texto =
                              '${_anime["nome_anime"]}, Nota: ${_anime["nota"].toString()}';

                          FlutterShare.share(
                              title: "Meus Animes", text: texto);
                        },
                        icon: const Icon(Icons.share),
                        color: Colors.blue,
                        iconSize: 26)
                  ]))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: PageViewDotIndicator(
              currentItem: _slideSelecionado,
              count: 3,
              unselectedColor: Colors.black26,
              selectedColor: Colors.blue,
              duration: const Duration(milliseconds: 200),
              boxShape: BoxShape.circle,
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      _anime["nome_anime"],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    )),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(_anime["sinopse"],
                        style: const TextStyle(fontSize: 12))),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
                    child: Row(children: [
                      Text(
                        "Nota: ${_anime["nota"].toString()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                Text(
                                  _anime["curtidas"].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ]))
                    ]))
              ],
            ),
          ),
          const Center(
              child: Text(
            "Comentários",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )),
          usuarioLogado
              ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                      controller: _controladorNovoComentario,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 0.0),
                          ),
                          border: const OutlineInputBorder(),
                          hintStyle: const TextStyle(fontSize: 14),
                          hintText: 'Digite aqui seu comentário...',
                          suffixIcon: GestureDetector(
                              onTap: () {
                                _adicionarComentario();
                              },
                              child: const Icon(Icons.send,
                                  color: Colors.black87)))))
              : const SizedBox.shrink(),
          _temComentarios
              ? _exibirComentarios()
              : _exibirMensagemComentariosInexistentes()
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Widget detalhes = const SizedBox.shrink();

    if (_temAnime == _EstadoAnime.naoVerificado) {
      detalhes = const SizedBox.shrink();
    } else if (_temAnime == _EstadoAnime.temAnime) {
      detalhes = _exibirAnime();
    } else {
      detalhes = _exibirMensagemAnimeInexistente();
    }
    return detalhes;
  }
}
