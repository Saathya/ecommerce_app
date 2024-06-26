import 'package:ecommerce_app/firebaseconfig.dart';
import 'package:ecommerce_app/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: firebaseConfig["apiKey"]!,
      authDomain: firebaseConfig["authDomain"]!,
      projectId: firebaseConfig["projectId"]!,
      storageBucket: firebaseConfig["storageBucket"]!,
      messagingSenderId: firebaseConfig["messagingSenderId"]!,
      appId: firebaseConfig["appId"]!,
      measurementId: firebaseConfig["measurementId"]!,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
