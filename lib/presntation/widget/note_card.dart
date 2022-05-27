import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zoknot/data/cubit/theme_cubit.dart';
import '../../data/Models/Note.dart';

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
    final date = DateFormat("d.M.yyyy").format(widget.note.createdTime);
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    bool isDark = themeCubit.isDark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: widget.note.isImportant
            ? Colors.orange[300]
            : widget.note.isUrgent
                ? Colors.red[300]
                : Colors.cyan[200],
        // borderRadius:
        //     const BorderRadius.vertical(bottom: Radius.circular(12)),
        boxShadow: const [
          BoxShadow(
              offset: Offset(-2, 2),
              color: Colors.black38,
              spreadRadius: 1,
              blurRadius: 10)
        ],
      ),
      child: Center(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(20, (index) {
              if (index.isOdd) {
                return Container(
                  height: 1,
                  width: 2,
                  color: !isDark ? Colors.grey[200] : Colors.blueGrey[900],
                );
              }
              return CircleAvatar(
                radius: 5,
                backgroundColor:
                    !isDark ? Colors.grey[200] : Colors.blueGrey[900],
              );
            }),
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
              color: Colors.black,
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
              color: Colors.black,
            ),
            maxLines: 2,
          ),
          const Spacer(),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                date.toString(),
                style: GoogleFonts.quicksand(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black26),
              ),
              const Spacer(),
              if (DateTime.now().isBefore(widget.note.reminderDate!))
                const Icon(
                  Icons.alarm,
                  size: 15,
                  color: Colors.black87,
                )
            ],
          ),
        ],
      )),
    );
  }
}
