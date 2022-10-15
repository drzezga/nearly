import 'package:flutter/material.dart';

import '../model/tag.dart';

class TagDetailsPage extends StatelessWidget {
  final Tag tag;

  const TagDetailsPage(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(tag.payload),
        TextButton(
          child: const Text("Nie pokazuj więcej"),
          onPressed: () {},
        )
      ],
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
      padding: EdgeInsets.symmetric(vertical: 8),
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
