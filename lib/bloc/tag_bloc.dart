import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/model/payload.dart';

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
          // Tag(TagType.warning, 0, DateTime.now(), "b"),
          // Tag(TagType.pedestrianStop, 2, DateTime.now(), "a")
        ]) {
    on<TagReadEvent>((event, emit) {
      int decryptedPayload = event.minor;

      for (var tag in state) {
        if (tag.uuid == event.uuid && tag.payload == decryptedPayload) {
          return;
        }
      }

      state.removeWhere((element) => element.uuid == event.uuid);

      emit([
        Tag(
            mapa[decryptedPayload]!.type,
            decryptedPayload,
            DateTime.now(),
            event.uuid),
        ...state
      ]);
    });
  }
}
