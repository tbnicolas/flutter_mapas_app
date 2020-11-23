import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_mapas_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_mapas_app/pages/acceso_gps_page.dart';
import 'package:flutter_mapas_app/pages/loading_page.dart';
import 'package:flutter_mapas_app/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => new MiUbicacionBloc(),),
        BlocProvider(create: (BuildContext context) => new MapaBloc(),),
        BlocProvider(create: (BuildContext context) => new BusquedaBloc(),),
      ],
      child: new MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: new LoadingPage(),
        routes: {
          'mapa':      (_) => new MapaPage(),
          'loading':   (_) => new LoadingPage(),
          'acceso_gps':(_) => new AccesoGpsPage()
        },
      ),
    );
  }
}