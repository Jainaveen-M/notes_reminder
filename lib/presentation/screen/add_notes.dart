import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maersk/bloc/bloc/notes_bloc.dart';
import 'package:maersk/data/notes_repositary.dart';
import 'package:maersk/model/note.dart';
import 'package:maersk/presentation/widgets/custom_text_field.dart';
import 'package:maersk/util/service_location.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String? _selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 164, 126, 229),
        title: const Text(
          "Notes",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NavigateToHome) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                textEditingController: titleController,
                hint: "Title",
              ),
              CustomTextField(
                textEditingController: contentController,
                hint: "Content",
              ),
              DropdownButton<String>(
                value: _selectedTime,
                hint: const Text('Time to Remind'),
                items: serviceLocator<NotesRepositary>()
                    .getTimeOption()
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedTime = newValue;
                  });
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    DateTime now = DateTime.now();
                    String formattedTime = DateFormat.Hms().format(now);
                    BlocProvider.of<NotesBloc>(context).add(
                      AddNotesEvent(
                        newNote: Note(
                          id: serviceLocator<NotesRepositary>()
                              .getTimeOption()
                              .length,
                          content: contentController.text,
                          title: titleController.text,
                          createAt: formattedTime,
                          timeToRemind: _selectedTime ?? "",
                        ),
                      ),
                    );
                  },
                  child: const Text("Add Notes"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
