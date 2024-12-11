import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
class PlatformSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Platform Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Platform'),
            tiles: [
              SettingsTile(
                title: Text('Android'),
                onPressed: (context) {
                },
              ),
              SettingsTile(
                title: Text('iOS'),
                onPressed: (context) {
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
