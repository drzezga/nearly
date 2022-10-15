import 'package:flutter/material.dart';

class NotificationSchemaItem {
  final IconData icon;
  final String displayName;
  final bool warn;

  const NotificationSchemaItem(this.displayName, this.icon, this.warn);
}
