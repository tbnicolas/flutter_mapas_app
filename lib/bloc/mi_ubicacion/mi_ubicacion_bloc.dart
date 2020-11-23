import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super( new MiUbicacionState() );
  StreamSubscription<Position> _positionStreamSubscription;
  void iniciarSeguimiento() {
    /*final geoLocatorOption = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    ); */
   _positionStreamSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen(( Position position ) {
        //print( position );
        final nuevaUbicaion = new LatLng(position.latitude, position.longitude);
        add(OnUbicacionCambio(nuevaUbicaion));
     });

  }

  void cancelarSeguimiento() {
    _positionStreamSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event,) async* {
    // TODO: implement mapEventToState
    if ( event is OnUbicacionCambio ) {
      print(event) ;
      yield state.copiWith(
        existeUbicacion: true,
        ubicacion: event.ubicaion
      );

    }
  }
}
