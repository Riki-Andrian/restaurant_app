import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/list_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
   static const routeName = '/restaurant_list';
   
  const RestaurantListPage({Key? key}) : super(key: key);


  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: _buldList()
       
    );
  }

  Widget _buldList(){
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child:  Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if(state.state == ResultState.loading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(state.state == ResultState.hasData){
          return  ListView.builder(
            shrinkWrap: true,
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return ListRestaurant(restaurant: restaurant);
          },
                );
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