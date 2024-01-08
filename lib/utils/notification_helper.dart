import 'dart:convert';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin
  ) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "Restaurant Channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var restaurantList = await ApiService().listRestaurant();
    var randomIndex = Random().nextInt(restaurantList.length);
    var randomRestaurant = restaurantList[randomIndex];

    var titleNotification = "<b>Restaurant</b>";
    var titleRestaurant = randomRestaurant.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(randomRestaurant.toJson()));
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        final provider =
            Provider.of<DetailRestaurantProvider>(context, listen: false);
        provider.fecthRestauran(data.id);
        Navigation.intentWithData(route, data);
      },
    );
  }
}