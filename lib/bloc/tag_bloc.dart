import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/tag.dart';

abstract class TagEvent {}

class TagReadEvent extends TagEvent {}

class TagBloc extends Bloc<TagEvent, List<Tag>> {
  TagBloc()
      : super([
          const Tag("", TagType.warning, "Wyciek gazu w mieszkaniu przy ul. Marszałkowskiej 9"),
          const Tag("", TagType.pedestrianStop, "green")
        ]);
}
