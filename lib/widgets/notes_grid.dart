import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/widgets/widgets.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    Key? key,
    required this.notes,
    required this.isGrid,
  }) : super(key: key);
  final List<NoteModel> notes;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return notes.isEmpty
        ? Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  const Spacer(
                    flex: 7,
                  ),
                  Text(
                    'Vous n\'avez aucune note',
                    style: Theme.of(context).textTheme.headline6!,
                  ),
                  Text(
                    'Ajouter votre première note ici !',
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
              Positioned(
                left: -50,
                top: MediaQuery.of(context).size.height / 5,
                child: Icon(
                  CupertinoIcons.doc_on_clipboard_fill,
                  size: 200,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.08),
                ),
              ),
              Image.asset(
                "assets/images/new-arrow.png",
                fit: BoxFit.cover,
              )
            ],
          )
        : GridView.builder(
            gridDelegate: !isGrid
                ? const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 200
                    // childAspectRatio: 0.8,
                    )
                : const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 200
                    // childAspectRatio: 0.8,
                    ),
            padding: const EdgeInsets.all(8),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              NoteModel note = notes[index];
              return PhysicalModel(
                elevation: 10,
                shadowColor: Colors.black,
                color: Color(int.parse(note.noteColor)),
                child: NoteSheet(
                  key: ValueKey(note.id),
                  note: note,
                  isGrid: isGrid,
                ),
              );
            },
          );
  }
}
