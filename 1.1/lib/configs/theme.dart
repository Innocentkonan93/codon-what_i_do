import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData( 
    scaffoldBackgroundColor: const Color(0xFFe9eef4),
    fontFamily: 'Manrope',
    colorScheme: const ColorScheme(
      primary: Color(0xff3da7ce),
      secondary: Color(0xff3da7ce),
      onPrimary: Color(0xff434343),
      onSecondary: Color(0xff434343),
      onError: Color(0xffc33333),
      background: Color(0xffffffff),
      brightness: Brightness.light,
      onBackground: Color(0xff434343),
      onSurface: Color(0xff434343),
      error: Color(0xffc33333),
      surface: Color(0xff434343),
    ),
    // drawerTheme: const DrawerThemeData(backgroundColor:  Color(0XFF0B4358)),
    textTheme:  TextTheme(
      headline1: GoogleFonts.montserrat(
        fontSize: 36,
        color:  const Color(0xff434343),
        fontWeight: FontWeight.bold,
      ),
       headline2: GoogleFonts.montserrat(
        fontSize: 24,
        color:  const Color(0xff434343),
        fontWeight: FontWeight.bold,
      ),
       headline3: GoogleFonts.montserrat(
        fontSize: 18,
        color:  const Color(0xff434343),
        fontWeight: FontWeight.bold,
      ),
       headline4: GoogleFonts.montserrat(
        fontSize: 16,
        color:  const Color(0xff434343),
        fontWeight: FontWeight.bold,
      ),
       headline5: GoogleFonts.montserrat(
        fontSize: 14,
        color:  const Color(0xff434343),
        fontWeight: FontWeight.bold,
      ),
       headline6: GoogleFonts.montserrat(
        fontSize: 14,
        color:  const Color(0xff434343),
        fontWeight: FontWeight.normal,
      ),
      bodyText1:   GoogleFonts.montserrat(
        fontSize: 12,
        color:  const Color(0xff434343),
        fontWeight: FontWeight.normal,
      ),
      bodyText2:   GoogleFonts.montserrat(
        fontSize: 10 ,
        color:  const Color(0xff434343),
        fontWeight: FontWeight.normal,
      ),
      caption: GoogleFonts.montserrat(
        fontSize: 12,
        color: const Color.fromARGB(255, 144, 144, 144),
        fontWeight: FontWeight.normal,
      ),
    )
  );
}
