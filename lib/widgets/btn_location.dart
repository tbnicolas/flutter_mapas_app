part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  // ignore: close_sinks
  final mapaBloc = context.bloc<MapaBloc>();
  // ignore: close_sinks
  final miUbicacionBloc = context.bloc<MiUbicacionBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: new CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: new IconButton(
          icon: new Icon(Icons.my_location,color: Colors.black87,), 
          onPressed: () {
            final destino = miUbicacionBloc.state.ubicacion;
            mapaBloc.moverCamara(destino);
          }
        ),
      ),
    );
  }
}