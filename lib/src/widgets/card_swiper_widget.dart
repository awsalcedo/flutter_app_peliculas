import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas; //se la define final porque no va a cambiar

  //Este widget necesita recibir la lista de tarjetas que se necesita mostrar y como es final la lista
  //se necesita inicializar en el cosntructor y lo coloco como requerido
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    //Usamos MediaQuery para obtener las dimensiones de la pantalla (ancho y alto) 
    //y que el widget se adapte a dichas dimensiones

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7, //Sólo quiero el 70% del ancho de la pantalla
        itemHeight: _screenSize.height * 0.5, //Sólo quiero el 50% del alto de la pantalla
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect( //Este widget redondea las puntas de los rectángulos
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover, //Para que cubra todo el espacio posible en su contenedor
            )
            );
        },
        itemCount: peliculas.length,
        //pagination: SwiperPagination(),
        //control: SwiperControl(),
      ),
    );
  }
}