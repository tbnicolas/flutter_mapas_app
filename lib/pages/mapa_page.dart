import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_mapas_app/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    context.bloc<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    context.bloc<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: [
          //Es Como si tuviesemos un StreamBuilder
          new BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (context, state) => crearMapa(state),
          ),
          // TODO: hacer el toggle cuando estoy manualmente

          new Positioned(
            top: 15,
            child: new SearchBar()
          ),
          new FadeInDown(
            duration: new Duration( milliseconds: 300),
            child: new MarcadorManual()
          )
        ],
      ),
      floatingActionButton: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new BtnUbicacion(),
            new BtnSeguirUbicacion(),
            new BtnMiRuta(),
          ],
        ),
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if( !state.existeUbicacion ) return new Center(child: new Text('Ubicando...'));
    //ignore: close_sinks
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add( OnLocationUpdate( state.ubicacion ??  const LatLng(0.0, 0.0)) );
    final cameraPosition = new CameraPosition(
      target: state.ubicacion ?? new LatLng(0.0, 0.0),
      zoom: 15
    );
   // print('Camera Position: ${cameraPosition.target} ${mapaBloc.state.polylines.values.toSet()}');
    final Set<Polyline> setPolylines = new Set();
    setPolylines.add(
      new Polyline(
      polylineId: new PolylineId('mi_ruta'),
      points: [new LatLng(0.0, 0.0) ]
      )
    );
    //int a =10;
    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, _ ) {
      return new GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc.initMapa,
      polylines: mapaBloc.state.polylines.values.toSet(),
      onCameraMove: ( CameraPosition cameraPosition ) {
        mapaBloc.add( new OnMoveMap( cameraPosition.target ) );
      },);
      },
    );

  }
}
