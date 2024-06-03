import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maersk/bloc/bloc/notes_bloc.dart';
import 'package:maersk/model/note.dart';

class CustomListTile extends StatelessWidget {
  final Note note;
  const CustomListTile({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NotesBloc>(context).add(
          NavigateToEditScreen(
            editNote: note,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 90,
          child: Card(
            color: note.isVisited
                ? const Color.fromARGB(255, 164, 126, 229)
                : note.isOverDue
                    ? const Color.fromARGB(255, 224, 66, 66)
                    : const Color.fromARGB(255, 90, 196, 222),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        note.content,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        note.id.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        note.createAt,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Remind in ${note.timeToRemind}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Status : ",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            note.isOverDue && !note.isVisited
                                ? const TextSpan(
                                    text: "Over due",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : note.isVisited
                                    ? const TextSpan(
                                        text: "Visited",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const TextSpan(
                                        text: "Yet to review",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
