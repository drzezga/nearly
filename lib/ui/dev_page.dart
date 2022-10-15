import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/bloc/settings_cubit.dart';
import 'package:settings_ui/settings_ui.dart';

class DevPage extends StatefulWidget {
  const DevPage({Key? key}) : super(key: key);

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  var warningsState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('DEV')),
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
