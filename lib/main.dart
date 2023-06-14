
import 'package:cs_task1/ui/screens/home/home.dart';
import 'package:cs_task1/ui/screens/login_screen.dart';
import 'package:cs_task1/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
       MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'task1',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        // home: const SplashScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      
    );
  }
}
