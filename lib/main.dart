import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:temple_app/firebase_options.dart';
import 'package:temple_app/model/light_mode.dart';
import 'package:temple_app/screen/payment_page.dart';
import 'package:temple_app/screen/receipt_page.dart';
import 'package:temple_app/screen/splash_page.dart';
import 'package:temple_app/screen/temple_home_page.dart';
import 'package:temple_app/screen/volunteer_page.dart';

//Main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      //ThemeData(
      //  primarySwatch: Colors.blue,
      //  appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      //),
      //home: TempleEventsPage(),
      // Define your routes
      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => VolunteerRegistrationPage(),
        //TempleHomePage(),
        '/payment': (context) => PaymentPage(),
        '/receipt': (context) => ReceiptPage(),
      },
    );
  }
}
