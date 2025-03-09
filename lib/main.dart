import 'package:chat_menager/bloc/home_bloc/home_bloc.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/firebase_options.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/views/starter_page/starter_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => HomeBloc(),
        ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          navigatorKey: Navigation.navigationKey,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: black)
                .copyWith(surface: Colors.white),
          ),
          home: StarterPage(),
        );
      },
    );
  }
}
