import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:palestine_archive/features/auth/providers/user_provider.dart';

import 'package:palestine_archive/screens/splashScreen.dart';
import 'package:palestine_archive/widgets/circular_loader.dart';
import 'package:palestine_archive/widgets/home.dart';
import 'package:provider/provider.dart';

import 'app_router/app_router.dart';
import 'auth/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';


void main(List<String> args)async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path:
      'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('ar'),
      child: MyApp()));

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) {
            return AppProvider();
          },
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) {
            return UserProvider();
          },
        )      ],
      child: AppInit(),
    );

  }

}

class AppInit extends StatelessWidget {
   AppInit({Key? key}) : super(key: key);

  late ThemeData light;
  late ThemeData dark;


  Color lightindigo = Colors.indigo;
  Color lightpink = Colors.pink;
  Color lightred = Colors.red;
  Color darkindigo = Colors.indigo;
  Color darkpink = Colors.pink;
  Color darkred = Colors.red;
  @override
  Widget build(BuildContext context) {



  return  Consumer<AppProvider>(builder: (context, provider, child) {
    return MaterialApp(
      navigatorKey: AppRouter.appRouter.navigatorKey,
      debugShowCheckedModeBanner: false,
        theme: provider.darkTheme
        ? dark = ThemeData(
       appBarTheme: AppBarTheme(color:Colors.black12),
    colorScheme: const ColorScheme.dark().copyWith(
    secondary: darkpink,
    brightness: Brightness.dark,
    ),

    )
        : light = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
    primarySwatch:Colors.grey,
    ).copyWith(
   secondary: Colors.white,
    brightness: Brightness.light,
    )),
      title: 'Palestine Archive',
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 600, name: MOBILE),
          const Breakpoint(start: 600, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home:

          SplachScreen()
      ,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

    );}


  );
  }
}



