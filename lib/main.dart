import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mycine_app/core/config/theme/app_theme.dart';
import 'package:mycine_app/screens/Login_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'myCine',
        locale: const Locale('es'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FirebaseUILocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es'),
        ],
        
        theme: AppTheme.appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(), 
          '/home': (context) => MyHomePage(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}

