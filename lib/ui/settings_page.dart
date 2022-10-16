import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/bloc/settings_cubit.dart';
import 'package:hackathon/ui/home_page.dart';
import 'package:hackathon/view/home_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'dev_page.dart';


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
        appBar: AppBar(title: const Text('Ustawienia'), actions: [IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  //     builder: (context) => BlocProvider(create: (_) => NotificationPreferencesCubit(), child: const SettingsPage())),
                    builder: (_) => const ScanPage()));
        }, icon: const Icon(Icons.abc))],),
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
