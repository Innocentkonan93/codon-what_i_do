// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/widgets/widgets.dart';

import '../bloc/colors/sheet_color_bloc.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    this.note,
    required this.focusNode,
    Key? key,
  }) : super(key: key);

  final NoteModel? note;
  final FocusNode focusNode;
  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    List<Color> sheetColors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      height: 49,
      color: Colors.grey[300],
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.note != null)
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return CustomTextStylePanel(
                      note: widget.note,
                      fontSize: 14,
                      textAlign: TextAlign.left,
                    );
                  },
                );
              },
              child: const Text(
                'Aa|',
                style: TextStyle(color: Colors.orange, fontSize: 20),
              ),
            ),
          BlocBuilder<SheetColorBloc, SheetColorState>(
            builder: (context, state) {
              return widget.note == null
                  ? InkWell(
                      onTap: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const ColorPanel(),
                            );
                          },
                        );

                        if (result != null) {
                          print(result);
                          context.read<SheetColorBloc>().add(
                                SetSheetColor(colorString: result),
                              );
                        }
                      },
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            sheetColors.length,
                            (index) {
                              return Container(
                                height: 12,
                                width: 12,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: sheetColors[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
          TextButton(
            onPressed: () {
              if (widget.focusNode.hasFocus) {
                widget.focusNode.unfocus();
              } else {
                widget.focusNode.requestFocus();
              }
            },
            child: const Icon(
              Icons.keyboard,
            ),
          )
        ],
      ),
    );
  }
}
