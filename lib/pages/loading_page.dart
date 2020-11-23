
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_mapas_app/helpers/helpers.dart';
import 'package:flutter_mapas_app/pages/acceso_gps_page.dart';
import 'package:flutter_mapas_app/pages/mapa_page.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver{
 @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }  

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    print('=======> $state');
    if( state == AppLifecycleState.resumed ) {
      if( await Geolocator.isLocationServiceEnabled() ) {
        Navigator.pushReplacement(context, navegarMapaFadeIn(context, new MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
        future: checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          if( snapshot.hasData ) {
            return new Center(
            child: new Text( snapshot.data ) );
          } else {
            return new Center(
            child: new CircularProgressIndicator( strokeWidth: 2, ));
          }
        },
      ),
   );
  }

  Future checkGpsYLocation( BuildContext context ) async {
    final permisoGPS = await Permission.location.isGranted;
    final gpsActivo  = await Geolocator.isLocationServiceEnabled();
    await Future.delayed( new Duration(milliseconds: 100) );
    //print('Loading page! $gpsActivo || $permisoGPS');
    if( permisoGPS && gpsActivo){
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, new MapaPage()));
      return '';
    } else if( !permisoGPS ){
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, new AccesoGpsPage()));
      return 'Es necesario el permiso GPS';
    } else {
      return 'Active el GPS';
    }

  }
}