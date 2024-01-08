import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  void loadBool() async {
    debugPrint("Load Bool");
    final pref = await SharedPreferences.getInstance();
    _isScheduled = pref.getBool("schedule") ?? false;
    notifyListeners();
  }

  void saveBool() async {
    debugPrint("saveBool");
    final pref = await SharedPreferences.getInstance();
    pref.setBool("schedule", _isScheduled);
  }

  SchedulingProvider() {
    loadBool();
  }

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    saveBool();
    if (_isScheduled) {
      debugPrint('Scheduling Restaurant Activated');

      notifyListeners();

      debugPrint('Before AndroidAlarmManager.periodic');
      final result = await AndroidAlarmManager.periodic(
        const Duration(days: 1),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
      debugPrint('After AndroidAlarmManager.periodic');
      return result;
    } else {
      debugPrint('Scheduling Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
