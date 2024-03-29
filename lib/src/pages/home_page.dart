import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {

            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper(
            peliculas: snapshot.data,
          );
        }else{
          return Container(
            height: 250.0,
            child: Center(
              child: CircularProgressIndicator()
              ),
          );
        }
      },
    );

  }

  Widget _footer (BuildContext context) {
      return Container(
        width: double.infinity, //para que tome todo el espacio
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.subhead, //para aplicar un estilo de manera global
              ),
            ),
            SizedBox(height: 6.0,),
            StreamBuilder(
              stream: peliculasProvider.popularesStream,
              //initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                //snapshot.data?.forEach() el signo de pregunta significa si existe datos
                //snapshot.data?.forEach((p) => print(p.title)); 
                if(snapshot.hasData) {
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider.getPopulares, //sólo tiene que ser la definición de la función es decir sin paréntesis, dart pasa esa función como referencia
                  ); 
                }else{
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      );
  }

}