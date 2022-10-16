import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/model/notification_schema_item.dart';

const notificationSchema = {
  'warnings': NotificationSchemaItem('Ostrzeżenia', Icons.warning, true), // 0
  'pedestrian_stops': NotificationSchemaItem('Światła dla przechodniów', Icons.traffic_outlined, true), // 1
  'bus_departures': NotificationSchemaItem('Odjazdy autobusów', Icons.directions_bus, false), // 2
  'park_and_gos': NotificationSchemaItem('Parkuj i jedź', Icons.local_parking, false), // 3
  'others': NotificationSchemaItem("Inne", Icons.info, false), // 4
};

Map<String, bool> getStartingVal() {
  Map<String, bool> outMap = {};

  for (var schemaItem in notificationSchema.entries) {
    outMap[schemaItem.key] = true;
  }

  return outMap;
}

class NotificationPreferencesCubit extends Cubit<Map<String, bool>> {
  NotificationPreferencesCubit()  : super(getStartingVal());

  void toggleSetting(String key) {
    var newState = state;
    if (newState[key] != null) {
      newState[key] = !newState[key]!;
      emit(newState);
    }
  }
}