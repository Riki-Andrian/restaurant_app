import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {

  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantList get result => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.showRestaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Lost Connection";
    } 
     catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchSearchRestaurant(search);
  }

  SearchRestaurant? _restaurantResult;
  ResultState? _state;
  String _message = '';
  String _search = '';

  String get message => _message;

  SearchRestaurant? get result => _restaurantResult;

  String get search => _search;

  ResultState? get state => _state;

  Future<dynamic> fetchSearchRestaurant(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = ResultState.loading;
        _search = search;
        notifyListeners();
        final restaurant = await apiService.getTextField(search);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Not Found!';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantResult = restaurant;
        }
      } else {
        return _message = 'Text null';
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Lost Connection";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}