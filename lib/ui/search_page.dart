import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/list_restaurant.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController controller = TextEditingController();
  String hasil='';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _){
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue.shade300,
                          width: 1,
                        )
                        
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.black54
                          ),
                          suffix: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (String query){
                          if(query.isNotEmpty){
                           hasil = query;
                            state.fetchSearchRestaurant(hasil);
                          }
                        },
                      ),
                    ),
                    (hasil.isEmpty)
                    ?
                    const Center()
                    : Consumer<SearchRestaurantProvider>(
                      builder: (context, state,_){
                        if(state.state == ResultState.loading){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(state.state == ResultState.hasData){
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.result!.restaurants.length,
                            itemBuilder: (context, index) {
                              var restaurant = state.result!.restaurants[index];
                              return ListRestaurant(restaurant: restaurant);
                            }, 
                          );
                        }else if(state.state == ResultState.noData){
                          return  Center(
                            child: Text(state.message),
                          );
                        }else if(state.state == ResultState.error){
                          return  Center(
                            child: Text(state.message),
                          );
                        }else{
                          return const Center(
                            child: Text('Error Tidak diketahui'),
                          );
                        }
                      })
                  ],
                ),
              ),
            ),
          );
        },
      ),
      );
  }
}