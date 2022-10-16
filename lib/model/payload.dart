import 'package:flutter/material.dart';
import 'package:hackathon/model/tag.dart';

class Payload {
  final String description;

  const Payload(this.description, this.type);

  final TagType type;
}
