import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 1, //le indicamos que empiece desde la página 1
    viewportFraction: 0.3 //cuantas tarjetas queremos que se muestre en el PageController (3 tarjetas)
  );

  @override
  Widget build(BuildContext context) {
    
    //Para obtener el tamaño de la pantalla
    final _screenSize = MediaQuery.of(context).size; 

    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) { //200 pixeles antes de que llegue al final
        siguientePagina(); //esto ejecuta getPopulares() porque se envió como referencia desde el StreamBuilder de HomePage
      }
    });
    
    return Container(
      height: _screenSize.height * 0.30, //le digo que ocupe sólo el 20% de la pagina
      child: PageView.builder( //Para renderizar conforme se solicite porqe sólo el PageView renderiza todo a la vez y puede causar un desbordamiento de memoria
        pageSnapping: false, //para quitar efecto de magneto y que las tarjetas recorran naturalmente
        controller: _pageController,
        //children: _tarjetas(context),
        itemCount: peliculas.length, //Porque si no el PageView no sabe cuántas películas tiene que renderizar
        itemBuilder: (context, i) => _tarjeta(context,peliculas[i]),
      ),
    );
  }

  Widget _tarjeta (BuildContext context, Pelicula pelicula) {
    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
            SizedBox(height: 3.0,),
            //overflow indica que si el texto es demasiado largo se adapte al ancho de la imagen y ponga unos tres puntos
            Text(pelicula.title, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ) 
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta,
        onTap: (){
          //print('ID de la película: ${pelicula.id}');
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
      );
  }

  List<Widget>_tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
            SizedBox(height: 3.0,),
            //overflow indica que si el texto es demasiado largo se adapte al ancho de la imagen y ponga unos tres puntos
            Text(pelicula.title, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ) 
          ],
        ),
      );
    }).toList();
  }
}