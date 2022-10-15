import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/bloc/settings_cubit.dart';
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
        body: BlocBuilder<NotificationPreferencesCubit, Map<String, bool>>(builder: (context, state) {
          return SettingsList(
            sections: [
              SettingsSection(tiles: [
                for (var entry in state.entries) SettingsTile.switchTile(
                  leading: Icon(notificationSchema[entry.key]!.icon),
                  title: Text(notificationSchema[entry.key]!.displayName),
                  onToggle: (value) {
                    setState(() {
                      context.read<NotificationPreferencesCubit>().toggleSetting(entry.key);

                    });
                    // setState(() {
                    //   warningsState = !warningsState;
                    // });
                  },
                  initialValue: entry.value,
                )
              ])
            ],
          );
        }));
  }
}
