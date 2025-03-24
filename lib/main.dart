import 'package:chat_menager/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_menager/bloc/home_bloc/home_bloc.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/bloc/settings_bloc/settings_bloc.dart';
import 'package:chat_menager/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
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
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => MessageBloc(),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
          title: 'ChatNest',
          navigatorKey: Navigation.navigationKey,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: white,
              elevation: 0,
            ),
            scaffoldBackgroundColor: white,
            useMaterial3: true,
            colorScheme:
                ColorScheme.fromSeed(seedColor: black).copyWith(surface: white),
          ),
          home: StarterPage(),
        );
      },
    );
  }
}
