import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDateTimePicker extends StatefulWidget {
  const CustomDateTimePicker({
    Key? key,
  }) : super(key: key);

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
    );

    // ignore: unnecessary_null_comparison
    if (picked != null && picked != selectedDate) {
      setState(() {
        reminderDate = picked;
        // date = DateFormat('dd MM yyyy').format(reminderDate!).toString();
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
      height: 450,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 3,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white54,
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context);
              _selectTime(context);
            },
            child: const Text('Appliquer'),
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
  }
}
