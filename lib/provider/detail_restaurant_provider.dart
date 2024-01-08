import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';


enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  late RestaurantDetail _detailRestaurant;
  late ResultState _state;
  String _message = '';

  DetailRestaurantProvider({required this.id, required this.apiService}) {
    getDetailRestaurant(id);
  }

  String get message => _message;
  RestaurantDetail get result => _detailRestaurant;
  ResultState get state => _state;

    void fecthRestauran(String id) {
    getDetailRestaurant(id);
  }

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.showRestaurantDetail(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Lost Connection";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
