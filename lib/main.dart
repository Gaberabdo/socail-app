import 'package:boopbook/screens/home/cubit/home_cubit.dart';
import 'package:boopbook/screens/home/cubit/home_state.dart';
import 'package:boopbook/screens/home/home_screen.dart';
import 'package:boopbook/screens/login/cubit/login_states.dart';
import 'package:boopbook/screens/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'helper/bloc_observe/observe.dart';
import 'helper/cache/cache_helper.dart';
import 'helper/component/component.dart';


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget? widget;

  uId = CacheHelper.getData(key: 'uId');
  print(uId.toString());

  var token = await FirebaseMessaging.instance.getToken();
  print("$token\n\t");

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

final darkNotifier = ValueNotifier<bool>(false);

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({super.key, required this.startWidget});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: darkNotifier,
        builder: (BuildContext context, bool isDark, Widget? child) {
          return BlocProvider(
            create: (context) => HomeCubit()
              ..getUserData()
              ..getTeamData()
              ..getPosts()
              ..getAllUserData()
              ..getStory()
              ..getHotVideoPiker(),
            child: BlocConsumer<HomeCubit, HomePageStates>(
              listener: (context, state) {
                if (state is SuccessLoginState) {
                  HomeCubit.get(context).getUserData();
                  HomeCubit.get(context).getAllUserData();
                }
              },
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: buildThemeLightData(),
                  darkTheme: buildThemeDarkData(),
                  themeMode: isDark! ? ThemeMode.dark : ThemeMode.light!,
                  home: startWidget,
                );
              },
            ),
          );
        });
  }

  ThemeData buildThemeLightData() {
    return ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        )),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                iconSize: MaterialStateProperty.all(16),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(0),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                textStyle: MaterialStateProperty.all(
                  GoogleFonts.cairo(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ))),
        brightness: Brightness.light,
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          elevation: 2,
          foregroundColor: Colors.indigo,
        ),
        appBarTheme: AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.cairo(
              fontSize: 20,
              color: HexColor('000'),
            ),
            iconTheme: IconThemeData(
              color: HexColor('000'),
            )),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 20,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.black,
          enableFeedback: false,
        ));
  }

  ThemeData buildThemeDarkData() {
    return ThemeData(
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      )),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey.shade800,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              iconSize: MaterialStateProperty.all(16),
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
              elevation: MaterialStateProperty.all(0),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(
                GoogleFonts.cairo(
                  fontSize: 16,
                  color: Colors.white60,
                ),
              ))),
      brightness: Brightness.dark,
      backgroundColor: Colors.black12,
      primarySwatch: Colors.red,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: HexColor('a9a9a9'),
        elevation: 2,
        foregroundColor: Colors.black,
      ),
      appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.cairo(
            fontSize: 20,
            color: HexColor('a9a9a9'),
          ),
          color: Colors.black12,
          iconTheme: IconThemeData(
            color: HexColor('a9a9a9'),
          )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.black12,
        selectedItemColor: HexColor('f5f5f5'),
        enableFeedback: false,
      ),
    );
  }
}
