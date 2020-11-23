part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  
  final bool siguiendo;
  final bool existeUbicacion;
  final LatLng ubicacion ;

  MiUbicacionState({
    this.existeUbicacion = true, 
    this.siguiendo = false,
    this.ubicacion, 
  });

  MiUbicacionState copiWith({
   bool siguiendo,
   bool existeUbicacion,
   LatLng ubicacion
  }) => new MiUbicacionState(
    siguiendo      : siguiendo ?? this.siguiendo,
    existeUbicacion:existeUbicacion ?? this.existeUbicacion,
    ubicacion      : ubicacion ?? this.ubicacion
  );
}
