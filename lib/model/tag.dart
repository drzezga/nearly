enum TagType {
  warning,
  pedestrianStop,
  busDeparture,
  parkAndGo,
}

String titleFromTagType(TagType type) {
  switch (type) {
    case TagType.warning:
      return 'Uwaga';
    case TagType.pedestrianStop:
      return 'Światło dla przechodniów';
    case TagType.busDeparture:
      return 'Odjazd';
    case TagType.parkAndGo:
      return 'Parkuj i jedź';
  }
}

class Tag {
  final String content;
  final TagType type;
  final dynamic payload;

  const Tag(this.content, this.type, this.payload);
}