import 'package:flutter/material.dart';
import 'package:hackathon/model/tag.dart';

class Payload {
  final IconData icon;
  final String displayName;
  final String description;

  const Payload(this.displayName, this.icon, this.description, this.type);

  final TagType type;
}
