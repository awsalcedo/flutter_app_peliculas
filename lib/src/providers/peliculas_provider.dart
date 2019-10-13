
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {

  String _apiKey   = '76d76f2aeddf79d9f28cbfa7b2a7a3c7';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {

    //https://api.themoviedb.org/3/movie/now_playing?api_key=76d76f2aeddf79d9f28cbfa7b2a7a3c7&language=es-ES&page=1

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    //Para hacer la llamada http se debe usar un paquete llamado flutter_http el cual se debe instalar su 
    //dependencia en el archivo pubspec.yaml

    //final respuesta = await http.get(url);

    //Obtener sólo la información de las películas y decodificar el string en un mapa
    
    //final dataDecodificada = json.decode(respuesta.body);

    //final peliculas = new Peliculas.mapearResultsDesdeJson(dataDecodificada['results']);

    //Probar que tengo las peliculas
    //print(peliculas.peliculas[0].title);

    //return peliculas.peliculas;

    //Optimización de código repetido

    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.http(_url, '3/movie/popular', {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    //https://api.themoviedb.org/3/movie/popular?api_key=76d76f2aeddf79d9f28cbfa7b2a7a3c7&language=en-US&page=1

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    
    final dataDecodificada = json.decode(respuesta.body);
    
    final peliculasPopulares = new Peliculas.mapearResultsDesdeJson(dataDecodificada['results']);
    
    return peliculasPopulares.peliculas;
  }

}