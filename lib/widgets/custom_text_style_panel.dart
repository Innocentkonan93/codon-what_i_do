import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoknot/models/note_model.dart';

import '../bloc/notes/notes_bloc.dart';
import '../bloc/style/sheet_style_bloc.dart';

// ignore: must_be_immutable
class CustomTextStylePanel extends StatefulWidget {
  CustomTextStylePanel({
    required this.fontSize,
    required this.textAlign,
    this.note,
    Key? key,
  }) : super(key: key);
  final double fontSize;
  final TextAlign textAlign;
  final NoteModel? note;

  @override
  State<CustomTextStylePanel> createState() => _CustomTextStylePanelState();
}

class _CustomTextStylePanelState extends State<CustomTextStylePanel> {
  double fontSize = 16.0;
  List<String> textStyleIcon = [
    "assets/icons/align-center.svg",
    "assets/icons/align-justify.svg",
    "assets/icons/align-right.svg",
    "assets/icons/align-left.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, noteState) {
        return BlocBuilder<SheetStyleBloc, SheetStyleState>(
          builder: (context, sheetState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.6),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Taille de police",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0XFFBEBEBE).withOpacity(0.25),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    fontSize--;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                    "assets/icons/arrow-left.svg",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      "$fontSize",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    fontSize++;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                    "assets/icons/arrow-right.svg",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: textStyleIcon
                        .map((icon) => SvgPicture.asset(
                              icon,
                              color: Theme.of(context).colorScheme.onBackground,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.note != null) {
                        context.read<NotesBloc>().add(
                              EditNote(
                                note: widget.note!.copyWith(
                                  noteFontSize: fontSize,
                                  noteTextAlign: "left",
                                ),
                              ),
                            );
                        Navigator.pop(context);
                      } else {
                        context.read<SheetStyleBloc>().add(
                              SetSheetStyle(
                                  fontSize: fontSize, textAlign: "left"),
                            );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Appliquer',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      elevation: 3,
                      minimumSize: const Size(125, 30),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
