import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/settings/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Obx(
            () => SwitchListTile(
              title: const Text('Dark Mode'),
              value: controller.isDarkMode.value,
              onChanged: controller.toggleTheme,
              secondary: const Icon(Icons.brightness_6),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About App'),
            subtitle: const Text('Version 1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
