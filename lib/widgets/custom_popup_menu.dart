import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/widgets/widgets.dart';

import '../bloc/notes/notes_bloc.dart';

class CustomPopuMenu extends StatefulWidget {
  const CustomPopuMenu({
    Key? key,
    required this.note,
  }) : super(key: key);
  final NoteModel note;

  @override
  State<CustomPopuMenu> createState() => _CustomPopuMenuState();
}

class _CustomPopuMenuState extends State<CustomPopuMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (context, state) {
        if (state is NotesLoaded) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return PopupMenuButton(
          icon: SvgPicture.asset(
            "assets/icons/more-vertical.svg",
            color: Colors.white,
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: "police",
                child: Row(
                  children: const [
                    Text(
                      'Aa',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 25),
                    Expanded(child: Text("Modifier la police"))
                  ],
                ),
              ),
              PopupMenuItem(
                value: "share",
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/share-2.svg",
                        color: Colors.white),
                    const SizedBox(width: 25),
                    const Expanded(child: Text("Partager la note"))
                  ],
                ),
              ),
              PopupMenuItem(
                value: "rappel",
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/clock.svg",
                        color: Colors.white),
                    const SizedBox(width: 25),
                    const Text("Ajouter un rappel")
                  ],
                ),
              ),
              PopupMenuItem(
                value: "delete",
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/trash-2.svg",
                        color: Colors.white),
                    const SizedBox(width: 25),
                    const Expanded(child: Text("Supprimer la note"))
                  ],
                ),
              ),
            ];
          },
          onSelected: (val) async {
            print(val);
            if (val == "delete") {
              final result = await showDialog(
                context: context,
                builder: (context) {
                  return CustomDeletingDialog(
                    note: widget.note,
                  );
                },
              );
              if (result == true) {
                context.read<NotesBloc>().add(DeleteNote(note: widget.note));
              } else {
                return;
              }
            }

            if (val == "police") {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                context: context,
                builder: (context) {
                  return CustomTextStylePanel(
                    textStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  );
                },
              );
            }
          },
          offset: const Offset(-15, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          color: Theme.of(context).colorScheme.background,
          // color: Colors.black38,
        );
      },
    );
  }
}
