import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:virag/screens/environment.dart';
import 'package:virag/screens/language.dart';
import 'package:virag/screens/platform.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback? onClose;

  const SettingsPage({Key? key, this.onClose}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isCustomThemeEnabled = true;
  bool isLockInBackgroundEnabled = true;
  bool isFingerprintEnabled = true;
  bool isChangePasswordEnabled = true;
  bool isNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          IconButton(
            onPressed: widget.onClose,
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SETTINGS",
              style: TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.w500,
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: const Text('Common'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        title: const Text('Language'),
                        value: const Text('English'),
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LanguageSettingsPage()), 
                          );
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.cloud_outlined),
                        title: const Text('Environment'),
                        value: const Text('Production'),
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EnvironmentSettingsPage()),
                          );
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.devices_other),
                        title: const Text('Platform'),
                        value: const Text('Music Player'),
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlatformSettingsPage()), 
                          );
                        },
                      ),
                      SettingsTile.switchTile(
                        initialValue: isCustomThemeEnabled,
                        leading: const Icon(Icons.format_paint),
                        title: const Text('Enable custom theme'),
                        onToggle: (bool value) {
                          setState(() {
                            isCustomThemeEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: const Text('Security'),
                    tiles: <SettingsTile>[
                      SettingsTile.switchTile(
                        initialValue: isLockInBackgroundEnabled,
                        leading: const Icon(Icons.phonelink_lock),
                        title: const Text('Lock app in background'),
                        onToggle: (bool value) {
                          setState(() {
                            isLockInBackgroundEnabled = value;
                          });
                        },
                      ),
                      SettingsTile.switchTile(
                        initialValue: isFingerprintEnabled,
                        leading: const Icon(Icons.fingerprint),
                        title: const Text('Use fingerprint'),
                        description: const Text(
                          'Allow application to access stored fingerprint IDs'
                        ),
                        onToggle: (bool value) {
                          setState(() {
                            isFingerprintEnabled = value;
                          });
                        },
                      ),
                      SettingsTile.switchTile(
                        initialValue: isChangePasswordEnabled,
                        leading: const Icon(Icons.lock),
                        title: const Text('Change password'),
                        onToggle: (bool value) {
                          setState(() {
                            isChangePasswordEnabled = value;
                          });
                        },
                      ),
                      SettingsTile.switchTile(
                        initialValue: isNotificationsEnabled,
                        leading: const Icon(Icons.notifications_active),
                        title: const Text('Enable notifications'),
                        onToggle: (bool value) {
                          setState(() {
                            isNotificationsEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: const Text('Misc'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.description),
                        title: const Text('Terms of Service'),
                        onPressed: (context) {
                          // Navigate to Terms of Service page
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.collections_bookmark),
                        title: const Text('Open source license'),
                        onPressed: (context) {
                          // Navigate to Open Source License page
                        },
                      ),
                    ],
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
