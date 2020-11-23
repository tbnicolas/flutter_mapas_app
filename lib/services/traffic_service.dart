

import 'package:dio/dio.dart';
import 'package:flutter_mapas_app/models/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {

  // Singleton
  static final TrafficService _instance = new TrafficService._privateConstructor();
  TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }
  final _dio = new Dio();
  
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';

  final _apiKey = 'pk.eyJ1IjoibnRydWppbGxvNyIsImEiOiJja2hkd29rcDAwZ2p2MnhzYmY0dGZnNXlrIn0.y4ned7ZtxARQtBR9dC5SkQ';
  

  Future<DrivingResponse> getCoordsInicioYFin( LatLng inicio, LatLng destino) async {
    final coordString = '${ inicio.longitude },${ inicio.latitude };${ destino.longitude },${ destino.latitude }';
    final url = '${ this._baseUrlDir }/mapbox/driving/$coordString';

    final resp = await this._dio.get(url,queryParameters: {
        'alternatives': 'true',
        'geometries'  : 'polyline6',
        'steps'       : 'false',
        'access_token':  this._apiKey,
    });
    print(resp);
    final data = DrivingResponse.fromJson(resp.data);
    return data;
  }

  Future getResultadoPorQuery( String busqueda, LatLng proximidad ) async {

    final url = '${ this._baseUrlGeo }//mapbox.places/$busqueda.json';
    final resp = await this._dio.get(url,queryParameters: {
      'access_token':_apiKey,
      'autocomplete':_apiKey,
      'proximity'   :'${ proximidad.latitude},${ proximidad.longitude}',
      'language'    :'es'

    });



  }

}