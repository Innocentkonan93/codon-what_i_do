import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewNoteSheet extends StatelessWidget {
  const NewNoteSheet({
    required this.sheetColor,
    required this.textStyle,
    required this.onTitleChanged,
    required this.onBodyChanged,
    Key? key,
  }) : super(key: key);
  final Color sheetColor;
  final TextStyle textStyle;
  final Function(String)? onTitleChanged;
  final Function(String)? onBodyChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
      height: 350,
      decoration: BoxDecoration(color: Colors.grey, boxShadow: [
        BoxShadow(
          offset: const Offset(0, 1),
          color: Colors.black.withOpacity(0.16),
          blurRadius: 6,
        )
      ]),
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
                backgroundColor: Colors.blueGrey[900],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Titre',
              ),
              style: GoogleFonts.signikaNegative(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              onChanged: onTitleChanged,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Text',
                      ),
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
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
  }
}
