import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class ListRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const ListRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _build();
  }

  Widget _build() {
    return Consumer<DatabaseProvider>(
      builder: (context, state, child) {
        return FutureBuilder<bool>(
            future: state.isFavorit(restaurant.id),
            builder: (context, snapshot) {
              var isFavorit = snapshot.data ?? false;
              return Material(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  leading: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                      width: 100,
                      errorBuilder: (ctx, error, _) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                  title: Text(restaurant.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          Text(restaurant.city),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text((restaurant.rating).toString()),
                        ],
                      ),
                      const Divider(
                        color: Colors.blue,
                      )
                    ],
                  ),
                  trailing: isFavorit
                  ? IconButton(
                    onPressed: () => state.removeFavorit(restaurant.id),
                     icon: const Icon(Icons.favorite, color: Colors.red,)
                     )
                     : IconButton(
                      onPressed: () => state.addFavorit(restaurant), 
                      icon: const Icon(Icons.favorite_border, color: Colors.red,)),
                  onTap: () {
                    Navigator.pushNamed(
                        context, RestaurantDetailPage.routeName,
                        arguments: restaurant.id);
                  },
                ),
              );
            });
      },
    );
  }
}
