import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoknot/configs/theme.dart';

import '../bloc/theme/change_theme_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool? darkMode;
  void toggleDarkMode(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool("darkMode", val);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
      builder: (context, state) {
        bool isDark = (state as LoadTheme).themeData == darkTheme;
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
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      title: Text(
                        'Thème sombre',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      onTap: () {
                        if (isDark) {
                          context
                              .read<ChangeThemeBloc>()
                              .add(LightTheme(lighTheme: lightTheme));
                        } else {
                          context
                              .read<ChangeThemeBloc>()
                              .add(DarkTheme(darkTheme: darkTheme));
                        }
                      },
                      trailing: Switch.adaptive(
                        value: isDark,
                        onChanged: (value) {
                          if (isDark) {
                            context
                                .read<ChangeThemeBloc>()
                                .add(LightTheme(lighTheme: lightTheme));
                          } else {
                            context
                                .read<ChangeThemeBloc>()
                                .add(DarkTheme(darkTheme: darkTheme));
                          }
                        },
                      ),
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/share-2.svg",
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      title: Text(
                        'Partager à un ami',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (Platform.isIOS) {
                          Share.share(
                            "Zoknot, une superbe application de note essai-le\nhttps://apps.apple.com/us/app/zoknot/id1622896004",
                            // subject: "Partager Zoknot",
                          );
                        } else {
                          Share.share(
                            "Zoknot, une superbe application de note essai-le\nhttps://play.google.com/store/apps/details?id=com.story.zoknot",
                            // subject: "Partager Zoknot",
                          );
                        }
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/log-out.svg",
                        color: Theme.of(context).colorScheme.onBackground,
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
                const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("V 1.2.43"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
