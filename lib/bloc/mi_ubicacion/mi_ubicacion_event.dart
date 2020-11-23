part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

class OnUbicacionCambio extends MiUbicacionEvent {
  final LatLng ubicaion;
  OnUbicacionCambio(this.ubicaion);
}
