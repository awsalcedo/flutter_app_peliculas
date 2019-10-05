//Usada como envoltorio de la lista de peliculas que viene en el json como string
class Peliculas{
  List<Pelicula> peliculas = new List();

  Peliculas();

  Peliculas.mapearResultsDesdeJson(List<dynamic> jsonList){
    if(jsonList == null) return; //Si es nulo no hago nada

    //Señalar que item no es una Pelicula sino un mapa como se muestra en el ejemplo de retorno del API REST

    /*
    "results": [
     {
            "popularity": 512.119,
            "vote_count": 460,
            "video": false,
            "poster_path": "/v0eQLbzT6sWelfApuYsEkYpzufl.jpg",
            "id": 475557,
            "adult": false,
            "backdrop_path": "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg",
            "original_language": "en",
            "original_title": "Joker",
            "genre_ids": [
                80,
                18,
                53
            ],
            "title": "Joker",
            "vote_average": 8.8,
            "overview": "Situada en los años 80'. Un cómico fallido es arrastrado a la locura, convirtiendo su vida en una vorágine de caos y delincuencia que poco a poco lo llevará a ser el psicópata criminal más famoso de Gotham.",
            "release_date": "2019-10-04"
        }
    ]
    */

    for(var item in jsonList){
      final pelicula = new Pelicula.mapearDesdeJsonMap(item);
      peliculas.add(pelicula);
    }
  }

}

//Generado con Ctrl + shift + P tipeamos Paste JSON as Code
// Generated by https://quicktype.io
class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  //Creamos otro constructor para procesar el json que viene como string y mapear a cada una de las propiedades
  // del objeto Pelicula

  Pelicula.mapearDesdeJsonMap(Map<String, dynamic> json){
    popularity       = json['popularity'] / 1; //Hacemos esto para pasarlo a double
    voteCount        = json['vote_count'];
    video            = json['video'];
    posterPath       = json['poster_path'];
    id               = json['id'];
    adult            = json['adult'];
    backdropPath     = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>(); //Para hacerlo de tipo entero
    title            = json['title'];
    voteAverage      = json['vote_average'] / 1; //Hacemos esto para pasarle a double
    overview         = json['overview'];
    releaseDate      = json['release_date'];
  }
}
