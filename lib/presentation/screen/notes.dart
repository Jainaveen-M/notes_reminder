import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maersk/bloc/bloc/notes_bloc.dart';
import 'package:maersk/model/note.dart';
import 'package:maersk/presentation/screen/add_notes.dart';
import 'package:maersk/presentation/screen/edit_notes.dart';
import 'package:maersk/presentation/widgets/custom_list_title.dart';
import 'package:maersk/util/toast.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(FetchNotes());
    super.initState();
  }

  Future<void> _handleRefresh() async {
    context.read<NotesBloc>().add(FetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<NotesBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 164, 126, 229),
          title: const Text(
            "Notes",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: BlocConsumer<NotesBloc, NotesState>(
          buildWhen: (previous, current) => current is NotesLoaded,
          listenWhen: (previous, current) =>
              current is ShowErrorMessage || current is NavigateEditScereen,
          listener: (context, state) {
            if (state is NavigateEditScereen) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNotesScreen(
                    editNote: state.editNote,
                  ),
                ),
              );
            }
            if (state is ShowErrorMessage) {
              CustomToast.showErroMessage(state.message);
            }
          },
          builder: (context, state) {
            if (state is NotesLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: ListView.builder(
                        itemCount: state.notes.length,
                        itemBuilder: (context, index) {
                          Note note = state.notes[index];
                          log(note.id.toString());
                          return CustomListTile(note: note);
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddNotes()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
