part of 'mapa_bloc.dart';

@immutable
class MapaState {

  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  // PolyLines
  final Map<String, Polyline> polylines;
  final LatLng ubicacionCentral; 
  MapaState({
    this.dibujarRecorrido = false , 
    this.mapaListo = false,
    this.seguirUbicacion = false,
    this.ubicacionCentral,
    Map<String, Polyline> polylines 
  }): this.polylines = polylines ?? new Map();

  MapaState copyWith({
    bool mapaListo, 
    bool dibujarRecorrido,
    Map<String, Polyline> polylines,
    bool seguirUbicacion,
    LatLng ubicacionCentral
  }) => new MapaState(
    mapaListo       : mapaListo ?? this.mapaListo,
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
    polylines       : polylines ?? this.polylines,
    seguirUbicacion : seguirUbicacion ?? this.seguirUbicacion,
    ubicacionCentral : ubicacionCentral ?? this.ubicacionCentral
  );
}
