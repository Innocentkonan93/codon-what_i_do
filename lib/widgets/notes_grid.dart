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
        ? Center(
            child: Text(
              'Vous n\'avez aucune note',
              style: Theme.of(context).textTheme.headline6!,
            ),
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
              return NoteSheet(
                key: ValueKey(note.id),
                note: note,
                isGrid: isGrid,
              );
            },
          );
  }
}
