import 'package:aula/api/api.dart';
import 'package:aula/estado.dart';
import 'package:flutter/material.dart';

class AnimeCartao extends StatelessWidget {
  final dynamic anime;

  const AnimeCartao({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        estadoApp.mostrarDetalhes(anime["anime_id"]);
      },
      child: Card(
        child: Column(children: [
  
          Image.network(formatarCaminhoArquivo(anime["imagem"])),
          Row(children: [
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                          formatarCaminhoArquivo(anime["avatar"])))),
            Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                  child: Text(anime["estudio"],
                      style: const TextStyle(fontSize: 15))),
            ]),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(anime["nome"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15))),
            Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 10.0),
                child: Text(anime["sinopse"],
                    style: const TextStyle(fontSize: 12))),
            Row(children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("Nota: ${anime["nota"].toString()}",
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Row(children: [
                    const Icon(Icons.favorite_rounded,
                        color: Colors.red, size: 18),
                    Text(anime["likes"].toString())
                  ]))
            ])
          ]),
        ));
  }
}
