import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/tag.dart';

abstract class TagEvent {}

class TagReadEvent extends TagEvent {}

class TagBloc extends Bloc<TagEvent, List<Tag>> {
  TagBloc() : super([]);
}