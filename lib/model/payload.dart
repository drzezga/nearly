import 'package:flutter/material.dart';
import 'package:hackathon/model/tag.dart';

class Payload {
  final String description;

  const Payload(this.displayName, this.icon, this.description, this.type);

  final TagType type;
}
