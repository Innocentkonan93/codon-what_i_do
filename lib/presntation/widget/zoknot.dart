import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoknot/data/Database/note_database.dart';

class Zoknot extends StatefulWidget {
  const Zoknot({Key? key}) : super(key: key);

  @override
  State<Zoknot> createState() => _ZoknotState();
}

class _ZoknotState extends State<Zoknot> {
  bool isGrid = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {

            },
            child:
                SvgPicture.asset('assets/icons/check.svg', color: Colors.cyan),
          )
        ],
      ),
//
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isGrid = !isGrid;
          });
        },
        child: SvgPicture.asset('assets/icons/edit-2.svg', color: Colors.white),
      ),
      // bottomSheet: CustomBottomSheet(),
    );
  }
}
