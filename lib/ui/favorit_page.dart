import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/list_restaurant.dart';

class FavoritPage extends StatelessWidget {
  const FavoritPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList(){
    return Consumer<DatabaseProvider>(
    builder: (context, state, child) {
      if(state.state == ResultState.hasData){
        return ListView.builder(
          itemCount: state.favorit.length,
          itemBuilder: (context, index) {
            return ListRestaurant(restaurant: state.favorit[index]);
          },
          );
      }else{
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      }
      
    },);
  }
}