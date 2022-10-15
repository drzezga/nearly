import 'package:flutter/material.dart';

import '../model/tag.dart';

class ReadTagCard extends StatelessWidget {
  final Tag tag;
  final GestureTapCallback? onTap;
  const ReadTagCard(this.tag, {Key? key, this.onTap}) : super(key: key);
 // Text("Sygnalizacja dla pieszych jest zielona"),
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(tag.type.icon),
                    const SizedBox(width: 10),
                    Flexible(child: Text(tag.type.title, style: const TextStyle(fontSize: 24),)),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     TextButton(onPressed: () {}, child: const Text("Więcej informacji")),
                    //     // IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                    //     // OutlinedButton(onPressed: () {}, child: const Text("Wyłącz te powiadomienia"))
                    //   ],
                    // )
                  ]
                ),
                Text(tag.payload),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
