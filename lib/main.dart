import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/home.dart';
import 'package:firebasenew/login.dart';
import 'package:firebasenew/profile/profilescreen.dart';
import 'package:firebasenew/screens/dashboard.dart';
import 'package:firebasenew/signup/signupscreen.dart';
import 'package:firebasenew/widgets/custombottomnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login/loginew.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(  options: DefaultFirebaseOptions.currentPlatform);
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDm_FyDoS8ze9ifLEtype5TaSrHp0N0YZA",
        appId: "appId",
        messagingSenderId: "messagingSenderId",
        projectId: "fir-new-8e275",
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      ScreenUtilInit(
        designSize: const Size(390, 844),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CustomBottomNavigation()
    );
  });
  }
}

