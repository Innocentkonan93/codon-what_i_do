import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zoknot/providers/custom_bloc_provider.dart';
import 'package:zoknot/screens/screens.dart';

import 'bloc/theme/change_theme_bloc.dart';
import 'services/NotificationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  NotificationApi.init(initSchedule: true);
  runApp(const CustomBlocProvider());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
      builder: (context, state) {
        if (state is LoadTheme) {
          return MaterialApp(
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('fr', 'FR'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Zoknot',
            theme: state.themeData,
            home: const HomeScreen(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
