import 'package:get_it/get_it.dart';
import 'package:maersk/data/notes_repositary.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  serviceLocator.registerSingleton<NotesRepositary>(NotesRepositary());
}
