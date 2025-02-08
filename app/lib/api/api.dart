// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aula/usuario.dart';

const URL_ANIMES = "http://10.0.2.2:5001/animes";
const URL_ANIME = "http://10.0.2.2:5001/anime";

const URL_COMENTARIOS = "http://10.0.2.2:5002/comentarios";
const URL_ADICIONAR_COMENTARIO = "http://10.0.2.2:5002/adicionar";
const URL_REMOVER_COMENTARIO = "http://10.0.2.2:5002/remover";

const URL_CURTIU = "http://10.0.2.2:5003/curtiu";
const URL_CURTIR = "http://10.0.2.2:5003/curtir";
const URL_DESCURTIR = "http://10.0.2.2:5003/descurtir";

const URL_ARQUIVOS = "http://10.0.2.2:5005/";

class ServicoAnimes {
  Future<List<dynamic>> getAnimes(int ultimoId, int tamanhoPagina) async {
    final resposta =
        await http.get(Uri.parse('$URL_ANIMES/$ultimoId/$tamanhoPagina'));
     if (resposta.statusCode != 200) {
       throw Exception('Erro ao buscar animes !!');
     }

    return jsonDecode(resposta.body);
  }

  Future<List<dynamic>> findAnimes(
      int ultimoAnime,
       int tamanhoPagina,
        String nome) async {
    final resposta = await http
        .get(Uri.parse("$URL_ANIMES/$ultimoAnime/$tamanhoPagina/$nome"));
    final animes = jsonDecode(resposta.body);

    return animes;
  }

  Future<Map<String, dynamic>> findAnime(int idAnime) async {
    final resposta = await http.get(Uri.parse("$URL_ANIME/$idAnime"));
    final anime = jsonDecode(resposta.body);

    return anime;
  }
}

class ServicoComentarios {
  Future<List<dynamic>> getComentarios(
      int idAnime,
       int ultimoId,
        int tamanhoPagina) async {
    final resposta = await http
        .get(Uri.parse('$URL_COMENTARIOS/$idAnime/$ultimoId/$tamanhoPagina'));
    if (resposta.statusCode != 200) {
      throw Exception("Erro ao buscar comentários !!");
    }

    return jsonDecode(resposta.body);
  }

  Future<dynamic> adicionar(
      int idAnime,
       Usuario usuario,
        String comentario) async {
    final resposta = await http.post(Uri.parse(
        "$URL_ADICIONAR_COMENTARIO/$idAnime/${usuario.nome}/${usuario.email}/$comentario"));

    return jsonDecode(resposta.body);
  }

  Future<dynamic> remover(int idComentario) async {
    final resposta =
        await http.delete(Uri.parse("$URL_REMOVER_COMENTARIO/$idComentario"));

    return jsonDecode(resposta.body);
  }
}

class ServicoCurtidas {
  Future<bool> curtiu(Usuario usuario, int idAnime) async {
    final resposta =
        await http.get(Uri.parse("$URL_CURTIU/${usuario.email}/$idAnime"));
    final resultado = jsonDecode(resposta.body);

    return resultado["curtiu"] as bool;
  }

  Future<dynamic> curtir(Usuario usuario, int idAnime) async {
    final resposta =
        await http.post(Uri.parse("$URL_CURTIR/${usuario.email}/$idAnime"));

    return jsonDecode(resposta.body);
  }

  Future<dynamic> descurtir(Usuario usuario, int idAnime) async {
    final resposta = await http
        .post(Uri.parse("$URL_DESCURTIR/${usuario.email}/$idAnime"));

    return jsonDecode(resposta.body);
  }
}

String formatarCaminhoArquivo(String arquivo) {
  return '$URL_ARQUIVOS/$arquivo';
}
