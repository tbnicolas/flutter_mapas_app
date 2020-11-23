part of 'widgets.dart';

class BtnMiRuta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  // ignore: close_sinks
  final mapaBloc = context.bloc<MapaBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: new CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: new IconButton(
          icon: new Icon(Icons.more_horiz, color: Colors.black87,), 
          onPressed: () {
            mapaBloc.add( OnTrcakPath() );
          }
        ),
      ),
    );
  }
}