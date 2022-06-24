// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/services/NotificationService.dart';
import 'package:timezone/timezone.dart' as tz;

import '../bloc/notes/notes_bloc.dart';

class CustomDateTimePicker extends StatefulWidget {
  const CustomDateTimePicker({
    Key? key,
    required this.note,
  }) : super(key: key);
  final NoteModel note;

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? reminderTime;
  TimeOfDay? minutesSelected;
  bool isLoading = false;

  DateTime? reminderDate;
  String? date;
  String? time;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: reminderDate ?? selectedDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      helpText: "Choisir la date du rappel",
      builder: (context, child) {
        return Theme(
            data: ThemeData(
              primaryColor: const Color(0xFF263238),
              colorScheme: Theme.of(context).colorScheme,
            ),
            child: child!);
      },
    );

    // ignore: unnecessary_null_comparison
    if (picked != null && picked != selectedDate) {
      setState(() {
        reminderDate = picked;
        date = DateFormat('dd MM yyyy').format(reminderDate!).toString();
        print(date);
      });
    } else {
      return;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final timePicked = await showTimePicker(
      context: context,
      initialTime: reminderTime ?? selectedTime,
      helpText: "Choisir une heure",
    );
    // ignore: unnecessary_null_comparison
    if (timePicked != null && timePicked != selectedTime) {
      setState(() {
        reminderTime = timePicked;
        final remindHour = timePicked.hour.toString();
        final remindMinute = timePicked.minute.toString();

        time = remindHour.toString().padLeft(2, "0") +
            ':' +
            remindMinute.toString().padLeft(2, "0");
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -25,
            left: -30,
            child: SvgPicture.asset(
              "assets/icons/clock.svg",
              height: 250,
              width: 250,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.02),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6)),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Définir un rappel pour la note",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      splashColor: Theme.of(context).colorScheme.primary,
                      child: Container(
                        width: 250,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.2),
                        ),
                        child: Center(
                          child: Text(
                            date == null ? "Choisir la date" : date!,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: date == null ? null : 22,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (date != null)
                      InkWell(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.2),
                          ),
                          child: Center(
                            child: Text(
                              time == null ? "Choisir l'heure" : time!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: time == null ? null : 22,
                                  ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              if (time != null)
                BlocBuilder<NotesBloc, NotesState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        final noteReminderDate = DateTime(
                          reminderDate!.year,
                          reminderDate!.month,
                          reminderDate!.day,
                          reminderTime!.hour,
                          reminderTime!.minute,
                        );
                        // NotificationApi.notification
                        //     .getNotificationAppLaunchDetails();
                        NotificationApi.showSchudleNotification(
                          // schudelDate: tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
                          schudelDate: tz.TZDateTime.parse(
                              tz.local, noteReminderDate.toString()),
                          id: widget.note.id,
                          title: "Note: ${widget.note.noteTitle}",
                          body:
                              "Votre note requiert votre attention, jetez un oeil",
                          payload: widget.note.id.toString(),
                        );

                        context.read<NotesBloc>().add(
                              EditNote(
                                note: widget.note.copyWith(
                                    noteReminderDate: noteReminderDate),
                              ),
                            );
                        Navigator.pop(context);
                        const snackBar = SnackBar(
                          content: Text('Rappel ajouté'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text('Appliquer'),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        elevation: 3,
                        minimumSize: const Size(125, 30),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
