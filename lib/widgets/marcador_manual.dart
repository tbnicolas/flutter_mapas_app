part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc,BusquedaState>(
      builder: (BuildContext context, state) {
        
        if ( state.seleccionManual && !state.confirmarDestino ) {
          return new _BuildMarcadorManual();
        } else {
          return new Container();
        }
     },
    );
  }
}


class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Stack(
      children: [
        //Boton Regresar
        new Positioned(
          top:70,
          left: 20,
          child: new FadeInLeft(
            duration: new Duration(milliseconds: 150),
            child: new CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: new IconButton(
                icon: new Icon( Icons.arrow_back,color: Colors.black87 ), 
                onPressed: () {
                  //TODO:  hacer algo!!
                  context.bloc<BusquedaBloc>().add( new OnDesactivarMarcadorManual() );
                }
              )
            ),
          )
        ),
        new Center(
          child: Transform.translate(
            offset: new Offset(0,-12),
            child: new BounceInDown(
              child: new Icon( Icons.location_on, size: 50, )
            )
          ),
        ),
        
        //Boton confirmar destino

        new Positioned(
          bottom: 70,
          left: 40,
          child: new FadeIn(
            child: new MaterialButton(
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              minWidth: size.width - 120,
              child: new Text('Confirmar Destino',
              style: new TextStyle(
                color: Colors.white
              )
              ),
              onPressed: () {
                // TODO: Confirmar Destino
                this.calcularDestino( context );
              }
            ),
          ),
        )
      ],
    );
  }

  Future<void> calcularDestino( BuildContext context ) async{
    
    calculandoAlerta(context);

    // ignore: close_sinks
    final mapaBloc = context.bloc<MapaBloc>();
    final trafficService = new TrafficService();
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    final destino = mapaBloc.state.ubicacionCentral;

    final trafficResponse = await trafficService.getCoordsInicioYFin(inicio, destino);
    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;

    final points = Poly.Polyline.Decode( encodedString: geometry, precision: 6 ).decodedCoords;
    final List<LatLng> rutaCoords =  points.map(
      ( point ) => new LatLng(point[0],point[1])
    ).toList();
    //final temp = points;
    mapaBloc.add( new OnCreatePathStartToEnd(rutaCoords, distancia, duracion) );
    Navigator.of(context).pop();
    context.bloc<BusquedaBloc>().add( new OnConfirmarDestino() );
  }

}