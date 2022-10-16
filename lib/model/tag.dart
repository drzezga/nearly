import 'package:flutter/material.dart';

enum TagType {
  warning,
  pedestrianStop,
  busDeparture,
  parkAndGo,
  other,
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
      case TagType.other:
        return 'Inne';
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
      case TagType.other:
        return Icons.info;
    }
  }

  String get setting {
    switch (this) {
      case TagType.warning:
        return 'warnings';
      case TagType.pedestrianStop:
        return 'pedestrian_stops';
      case TagType.busDeparture:
        return 'bus_departures';
      case TagType.parkAndGo:
        return 'park_and_gos';
      case TagType.other:
        return 'others';
    }
  }
}

class Tag {
  // final String content;
  final TagType type;
  final dynamic payload;
  final DateTime timestamp;
  final String uuid;

  const Tag(this.type, this.payload, this.timestamp, this.uuid);
}