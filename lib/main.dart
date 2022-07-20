import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaltani_ms/ui_layer/auth/sign_up_page.dart';
import 'package:kaltani_ms/ui_layer/dashboard/dashboard.dart';
import 'package:kaltani_ms/utils/colors.dart';

import 'logic/local_storage.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      //Setting font does not change with system font size
      data: const MediaQueryData(
        size: Size(1000, 700),
      ),
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => const ThemeWidget()),
    );
  }
}

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({Key? key}) : super(key: key);

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        ScreenUtil.init(context);
        return widget!;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: KAColors.appMainLightColor,
          titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w700, color: KAColors.appBlackColor),
        ),
        fontFamily: "Effra",
        textTheme: getTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapShot) {
          if (snapShot.data == null) {
            return SignUpPage();
          }
          return const DashBoard();
        });
  }
}

TextTheme getTextTheme() {
  return TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 26.sp,
    ),
    headline3: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10.sp,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.sp,
    ),
    headline6: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.sp,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 7.sp,
    ),
    bodyText2: TextStyle(
      fontSize: 30.sp,
    ),
    bodyText1: TextStyle(
      fontSize: 12.sp,
    ),
    caption: TextStyle(
      fontSize: 50.sp,
    ),
    overline: TextStyle(
      fontSize: 45.sp,
    ),
    button: const TextStyle(
      fontSize: 14,
    ),
  );
}
