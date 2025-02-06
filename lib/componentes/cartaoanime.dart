import 'package:aula/estado.dart';
import 'package:flutter/material.dart';

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
          // Verifica se a imagem está vazia e exibe uma padrão se necessário
          Image.network(
            anime["anime"]["imagem"].isNotEmpty
                ? anime["anime"]["imagem"]
                : "https://via.placeholder.com/300x200.png?text=Imagem+Indisponível",
          ),
          Row(children: [
            // Verifica se o avatar está vazio e exibe um padrão se necessário
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                anime["estudio"]["avatar"].isNotEmpty
                    ? anime["estudio"]["avatar"]
                    : "https://via.placeholder.com/100.png?text=Avatar+Indisponível",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                anime["estudio"]["nome"],
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              anime["anime"]["nome"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 10),
            child: Text(anime["anime"]["sinopse"]),
          ),
          const Spacer(),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 30),
              child: Text(
                "Nota: ${anime['anime']['nota'].toString()}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
