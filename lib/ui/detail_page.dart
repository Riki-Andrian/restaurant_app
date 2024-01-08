import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/widget/detail_card.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

    final String idRestaurant;

  const RestaurantDetailPage({Key? key, required this.idRestaurant})
      : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restaurant'),
      ),
      body: _buildList()
    );
  }

 Widget _buildList(){
    return ChangeNotifierProvider(
      create: (_) => DetailRestaurantProvider(apiService: ApiService(), id: idRestaurant),
      child:  Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if(state.state == ResultState.loading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(state.state == ResultState.hasData){
          final restaurants = state.result.restaurant;
          return DetailCard(restaurant : restaurants);
        }else if (state.state == ResultState.noData){
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        }else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        }else{
          return const Center(
            child: Material(
              child: Text('Error tidak diketahui'),
            ),
          );
        }
      }, 
    )
       );
   
  }

}
