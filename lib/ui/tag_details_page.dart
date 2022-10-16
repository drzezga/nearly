import 'package:flutter/material.dart';
import 'package:hackathon/ui/settings_page.dart';

import '../model/tag.dart';

class TagDetailsPage extends StatelessWidget {
  final Tag tag;

  const TagDetailsPage(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const BottomSheetHandle(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(tag.type.icon, size: 36),
              const SizedBox(width: 8),
              Text(tag.type.title, style: const TextStyle(fontSize: 25)),
            ],
          ),
          const SizedBox(height: 8),
          Text(tag.payload.toString(), textAlign: TextAlign.center,),
          const SizedBox(height: 4),
          Text(tag.timestamp.toLocal().toString(), style: const TextStyle(color: Colors.black26)),
          TextButton(
            child: const Text("Nie pokazuj więcej"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    //     builder: (context) => BlocProvider(create: (_) => NotificationPreferencesCubit(), child: const SettingsPage())),
                      builder: (_) => SettingsPage()));
            },
          )
        ],
      ),
    );
  }
}

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: 5,
        width: 70,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(150))),
        ),
      ),
    );
  }
}
