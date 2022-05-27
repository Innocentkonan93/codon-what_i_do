import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoknot/data/cubit/theme_cubit.dart';

class EditPolice extends StatefulWidget {
  final double fontSize;
  const EditPolice(this.fontSize, {Key? key}) : super(key: key);

  @override
  _EditPoliceState createState() => _EditPoliceState();
}

class _EditPoliceState extends State<EditPolice> {
  double fontSize = 18;
  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final bool isDark = themeCubit.isDark;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.34,
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
          // const SizedBox(
          //   height: 10,
          // ),
          // const Text(
          //   "Ajouter un rappel",
          // ),
          
          
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Aa",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                width: 300,
                child: Slider(
                  value: fontSize,
                  divisions: 10,
                  min: 14,
                  max: 40,
                  activeColor: Colors.cyan,
                  thumbColor: Colors.cyan,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      fontSize = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, fontSize);
            },
            child: const Text('Appliquer'),
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                elevation: 0.0,
                shape: const StadiumBorder()),
          )
        ],
      ),
    );
  }
}
