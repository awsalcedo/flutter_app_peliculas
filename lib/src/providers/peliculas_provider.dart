
import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {

  String _apiKey   = '76d76f2aeddf79d9f28cbfa7b2a7a3c7';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  //Contenedor de películas
  List<Pelicula> _populares = new List();

  //Hay que indicarle que información va a fluir por el río de información, se pone broadcast para que muchos lugares puedan escuchar la información
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //Para agregar al StreamController
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  //Para leer la información del StreamController
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream(){
    _popularesStreamController?.close();
  }

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

    final resp = await _procesarRespuesta(url);

    return resp;

  }

  Future<List<Pelicula>> getPopulares() async {

    //Si estoy cargando datos devuelva un arreglo vacío, es decir para controlar que no se lancen peticiones cada vez que se llega al final de la página de las imagenes
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.http(_url, '3/movie/popular', {
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });

    //https://api.themoviedb.org/3/movie/popular?api_key=76d76f2aeddf79d9f28cbfa7b2a7a3c7&language=en-US&page=1

    final resp = await _procesarRespuesta(url);
    
    _populares.addAll(resp);

    popularesSink(_populares);

    _cargando = false;
    
    return resp;
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    
    final dataDecodificada = json.decode(respuesta.body);
    
    final peliculasPopulares = new Peliculas.mapearResultsDesdeJson(dataDecodificada['results']);
    
    return peliculasPopulares.peliculas;
  }

}