part of 'notes_bloc.dart';

sealed class NotesState {}

final class NotesInitial extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;
  NotesLoaded({
    required this.notes,
  });
}

class NavigateEditScereen extends NotesState {
  final Note editNote;
  NavigateEditScereen({
    required this.editNote,
  });
}

class ShowErrorMessage extends NotesState {
  final String message;
  ShowErrorMessage({
    required this.message,
  });
}

class NavigateToHome extends NotesState {}
