import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whai_i_do/App/AppRoutes.dart';
import 'package:whai_i_do/data/cubit/theme_cubit.dart';
import 'package:whai_i_do/data/dataprovider/CustomBlocProvider.dart';
import 'data/Services/NotificationService.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  NotificationApi.init(initSchedule: true);
  runApp(const CustomBlocProvider());
}

class MyApp extends StatelessWidget {

  final AppRouter appRouter;

  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    bool isDark  = themeCubit.isDark;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoknot',
      // theme: ThemeData.light(),
      // theme: isDark ? ThemeData.dark() : ThemeData.light(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme:  ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[900],
          elevation: 0.0,
        ),
        accentColor:  Colors.cyan,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(
          color: Colors.cyan,
        ),
         floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.cyan,
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
          ),
          // backgroundColor: Colors.white,
        )
      ),
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.cyan,
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: Colors.white,
         iconTheme: const IconThemeData(
          color: Colors.cyan,
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.cyan,
        )
      ),
      // home: const NotePage(),
      initialRoute: '/home',
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
