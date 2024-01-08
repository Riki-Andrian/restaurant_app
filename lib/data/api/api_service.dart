import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> showRestaurantList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetail> showRestaurantDetail(String id) async{
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if(response.statusCode == 200){
      return RestaurantDetail.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load restaurant's detail");
    }
  }

  Future<SearchRestaurant> getTextField(String query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<RestaurantList> resultListRestaurant(http.Client client) async {
    final response = await client.get(Uri.parse("${_baseUrl}list"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json["message"] == "success") {
        RestaurantList restaurant =
            RestaurantList.fromRawJson(response.body);

        return restaurant;
      } else {
        throw Exception("List Restaurant not succes");
      }
    } else {
      throw Exception("Failed to load List Restaurant");
    }
  }
  Future<List<Restaurant>> listRestaurant() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json["message"] == "success") {
        List<dynamic> jsonDynamic = json["restaurants"];

        List<Restaurant> restaurant =
            jsonDynamic.map((e) => Restaurant.fromJson(e)).toList();

        return restaurant;
      } else {
        throw Exception("List Restaurant not succes");
      }
    } else {
      throw Exception("Failed to load List Restaurant");
    }
  }
}