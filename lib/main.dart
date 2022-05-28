import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zoknot/data/cubit/theme_cubit.dart';
import 'package:zoknot/screens/screens.dart';
import 'data/Services/NotificationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  NotificationApi.init(initSchedule: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zoknot',

        // themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blueGrey[900],
            elevation: 0.0,
          ),
          colorScheme: const ColorScheme(
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
          ),
        ),
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.cyan,
            elevation: 0.0,
          ),
          colorScheme: const ColorScheme(
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
          ),
        ),
        home: const HomeScreen());
  }
}
