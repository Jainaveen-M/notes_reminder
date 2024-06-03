import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maersk/data/notes_repositary.dart';
import 'package:maersk/model/note.dart';
import 'package:maersk/util/service_location.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<FetchNotes>(_fetchNotes);
    on<AddNotesEvent>(_addNotes);
    on<NavigateToEditScreen>(_navigateToEditScreen);
    on<UpdateNote>(_updateNote);
    on<MarkAsVisited>(_updateVisited);
  }

  FutureOr<void> _fetchNotes(FetchNotes event, Emitter<NotesState> emit) {
    List<Note> notes = [];
    for (Note note in serviceLocator<NotesRepositary>().getNotes()) {
      bool isOverDue = false;
      DateTime createdTime = DateFormat("hh:mm:ss").parse(note.createAt);

      int timeToRemind = int.parse(note.timeToRemind.split(" ")[0]);
      DateTime now = DateTime.now();
      String formattedTime = DateFormat.Hms().format(now);
      DateTime currentTime = DateFormat("hh:mm:ss").parse(formattedTime);
      DateTime est = createdTime.add(Duration(minutes: timeToRemind));
      if (currentTime.compareTo(est) > 0) {
        isOverDue = true;
      }
      log(isOverDue.toString());
      note.isOverDue = isOverDue;
      notes.add(note);
    }
    emit(NotesLoaded(notes: notes));
  }

  FutureOr<void> _addNotes(AddNotesEvent event, Emitter<NotesState> emit) {
    if (event.newNote.title.isEmpty) {
      emit(ShowErrorMessage(message: "Title should not be empty"));
    } else if (event.newNote.content.isEmpty) {
      emit(ShowErrorMessage(message: "Content should not be empty"));
    } else if (event.newNote.timeToRemind.isEmpty) {
      emit(ShowErrorMessage(message: "Reminder should not be empty"));
    } else {
      serviceLocator<NotesRepositary>().addNotes(event.newNote);
      emit(NotesLoaded(notes: serviceLocator<NotesRepositary>().getNotes()));
      emit(NavigateToHome());
    }
  }

  FutureOr<void> _navigateToEditScreen(
      NavigateToEditScreen event, Emitter<NotesState> emit) {
    emit(NavigateEditScereen(editNote: event.editNote));
  }

  FutureOr<void> _updateNote(UpdateNote event, Emitter<NotesState> emit) {
    if (event.updateNote.title.isEmpty) {
      emit(ShowErrorMessage(message: "Title should not be empty"));
    } else if (event.updateNote.content.isEmpty) {
      emit(ShowErrorMessage(message: "Content should not be empty"));
    } else if (event.updateNote.timeToRemind.isEmpty) {
      emit(ShowErrorMessage(message: "Reminder should not be empty"));
    } else {
      serviceLocator<NotesRepositary>().updateNote(event.updateNote);
      emit(NotesLoaded(notes: serviceLocator<NotesRepositary>().getNotes()));
      emit(NavigateToHome());
    }
  }

  FutureOr<void> _updateVisited(MarkAsVisited event, Emitter<NotesState> emit) {
    try {
      List<Note> notes = [];
      List<Note> exisitingNotes = serviceLocator<NotesRepositary>().getNotes();
      for (Note note in exisitingNotes) {
        if (note.id == event.id && note.isOverDue) {
          note.isVisited = true;
        }
        notes.add(note);
      }
      emit(NotesLoaded(notes: notes));
      emit(NavigateToHome());
    } catch (e) {
      emit(ShowErrorMessage(message: "Unbale to update visited status"));
    }
  }
}
