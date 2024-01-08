import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Material(
      child: ListTile(
        title: const Text('Scheduling Restaurant'),
        trailing: Consumer<SchedulingProvider>(
          builder: (context, scheduled, _) {
            return Switch.adaptive(
                value: scheduled.isScheduled,
                onChanged: (value) async {
                  scheduled.scheduledRestaurant(value);
                });
          },
        ),
      ),
    );
  }
}
