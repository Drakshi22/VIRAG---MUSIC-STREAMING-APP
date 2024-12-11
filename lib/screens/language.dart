import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Language'),
            tiles: [
              SettingsTile(
                title: Text('English'),
                onPressed: (context) {
                  
                },
              ),
              SettingsTile(
                title: Text('Hindi'),
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
