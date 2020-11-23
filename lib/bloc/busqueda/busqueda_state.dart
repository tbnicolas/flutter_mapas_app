part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {

  final bool seleccionManual;
  final bool confirmarDestino;
  BusquedaState({
    this.seleccionManual = false,
    this.confirmarDestino = false
  });

  BusquedaState copyWith({
    bool seleccionManual,
    bool confirmarDestino
  }) => new BusquedaState(
    seleccionManual: seleccionManual ?? this.seleccionManual,
    confirmarDestino: confirmarDestino ?? this.confirmarDestino

  );
}
