
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';


class DetailCard extends StatefulWidget {

  final DetailRestaurant restaurant;
  const DetailCard({
   Key? key,
   required this.restaurant
  }) : super(key: key);

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.restaurant.pictureId,
              child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}'),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurant.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                     height:  4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.black.withOpacity(0.5),
                                size: 20,
                              ),
                              Text(
                                '${widget.restaurant.address}, ${widget.restaurant.city}',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                (widget.restaurant.rating).toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Text('Description',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  ExpandableText(
                    widget.restaurant.description,
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 3,
                    linkColor: Colors.blue,
                    animation: true,
                  ),
                  const Divider(
                    color: Colors.blue,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('Drinks:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            widget.restaurant.menus.drinks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3.0,
                                ),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  widget.restaurant.menus
                                      .drinks[index].name,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text('Foods:',
                        style: TextStyle
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            widget.restaurant.menus.foods.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3.0,
                                ),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  widget.restaurant.menus
                                      .foods[index].name,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
