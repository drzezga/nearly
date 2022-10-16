import 'package:flutter/material.dart';
import 'package:hackathon/model/tag.dart';

Map<int, Payload> mapa = {
  0: Payload("Uwaga na gaz", TagType.warning)
  1: Payload("Uwaga na ogien", TagType.warning)
  2: Payload("Przejscie dla pieszych CZERWONE!!", TagType.pedestrianStop)
  3: Payload("Przejscie dla pieszych Zielony :)", TagType.pedestrianStop)
  4: Payload("Uwaga twój bus ODJEŻDŻA za 5 min!", TagType.busDeparture)
  5: Payload("Masz 20 min do przyjazdu twojego autobusu!", TagType.busDeparture)
  6: Payload("W parkingu na ktory wieżdzasz nie ma miejsca!!", TagType.parkAndGo)
  7: Payload("Na parking w ktory jest w pobliżu sa wolne miejsca :D", TagType.parkAndGo)
  8: Payload("Będzie dziś padać o godzinie 13!", TagType.other)
  9: Payload("Dziś będzie świeciło słonce!", TagType.other)
}

class Payload {
  final String description;

  const Payload(this.description, this.type);

  final TagType type;
}
