part of 'notes_bloc.dart';

sealed class NotesEvent {}

class FetchNotes extends NotesEvent {}

class AddNotesEvent extends NotesEvent {
  final Note newNote;
  AddNotesEvent({
    required this.newNote,
  });
}

class NavigateToEditScreen extends NotesEvent {
  final Note editNote;
  NavigateToEditScreen({
    required this.editNote,
  });
}

class UpdateNote extends NotesEvent {
  final Note updateNote;
  UpdateNote({
    required this.updateNote,
  });
}

class MarkAsVisited extends NotesEvent {
  final int id;
  MarkAsVisited({
    required this.id,
  });
}

class RefereshListEvent extends NotesEvent {}
