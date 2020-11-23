part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnLocationUpdate extends MapaEvent {
  final LatLng ubicacion;
  OnLocationUpdate(this.ubicacion);
}

class OnTrcakPath extends MapaEvent {}

class OnFollowLocation extends MapaEvent {}

class OnCreatePathStartToEnd extends MapaEvent {

  final List<LatLng> rutaCordenadas;
  final double distancia;
  final double duracion;

  OnCreatePathStartToEnd(this.rutaCordenadas, this.distancia, this.duracion);

}


class OnMoveMap extends MapaEvent {
  final LatLng centroMapa;
  OnMoveMap(this.centroMapa);
}


