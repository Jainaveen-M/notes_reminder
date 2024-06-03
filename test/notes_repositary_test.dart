import 'package:flutter_test/flutter_test.dart';
import 'package:maersk/data/notes_repositary.dart';
import 'package:maersk/model/note.dart';

void main() {
  group("Notes Repositary testcases for adding updating notes", () {
    late NotesRepositary notesRepositary;
    setUp(() {
      notesRepositary = NotesRepositary();
    });

    test("get all the notes", () {
      var notes = notesRepositary.getNotes();
      expect(notes, isA<List<Note>>());
    });

    test("get all the notes", () {
      var notes = notesRepositary.getNotes();
      expect(notes, isA<List<Note>>());
    });

    test("update notes", () async {
      var notes = notesRepositary.getNotes();
      notesRepositary.updateNote(
        Note(
          id: 1,
          title: "Title 2",
          content: "Content 2",
          createAt: "12:00:00",
          timeToRemind: "10 mins",
        ),
      );
      expect(
          notes[0],
          equals(
            Note(
              id: 1,
              title: "Title 2",
              content: "Content 2",
              createAt: "12:00:00",
              timeToRemind: "10 mins",
            ),
          ));
    });

    test("update notes by changing overdue to true", () async {
      var notes = notesRepositary.getNotes();
      notesRepositary.updateNote(
        Note(
          id: 1,
          title: "Title 2",
          content: "Content 2",
          createAt: "12:00:00",
          timeToRemind: "10 mins",
          isOverDue: true,
        ),
      );
      expect(
          notes[0],
          equals(
            Note(
              id: 1,
              title: "Title 2",
              content: "Content 2",
              createAt: "12:00:00",
              timeToRemind: "10 mins",
              isOverDue: true,
            ),
          ));
    });

    test("update notes by changing overdue to false", () async {
      var notes = notesRepositary.getNotes();
      notesRepositary.updateNote(
        Note(
          id: 1,
          title: "Title 2",
          content: "Content 2",
          createAt: "12:00:00",
          timeToRemind: "10 mins",
          isOverDue: false,
        ),
      );
      expect(
          notes[0],
          equals(
            Note(
              id: 1,
              title: "Title 2",
              content: "Content 2",
              createAt: "12:00:00",
              timeToRemind: "10 mins",
              isOverDue: false,
            ),
          ));
    });

    test("update notes by changing visited to true", () async {
      var notes = notesRepositary.getNotes();
      notesRepositary.updateNote(
        Note(
          id: 1,
          title: "Title 2",
          content: "Content 2",
          createAt: "12:00:00",
          timeToRemind: "10 mins",
          isVisited: true,
        ),
      );
      expect(
          notes[0],
          equals(
            Note(
              id: 1,
              title: "Title 2",
              content: "Content 2",
              createAt: "12:00:00",
              timeToRemind: "10 mins",
              isVisited: true,
            ),
          ));
    });

    test("update notes by changing visited to false", () async {
      var notes = notesRepositary.getNotes();
      notesRepositary.updateNote(
        Note(
          id: 1,
          title: "Title 2",
          content: "Content 2",
          createAt: "12:00:00",
          timeToRemind: "10 mins",
          isVisited: false,
        ),
      );
      expect(
          notes[0],
          equals(
            Note(
              id: 1,
              title: "Title 2",
              content: "Content 2",
              createAt: "12:00:00",
              timeToRemind: "10 mins",
              isVisited: false,
            ),
          ));
    });
  });

  group("Notes Repositary testcases getting time options", () {
    late NotesRepositary notesRepositary;
    setUp(() {
      notesRepositary = NotesRepositary();
    });
    test("get all the time options to add", () {
      var notes = notesRepositary.getTimeOption();
      expect(notes, isA<List<String>>());
    });
  });
}
