import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whai_i_do/data/Database/note_database.dart';
import 'package:whai_i_do/data/Models/Note.dart';
import 'package:whai_i_do/data/Services/NotificationService.dart';
import 'package:whai_i_do/data/cubit/theme_cubit.dart';
import 'package:timezone/timezone.dart' as tz;

class NewreminderForm extends StatefulWidget {
  final Note note;
  const NewreminderForm({required this.note, Key? key}) : super(key: key);

  @override
  _NewreminderFormState createState() => _NewreminderFormState();
}

class _NewreminderFormState extends State<NewreminderForm> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? reminderTime;
  TimeOfDay? minutesSelected;
  bool isLoading = false;
  late List<Note> notes;

  DateTime? reminderDate;
  String? date;
  String? time;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: reminderDate ?? selectedDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      helpText: "Cho!sir la date",
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

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    notes = await NoteDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final bool isDark = themeCubit.isDark;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 5,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Icon(Icons.alarm, size: 55),
            const SizedBox(
              height: 20,
            ),
            if (DateTime.now().isBefore(widget.note.reminderDate!))
              const Text('Rappel déjà activé'),
            // if (widget.note.reminderDate!.isAfter(DateTime.now()))
            if (DateTime.now().isAfter(widget.note.reminderDate!))
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white12 : Colors.black12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: reminderDate != null
                      ? Center(
                          child: Text(
                            "$date",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Choisir une date',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (reminderDate != null)
              InkWell(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white12 : Colors.black12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: reminderTime != null
                      ? Center(
                          child: Text(
                            "$time",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Choisir une heure',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (DateTime.now().isAfter(widget.note.reminderDate!))
                      ? () async {
                         
                          if(reminderDate != null){
                             final timer = DateTime(
                          reminderDate!.year,
                          reminderDate!.month,
                          reminderDate!.day,
                          reminderTime!.hour,
                          reminderTime!.minute,
                        );
                        print(timer);
                            NotificationApi.showSchudleNotification(
                          // schudelDate: tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
                          schudelDate:
                              tz.TZDateTime.parse(tz.local, timer.toString()),
                          id: widget.note.id,
                          title: "Note: ${widget.note.title}",
                          body:
                              "Votre note requiert votre attention, jetez un oeil",
                          payload: "payload",
                        );
                        await NoteDatabase.instance
                            .updateNote(
                          Note(
                              id: widget.note.id,
                              title: widget.note.title,
                              isImportant: widget.note.isImportant,
                              isUrgent: widget.note.isUrgent,
                              number: widget.note.number,
                              description: widget.note.description,
                              reminderDate: DateTime(
                                reminderDate!.year,
                                reminderDate!.month,
                                reminderDate!.day,
                                selectedTime.hour,
                                selectedTime.minute,
                              ),
                              createdTime: widget.note.createdTime),
                        )
                            .then((value) {
                          Navigator.pop(context, true);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.alarm,
                                      color: Colors.white,
                                      size: 75,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Rappel ajouté",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).then((value) {
                          Future.delayed(const Duration(seconds: 2), () {
                            Get.back();
                          });
                        });
                          }
                        }
                      : () async {
                          NotificationApi.cancel(widget.note.id!);
                          await NoteDatabase.instance
                              .updateNote(
                            Note(
                              id: widget.note.id,
                              title: widget.note.title,
                              isImportant: widget.note.isImportant,
                              isUrgent: widget.note.isUrgent,
                              number: widget.note.number,
                              description: widget.note.description,
                              reminderDate: DateTime(0, 0),
                              createdTime: widget.note.createdTime,
                            ),
                          )
                              .then((value) {
                            Navigator.pop(context, true);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.alarm,
                                        color: Colors.white,
                                        size: 75,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Rappel désactivé",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).then((value) {
                            Future.delayed(Duration(seconds: 2), () {
                              Get.back();
                            });
                          });
                        },
              child: (DateTime.now().isAfter(widget.note.reminderDate!))
                  ? const Text('Ajouter')
                  : const Text('Désactiver'),
              style: ElevatedButton.styleFrom(
                primary: (DateTime.now().isAfter(widget.note.reminderDate!))
                    ? Colors.green
                    : Colors.red,
                elevation: 0.0,
                shape: const StadiumBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
