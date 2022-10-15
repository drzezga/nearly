import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var warningsState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Ustawienia')),
        body: SettingsList(
          sections: [
            SettingsSection(tiles: [
              SettingsTile.switchTile(
                leading: const Icon(Icons.warning),
                title: const Text('Ostrzeżenia'),
                onToggle: (value) {
                  setState(() {
                    warningsState = !warningsState;
                  });
                },
                initialValue: warningsState,
              )
            ])
          ],
        ));
  }
}
