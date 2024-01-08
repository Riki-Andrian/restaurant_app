import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate;
  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        navigatorKey: navigatorKey,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName:(context) => const HomePage(),
          RestaurantDetailPage.routeName:(context) => RestaurantDetailPage(
            idRestaurant: ModalRoute.of(context)?.settings.arguments as String,
          ),
        },
       
      ),
    );
  }
}
