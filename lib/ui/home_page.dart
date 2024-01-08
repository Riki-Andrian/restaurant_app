import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home_page_provider.dart';
import 'package:restaurant_app/ui/favorit_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';

class HomePage extends StatefulWidget {

  static const routeName = '/home_page';
 
  
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _onItemTapped(BuildContext context, int index){
    Provider.of<SelectedIndexModel>(context, listen: false).updateIndex(index);

  }
    final List<Widget> _widgetOptions = <Widget>[
    const RestaurantListPage(),
    const SearchPage(),
    const FavoritPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _build(),
    );
  }



  Widget _build() {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => SelectedIndexModel(),
        child: Consumer<SelectedIndexModel>(
          builder: (context, selectedIndexModel, child) {
            final int _selectedIndex = selectedIndexModel.selectedIndex;
            return Scaffold(
              body: _widgetOptions[_selectedIndex],
               bottomNavigationBar: _buildBottomNavigationBar(context, selectedIndexModel),              
            );                   
          },
        ),
        ),
    );
  }


   Widget _buildBottomNavigationBar(
    BuildContext context, SelectedIndexModel selectedIndexModel
   ) {
    return BottomNavigationBar(
      unselectedFontSize: 0,
      selectedFontSize: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.shade500,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      backgroundColor: Colors.blue.shade100,
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: 'Favorit', icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(label: 'Favorit', icon: Icon(Icons.settings)),
      ],
     currentIndex: selectedIndexModel.selectedIndex,

      onTap: (index) => _onItemTapped(context, index),

    );
  }
}