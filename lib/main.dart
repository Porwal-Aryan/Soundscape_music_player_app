import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:soundscape/choose_screen.dart';
import 'package:soundscape/forgot_password.dart';
import 'package:soundscape/login.dart';
import 'package:soundscape/final_page.dart';
import 'package:soundscape/musicplayer/playlist_screen.dart';
// import 'package:soundscape/onbording.dart';
import 'package:soundscape/opening_screen.dart';
import 'package:soundscape/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBQd2j-oHIFOtB7VzTLx8niemxIu6cMoI4',
      appId: '1:814640642403:android:1f48fabc2387a936097b56',
      messagingSenderId: '',
      projectId: 'soundscape-872bb',
      storageBucket: '',
    ),
  );

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.soundscape.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1E1E1E),
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OpeningScreen(),
        // 'onboarding': (context) => Onboarding(),
        'choose': (context) => ChooseScreen(),
        'signup': (context) => SignUpScreen(),
        'login': (context) => LoginScreen(),
        'forgotPassword': (context) => ForgotPasswordScreen(),
        'finalPage': (context) => FinalPage(),
        'PlaylistScreen': (context) => PlaylistScreen(),
      },
      // home: OpeningScreen(),
    );
  }
}
