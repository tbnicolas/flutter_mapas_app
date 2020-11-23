part of 'helpers.dart';

void calculandoAlerta( BuildContext context ) {

  if( Platform.isAndroid ) {

    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Espere Porfavor'),
        content: new Text('Calculando ruta'),
      ),
    );

  } else { 
    showCupertinoDialog(
      context: context, 
      builder: (context) => new CupertinoAlertDialog(
        title: new Text('Esper Porfavor'),
        content: CupertinoActivityIndicator(),
      ),
    );
  }



}