import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                DrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: Colors.cyan,
                  // ),
                  child: Center(
                    child: Text(
                      'Zoknot',
                      style: GoogleFonts.pacifico(
                          fontWeight: FontWeight.w100, fontSize: 52),
                    ),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/moon.svg",
                    color: Colors.white,
                  ),
                  title: Text(
                    'Thème sombre',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  trailing: Switch.adaptive(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/share-2.svg",
                    color: Colors.white,
                  ),
                  title: Text(
                    'Partager à un ami',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  onTap: () {
                    exit(0);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/log-out.svg",
                    color: Colors.white,
                  ),
                  title: Text(
                    'Quitter l\'app',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    if (Platform.isAndroid) {
                      // SystemNavigator.pop();
                      exit(0);
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                ),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("V 1.2.43"),
            )
          ],
        ),
      ),
    );
  }
}
