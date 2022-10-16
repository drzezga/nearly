import 'package:hackathon/model/tag.dart';

Map<int, Payload> mapa = {
  0: const Payload("Wykryto wyciek gazu. Proszę udać się do wyjścia ewakuacyjnego.", TagType.warning),
  1: const Payload("Wykryto ogień. Proszę udać się do wyjścia ewakuacyjnego.", TagType.warning),
  2: const Payload("Uważaj, czerwone!!", TagType.pedestrianStop),
  3: const Payload("Można iść, zielone :)", TagType.pedestrianStop),
  4: const Payload("Twój autobus przyjeżdża za 2 minuty!", TagType.busDeparture),
  5: const Payload("Masz 20 min do przyjazdu twojego autobusu!", TagType.busDeparture),
  6: const Payload("Na parkingu, na który wieżdzasz, nie ma wolnych miejsc.", TagType.parkAndGo),
  7: const Payload("Na parkingu, który jest w pobliżu, są wolne miejsca. Zmniejsz swój wpływ na środowisko. Przsiądź się na tramwaj.", TagType.parkAndGo),
  8: const Payload("Będzie dziś padać o godzinie 13!", TagType.other),
  9: const Payload("Dziś będzie świeciło słonce! Życzymy miłego dnia.", TagType.other),
};

class Payload {
  final String description;

  const Payload(this.description, this.type);

  final TagType type;
}
