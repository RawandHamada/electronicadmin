

import 'package:electronicadmin/reports/report_screen.dart';
import 'package:electronicadmin/hi_screen.dart';
import 'package:electronicadmin/launch_screen.dart';
import 'package:electronicadmin/main_screen.dart';
import 'package:electronicadmin/reports/month_scale_screen.dart';
import 'package:electronicadmin/preferences/app_preferences.dart';
import 'package:electronicadmin/screen_auth/create_account_screen.dart';
import 'package:electronicadmin/screen_auth/forget_password_screen.dart';
import 'package:electronicadmin/screen_auth/login_screen.dart';
import 'package:electronicadmin/reports/today_scale_screen.dart';
import 'package:electronicadmin/view_screen/view_branch_screen.dart';
import 'package:electronicadmin/view_screen/view_category_screen.dart';
import 'package:electronicadmin/view_screen/view_color_screen.dart';
import 'package:electronicadmin/view_screen/view_employee_screen.dart';
import 'package:electronicadmin/view_screen/view_scale_screen.dart';
import 'package:electronicadmin/reports/week_scale_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppPreferences().initPreferences();
  runApp( MyApp());}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
  static changeLanguage(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) state.changeLocale(newLocale);
  }
}
class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(AppPreferences().language);


  void changeLocale(Locale locale) {
    AppPreferences().setLanguage(locale.languageCode);
    setState(() {
      _locale = locale;
    });}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          //AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar')
          // Locale('en'),
        ],
        locale: _locale,
        initialRoute: '/launch_screen',
        routes:{
          '/launch_screen': (context) => LaunchScreen(),
          '/login_screen': (context) => LoginScreen(),
          '/hi_screen': (context) => HiScreen(),
          '/create_accont_screen': (context) => CreateAccountScreen(),
          '/forget_password_screen': (context) => ForgetPasswordScreen(),
          '/main_screen': (context) => MainScreen(),
          '/view_employee_screen': (context) => ViewEmployeeScreen(),
          '/view_scale_screen': (context) => ViewScaleScreen(),
          '/view_branch_screen': (context) => ViewBranchScreen(),
          '/view_color_screen': (context) => ViewColorScreen(),
          '/view_category_screen': (context) => ViewCategoryScreen(),
          '/reports_screen': (context) => ReportScreen(),
          '/today_scale_screen': (context) => ToDayScaleScreen(),
          '/month_scale_screen': (context) => MonthScaleScreen(),
          '/week_scale_screen': (context) => WeekScaleScreen(),

        }


    );
  }
}


