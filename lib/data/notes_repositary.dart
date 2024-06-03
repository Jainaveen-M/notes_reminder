import 'dart:math';

import 'package:maersk/model/note.dart';

class NotesRepositary {
  final List<Note> _notes = [
    Note(
      id: 1,
      title: "Title 1",
      content: "Content 1",
      createAt: "12:00:00",
      timeToRemind: "15 mins",
    )
  ];

  final List<String> _timeOptions = ['1 mins', '5 mins', '15 mins', '30 mins'];

  List<Note> getNotes() {
    return _notes;
  }

  List<String> getTimeOption() {
    return _timeOptions;
  }

  void removeNotes(int id) {
    _notes.removeWhere((item) => item.id == id);
  }

  void updateNote(Note note) {
    int index = _notes.indexWhere((item) => item.id == note.id);
    if (index != -1) {
      _notes[index] = note;
    }
  }

  void updateVisited(int id) {
    int index = _notes.indexWhere((item) => item.id == id);
    if (index != -1) {
      _notes[index].isVisited = true;
    }
  }

  void addNotes(Note note) {
    _notes.add(note);
  }

  int getRandomId() {
    Random randomRange = Random();
    return 100 + randomRange.nextInt(1000 - 100 + 1);
  }
}
