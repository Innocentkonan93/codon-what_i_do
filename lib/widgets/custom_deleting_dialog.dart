import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoknot/models/note_model.dart';

class CustomDeletingDialog extends StatelessWidget {
  const CustomDeletingDialog({
    required this.note,
    Key? key,
  }) : super(key: key);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: double.infinity,
        height: size.height / 2,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "Êtes-vous sûr de vouloir supprimer la note ?",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Transform.rotate(
                  angle: -25,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 250,
                    height: double.infinity,
                    color: Color(int.parse(note.noteColor)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(20, (index) {
                            if (index.isOdd) {
                              return Container(
                                width: 3,
                                // color: Colors.blueGrey[900],
                              );
                            }
                            return CircleAvatar(
                              radius: 6,
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                            );
                          }),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: const Color(0xFF263238),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text(
                      "Non",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                  const VerticalDivider(),
                  TextButton(
                    child: Text(
                      "Oui",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
