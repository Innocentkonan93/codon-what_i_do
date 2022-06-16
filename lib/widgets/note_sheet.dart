import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(int.parse(note.noteColor)),
              // boxShadow: const [
              //   BoxShadow(
              //       color: Colors.black12, offset: Offset(0, -5), blurRadius: 3)
              // ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 6, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: isGrid
                        ? List.generate(
                            17,
                            (index) {
                              if (index.isOdd) {
                                return Container(
                                  width: 3,
                                  // color: Colors.blueGrey[900],
                                );
                              }
                              return CircleAvatar(
                                  radius: 6,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background);
                            },
                          )
                        : List.generate(
                            30,
                            (index) {
                              if (index.isOdd) {
                                return Container(
                                  width: 3,
                                  // color: Theme.of(context).colorScheme.background
                                );
                              }
                              return CircleAvatar(
                                  radius: 7,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background);
                            },
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
                    child: Column(
                      children: [
                        Text(
                          note.noteTitle,
                          style: GoogleFonts.signikaNegative(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF263238),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            note.noteBody,
                            overflow: TextOverflow.fade,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: const Color(0xFF263238),
                                      fontSize: note.noteFontSize,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                    ),
                            textAlign: note.noteTextAlign == "center"
                                ? TextAlign.center
                                : note.noteTextAlign == "justify"
                                    ? TextAlign.justify
                                    : note.noteTextAlign == "left"
                                        ? TextAlign.left
                                        : TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              // width: double.infinity,
              height: 15,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 72, 72, 72).withOpacity(0.05),
                  const Color(0XFF050505).withOpacity(0.25)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
          )
        ],
      ),
    );
  }
}
