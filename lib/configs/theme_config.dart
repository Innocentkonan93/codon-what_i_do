import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const seed = Color(0xFF00C7FC);

class ThemeConfig {
  ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1ba9c3),
    onPrimary: Color(0xFF263238),
    primaryContainer: Color(0xFFF4fdff),
    onPrimaryContainer: Color(0xFF263238),
    secondary: Color(0xFFfdbf17),
    onSecondary: Color(0xFF263238),
    secondaryContainer: Color(0xFFfdbf17),
    onSecondaryContainer: Color(0xFF263238),
    tertiary: Color(0xFFf39591),
    onTertiary: Color(0xFF263238),
    tertiaryContainer: Color(0xFFf39591),
    onTertiaryContainer: Color(0xFF263238),
    error: Color(0xFFBA1B1B),
    errorContainer: Color(0xFFFFDAD4),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410001),
    background: Color(0xFFF4fdff),
    onBackground: Color(0xFF263238),
    surface: Color(0xFFFBFCFE),
    onSurface: Color(0xFF191C1E),
    surfaceVariant: Color(0xFFDCE4E9),
    onSurfaceVariant: Color(0xFF40484C),
    outline: Color(0xFF70787D),
    onInverseSurface: Color(0xFFF0F1F3),
    inverseSurface: Color(0xFF263238),
    inversePrimary: Color(0xFF1ba9c3),
    shadow: Color(0xFF000000),
  );

  ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF1ba9c3),
    onPrimary: Color(0xFF263238),
    primaryContainer: Color(0xFFF4fdff),
    onPrimaryContainer: Color(0xFF263238),
    secondary: Color(0xFFfdbf17),
    onSecondary: Color(0xFF263238),
    secondaryContainer: Color(0xFFfdbf17),
    onSecondaryContainer: Color(0xFF263238),
    tertiary: Color(0xFFf39591),
    onTertiary: Color(0xFF263238),
    tertiaryContainer: Color(0xFFf39591),
    onTertiaryContainer: Color(0xFF263238),
    error: Color(0xFFBA1B1B),
    errorContainer: Color(0xFFFFDAD4),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410001),
    background: Color(0xFF263238),
    onBackground: Color(0xFFFFFFFF),
    surface: Color(0xFF191C1E),
    onSurface: Color(0xFFE1E2E4),
    surfaceVariant: Color(0xFF40484C),
    onSurfaceVariant: Color(0xFFC0C8CD),
    outline: Color(0xFF8A9296),
    onInverseSurface: Color(0xFF191C1E),
    inverseSurface: Color(0xFFE1E2E4),
    inversePrimary: Color(0xFF006684),
    shadow: Color(0xFF000000),
  );

  TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.signikaNegative(
      fontSize: 36,
      color: const Color(0xff434343),
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.signikaNegative(
      fontSize: 24,
      color: const Color(0xff434343),
      fontWeight: FontWeight.bold,
    ),
    headline3: GoogleFonts.signikaNegative(
      fontSize: 18,
      color: const Color(0xff434343),
      fontWeight: FontWeight.bold,
    ),
    headline4: GoogleFonts.signikaNegative(
      fontSize: 16,
      color: const Color(0xff434343),
      fontWeight: FontWeight.bold,
    ),
    headline5: GoogleFonts.manrope(
      fontSize: 14,
      color: const Color(0xff434343),
      fontWeight: FontWeight.bold,
    ),
    headline6: GoogleFonts.manrope(
      fontSize: 14,
      color: const Color(0xff434343),
      fontWeight: FontWeight.normal,
    ),
    bodyText1: GoogleFonts.signikaNegative(
      fontSize: 12,
      color: const Color(0xff434343),
      fontWeight: FontWeight.normal,
    ),
    bodyText2: GoogleFonts.manrope(
      fontSize: 10,
      color: const Color(0xff434343),
      fontWeight: FontWeight.normal,
    ),
    caption: GoogleFonts.manrope(
      fontSize: 12,
      color: const Color.fromARGB(255, 144, 144, 144),
      fontWeight: FontWeight.normal,
    ),
  );
}
