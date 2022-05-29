import 'package:flutter/material.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/screens/screens.dart';

class NoteSheet extends StatelessWidget {
  const NoteSheet({
    Key? key,
    required this.isGrid,
    required this.note,
  }) : super(key: key);

  final bool isGrid;
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    print(note.noteColor.split('').first);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NoteScreen(noteId: note.id!);
            },
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        color: Color(int.parse(note.noteColor)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: isGrid
                    ? List.generate(17, (index) {
                        if (index.isOdd) {
                          return Container(
                            width: 3,
                            // color: Colors.blueGrey[900],
                          );
                        }
                        return CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.blueGrey[900],
                        );
                      })
                    : List.generate(30, (index) {
                        if (index.isOdd) {
                          return Container(
                            width: 3,
                            // color: Colors.blueGrey[900],
                          );
                        }
                        return CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.blueGrey[900],
                        );
                      }),
              ),
            ),
            Expanded(
              child: Text(note.noteColor.toString()),
            ),
            Container(
              width: double.infinity,
              height: 35,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0XFFACACAC).withOpacity(0.15),
                  const Color(0XFF050505).withOpacity(0.25)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
