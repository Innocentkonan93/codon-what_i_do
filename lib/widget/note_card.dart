import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:whai_i_do/Models/note.dart';

class NoteCardWidget extends StatefulWidget {
  final Note note;
  final int index;
  const NoteCardWidget({
    required this.note,
    required this.index,
  });

  @override
  _NoteCardWidgetState createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  @override
  Widget build(BuildContext context) {
    final date = DateFormat("d.M.yyyy ").format(widget.note.createdTime);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(
        vertical: 5
      ),
      decoration: BoxDecoration(
          color: !widget.note.isImportant ? Colors.yellow[700] : Colors.cyan,
          // borderRadius:
          //     const BorderRadius.vertical(bottom: Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.black45,
              spreadRadius: 2,
              blurRadius: 20
            )
          ]
      ),
      child: Center(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              20,
              (index) {
                if(index.isOdd){
                  return Container(
                    height: 1,
                    width: 2,
                    color: Colors.blueGrey[900],
                  );
                }
                return CircleAvatar(
                radius: 5,
                backgroundColor: Colors.blueGrey[900],
              );
              }
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.note.title,
            // style: const TextStyle(
            //   fontWeight: FontWeight.bold,
            //   fontSize: 18,
            // ),
            style: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            widget.note.description,
            textAlign: TextAlign.center,
            // style: const TextStyle(
            //   // fontWeight: FontWeight.bold,
            //   fontSize: 15,
            //   overflow: TextOverflow.ellipsis,
            // ),
            style: GoogleFonts.quicksand(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
          ),
          const Spacer(),
          const SizedBox(height: 10),
          Text(
            date.toString(),
            // style: const TextStyle(
            //     fontWeight: FontWeight.w500,
            //     fontSize: 15,
            //     color: Colors.black38),
            style: GoogleFonts.quicksand(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black38
            ),
          ),
        ],
      )),
    );
  }
}
