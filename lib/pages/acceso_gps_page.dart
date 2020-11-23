
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class AccesoGpsPage extends StatefulWidget {

  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>  with WidgetsBindingObserver {
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
      if( await Permission.location.isGranted ) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text('Es necesario el GPS para usar esta app'),
            new MaterialButton(
              child: new Text('Solicitar Acceso', 
                style: new TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                final status = await Permission.location.request();
                accesoGPS(status);
                print( status );
              }
            )
          ],
        ),
     ),
   );
  }

  void accesoGPS(PermissionStatus status) {
    switch ( status ) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.undetermined:
        openAppSettings();
    }
  }
}