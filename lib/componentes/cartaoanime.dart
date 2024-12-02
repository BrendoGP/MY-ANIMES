
import 'package:aula/estado.dart';
import 'package:flutter/material.dart';
//import 'package:my_animes/estado.dart';

class AnimeCartao extends StatelessWidget {
  final dynamic anime;

  const AnimeCartao({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        estadoApp.mostrarDetalhes(anime["_id"]);
      },
      child: Card(
        child: Column(children: [
          Image.network("https://th.bing.com/th/id/OIP.ppfxOq0dwzZI5CP_idr2fQHaEn?rs=1&pid=ImgDetMain"),
          Row(children: [
            CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network("https://th.bing.com/th/id/OIP.Zl0PlmOMSSbHmP_OI9xZgAHaEK?rs=1&pid=ImgDetMain")),
            Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(anime["estudio"]["nome"],
                    style: const TextStyle(fontSize: 15))),
          ]),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(anime["anime"]["nome"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16))),
          Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 10),
              child: Text(anime["anime"]["sinopse"])),
          const Spacer(),
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Text("Nota: ${anime['anime']['nota'].toString()}")),
            Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 5),
                child: Row(children: [
                  const Icon(Icons.favorite_rounded,
                      color: Colors.red, size: 18),
                  Text(anime["likes"].toString())
                ])),
          ])
        ]),
      ),
    );
  }
}