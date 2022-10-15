import 'package:flutter/material.dart';

class ReadTagCard extends StatelessWidget {
  final Widget text;
  final GestureTapCallback? onTap;
  const ReadTagCard(this.text, {Key? key, this.onTap}) : super(key: key);
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
                  children: const [
                    Icon(Icons.traffic),
                    SizedBox(width: 10),
                    Flexible(child: Text("Przejście dla pieszych", style: TextStyle(fontSize: 24),)),
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
                Text("Można bezpiecznie przejść przez pasy"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
