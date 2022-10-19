import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartsellpro/res/screens/first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(0, 210, 45, 45),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent)),
          primarySwatch: Colors.teal,
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(0, 210, 45, 45),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal)),
          primarySwatch: Colors.teal,
        ),
        home: MainHome());
  }
}
