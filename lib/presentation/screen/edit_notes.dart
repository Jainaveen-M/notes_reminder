import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maersk/bloc/bloc/notes_bloc.dart';
import 'package:maersk/data/notes_repositary.dart';
import 'package:maersk/model/note.dart';
import 'package:maersk/presentation/widgets/custom_text_field.dart';
import 'package:maersk/util/service_location.dart';

class EditNotesScreen extends StatefulWidget {
  final Note editNote;
  const EditNotesScreen({
    super.key,
    required this.editNote,
  });

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String? _selectedTime;

  @override
  void initState() {
    titleController.text = widget.editNote.title;
    contentController.text = widget.editNote.content;
    timeController.text = widget.editNote.createAt;
    _selectedTime = widget.editNote.timeToRemind;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 164, 126, 229),
        title: const Text(
          "Edit Notes",
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
                  textEditingController: titleController, hint: "Title"),
              CustomTextField(
                  textEditingController: contentController, hint: "Content"),
              Text(
                "Created time : ${timeController.text}",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
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
                      _selectedTime = newValue!;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<NotesBloc>(context).add(MarkAsVisited(
                        id: widget.editNote.id,
                      ));
                    },
                    child: const Text("Mark as Visited"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<NotesBloc>(context).add(
                        UpdateNote(
                          updateNote: Note(
                            id: widget.editNote.id,
                            content: contentController.text,
                            title: titleController.text,
                            createAt: timeController.text,
                            timeToRemind: _selectedTime ?? "",
                          ),
                        ),
                      );
                    },
                    child: const Text("Update Notes"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
