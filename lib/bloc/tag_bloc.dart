import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/tag.dart';

abstract class TagEvent {}

class TagReadEvent extends TagEvent {
  final String uuid;
  final int minor;
  final int major;

  TagReadEvent(this.uuid, this.minor, this.major);
}

class TagBloc extends Bloc<TagEvent, List<Tag>> {
  TagBloc()
      : super([
          Tag(TagType.warning, 7, DateTime.now(), "b"),
          Tag(TagType.pedestrianStop, 4, DateTime.now(), "a")
        ]) {
    on<TagReadEvent>((event, emit) {
      int decryptedPayload = event.minor;

      for (var tag in state) {
        if (tag.uuid == event.uuid && tag.payload == decryptedPayload) {
          return;
        }
      }

      emit([Tag(TagType.other, decryptedPayload, DateTime.now(), event.uuid), ...state]);
    });
  }
}
