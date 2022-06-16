import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/colors/sheet_color_bloc.dart';

class NewNoteSheet extends StatelessWidget {
  const NewNoteSheet({
    required this.textStyle,
    required this.focusNode,
    required this.onTitleChanged,
    required this.onBodyChanged,
    required this.titlecontroller,
    required this.bodycontroller,
    Key? key,
  }) : super(key: key);
  final TextStyle textStyle;
  final FocusNode focusNode;
  final Function(String)? onTitleChanged;
  final Function(String)? onBodyChanged;

  final TextEditingController titlecontroller;
  final TextEditingController bodycontroller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetColorBloc, SheetColorState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: Color(int.parse((state as SheetColorLoaded).colorString)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                color: Colors.black.withOpacity(0.16),
                blurRadius: 6,
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(30, (index) {
                  if (index.isOdd) {
                    return Container(
                      width: 3,
                      // color: Colors.blueGrey[900],
                    );
                  }
                  return CircleAvatar(
                    radius: 7,
                    backgroundColor: Theme.of(context).colorScheme.background,
                  );
                }),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titlecontroller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ajouter un titre',
                          ),
                          cursorColor: const Color(0xFF263238),
                          style: GoogleFonts.signikaNegative(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          onChanged: onTitleChanged,
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: bodycontroller,
                          focusNode: focusNode,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Votre text ici...',
                          ),
                          cursorColor: const Color(0xFF263238),
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: const Color(0xFF263238),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 2.4,
                                  ),
                          onChanged: onBodyChanged,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
