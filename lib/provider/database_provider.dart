import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class DatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;
  
  DatabaseProvider({required this.databaseHelper}){
    _getFavorit();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorit = [];
  List<Restaurant> get favorit => _favorit;

  void _getFavorit() async{
    _state = ResultState.loading;
    notifyListeners();
    _favorit = await databaseHelper.getFavorit();
    if(_favorit.isNotEmpty){
      _state = ResultState.hasData;
    }else{
      _state = ResultState.noData;
      _message='Empty Data';
    }
    notifyListeners();
  }

  void addFavorit(Restaurant restaurant) async{
    try{
      await databaseHelper.insertFavorit(restaurant);
      _getFavorit();
    }catch (e){
      _state =ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorit(String id) async{
    final favoritRestaurant = await databaseHelper.getFavoritById(id);
    return favoritRestaurant.isNotEmpty;
  }

  void removeFavorit(String id) async{
    try{
      await databaseHelper.removeFavorit(id);
      _getFavorit();
    }catch(e){
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners(); 
    }
  }
}