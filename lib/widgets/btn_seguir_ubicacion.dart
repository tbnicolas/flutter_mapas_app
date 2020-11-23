part of 'widgets.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  // ignore: close_sinks
  final mapaBloc = context.bloc<MapaBloc>();

    return new BlocBuilder<MapaBloc, MapaState>(
      builder: (_, state) => _crearBoton(mapaBloc)
    );

  }

  Widget _crearBoton(MapaBloc mapaBloc ) {
   return new Container(
      margin: EdgeInsets.only(bottom: 10),
      child: new CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: new IconButton(
          icon: new Icon(
            mapaBloc.state.seguirUbicacion
            ?Icons.directions_run
            :Icons.accessibility_new, 
            color: Colors.black87
          ), 
          onPressed: () {
            mapaBloc.add( OnFollowLocation() );
          }
        ),
      ),
    );
  }
}