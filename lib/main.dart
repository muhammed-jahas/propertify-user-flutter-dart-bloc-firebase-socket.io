import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/payment_bloc/payment_bloc.dart';
import 'package:propertify/blocs/search_bloc/search_bloc.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/data/shared_preferences/shared_preferences.dart';
import 'package:propertify/views/presentation/splash_screen/splash_screen.dart';
import 'package:propertify/blocs/home_bloc/home_bloc.dart';
import 'package:propertify/blocs/login_bloc/login_bloc.dart';
import 'package:propertify/blocs/property_bloc/property_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAHRSPTqixGbXaTQhV1Nqc3kRQmWRLN9N8",
          appId: "1:799901425003:android:39369c35e6f89bb478402e",
          messagingSenderId: "799901425003",
          projectId: "propertify-user"));
  //         await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.playIntegrity,
  //     appleProvider: AppleProvider.debug
  // );
  await SharedPref.instance.initStorage();
  runApp(Propertify());
}

class Propertify extends StatelessWidget {
  const Propertify({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // Detect the current brightness mode
    Brightness systemBrightness = MediaQuery.of(context).platformBrightness;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: systemBrightness == Brightness.light
            ? Colors.transparent
            : Colors.transparent,
        statusBarIconBrightness: systemBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.dark,
        statusBarBrightness: systemBrightness,
        systemNavigationBarColor:
            systemBrightness == Brightness.light ? Colors.white : Colors.black,
        systemNavigationBarIconBrightness: systemBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => PropertyBloc()),
        BlocProvider(create: (_) => SearchBloc()),
        BlocProvider(create: (_) => PaymentRequestsBloc()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        theme: ThemeData(
          useMaterial3: false,
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: AppColors.primaryColor.shade100,
            circularTrackColor: AppColors.primaryColor,
          ),
          brightness: Brightness.light, // Use the dark theme
          fontFamily: 'gilroy', // Set your custom font here
          primaryColor: AppColors.primaryColor,
          primaryColorDark: AppColors.primaryColor,
          primaryColorLight: AppColors.primaryColor,
          hintColor: AppColors.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
