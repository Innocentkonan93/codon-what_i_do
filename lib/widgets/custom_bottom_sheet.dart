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
      color: Colors.white12,
      width: double.infinity,
      child: Row(
        children: [
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
          Expanded(
            child: BlocBuilder<SheetColorBloc, SheetColorState>(
              builder: (context, state) {
                return widget.note == null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    sheetColors.length,
                    (index) {
                      return GestureDetector(
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
                            context
                                .read<SheetColorBloc>()
                                .add(SetSheetColor(colorString: result));
                          }
                        },
                        child: Container(
                          height: 15,
                          width: 15,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sheetColors[index],
                          ),
                        ),
                      );
                    },
                  ),
                      )
                    : const SizedBox();
              },
            ),
          ),
          TextButton(
            onPressed: () {
              if (widget.focusNode.hasFocus) {
                widget.focusNode.unfocus();
              } else {
                widget.focusNode.requestFocus();
              }
            },
            child: !widget.focusNode.hasFocus
                ? const Icon(Icons.keyboard)
                : const Icon(Icons.keyboard_hide_rounded),
          )
        ],
      ),
    );
  }
}
