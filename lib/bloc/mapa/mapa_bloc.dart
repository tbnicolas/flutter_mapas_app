import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_mapas_app/themes/uber_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(new MapaState());
  //Controlador del mapa
  GoogleMapController _mapController;
  //Polylines
  Polyline _miruta = new Polyline(
      polylineId: new PolylineId('mi_ruta'), 
      width: 4, 
      color: Colors.transparent
  );
    Polyline _mirutadestino = new Polyline(
      polylineId: new PolylineId('mi_ruta_destino'), 
      width: 4, 
      color: Colors.black87
  );
  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
    // TODO: implement mapEventToState
    if (event is OnMapaListo) {
      print('Mapa Listo');
      yield state.copyWith(mapaListo: true);
    } else if (event is OnLocationUpdate) {
      yield* this._onLocationUpdate(event);
    } else if (event is OnTrcakPath) {
      yield* this._onTrackPath(event);
    } else if ( event is OnFollowLocation ) {
      yield* this._onFollowLocation(event);
    } else if ( event is OnMoveMap ) {
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    } else if ( event is OnCreatePathStartToEnd ) {
      yield* this._onCreatePathStartToEnd(event);
    }
  }

  Stream<MapaState> _onLocationUpdate(OnLocationUpdate event) async* {
    List<LatLng> points;
    if( state.seguirUbicacion ) {
      moverCamara(event.ubicacion);
    }
    if ( this._miruta.points == null ) {
     points = [const LatLng(0.0, 0.0), event.ubicacion];
    } else {
     points = [...this._miruta.points, event.ubicacion];
    } 
    /* print('Entro');
    print('====> $points <===='); */
    this._miruta = this._miruta.copyWith(pointsParam: points);
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miruta;
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onTrackPath(OnTrcakPath event) async* {
    if (!state.dibujarRecorrido) {
      this._miruta = this._miruta.copyWith(colorParam: Colors.black87);
    } else {
      this._miruta = this._miruta.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miruta;
    yield state.copyWith(
        polylines: currentPolylines, dibujarRecorrido: !state.dibujarRecorrido);
  }

  Stream<MapaState> _onFollowLocation( OnFollowLocation event ) async * {
    if( !state.seguirUbicacion ) {
        this.moverCamara( this._miruta.points[ this._miruta.points.length - 1] );
      }
      yield state.copyWith(seguirUbicacion: !state.seguirUbicacion );
  }

  Stream<MapaState> _onCreatePathStartToEnd( OnCreatePathStartToEnd event ) async* {
    
    this._mirutadestino = this._mirutadestino.copyWith(
      pointsParam: event.rutaCordenadas
    );

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta_destino'] = this._mirutadestino;

    yield state.copyWith(
      polylines: currentPolylines
    );

  }
}
