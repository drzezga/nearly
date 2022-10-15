import 'package:flutter/material.dart';

enum TagType {
  warning,
  pedestrianStop,
  busDeparture,
  parkAndGo,
}

extension TagTypeExtension on TagType {
  String get title {
    switch (this) {
      case TagType.warning:
        return 'Uwaga';
      case TagType.pedestrianStop:
        return 'Światło na przejściu';
      case TagType.busDeparture:
        return 'Odjazd';
      case TagType.parkAndGo:
        return 'Parkuj i jedź';
    }
  }

  IconData get icon {
    switch (this) {
      case TagType.warning:
        return Icons.warning;
      case TagType.pedestrianStop:
        return Icons.traffic;
      case TagType.busDeparture:
        return Icons.directions_bus;
      case TagType.parkAndGo:
        return Icons.local_parking;
    }
  }
}

// IconData iconFromTagType(TagType type) {
//   switch (type) {
//     case TagType.warning:
//       return 'Uwaga';
//     case TagType.pedestrianStop:
//       return 'Światło na przejściu';
//     case TagType.busDeparture:
//       return 'Odjazd';
//     case TagType.parkAndGo:
//       return 'Parkuj i jedź';
//   }
// }

class Tag {
  final String content;
  final TagType type;
  final dynamic payload;
  // final long timestamp;

  const Tag(this.content, this.type, this.payload);
}