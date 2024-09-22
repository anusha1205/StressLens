import 'package:StressLens/screens/navbar/chatbot/chatbot.dart';
import 'package:StressLens/screens/navbar/games/games.dart';
import 'package:StressLens/screens/navbar/music/music.dart';
import 'package:StressLens/screens/navbar/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:your_app/screens/signup/signup.dart';
import 'dart:async';
import 'screens/login/login.dart'; // Import the login screen
import 'screens/signup/signup.dart'; // Import the signup screen
import 'screens/home/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StressLens',
      theme: ThemeData(
        primaryColor: const Color(0xFFBFFFFE),
        scaffoldBackgroundColor: const Color(0xFFF3FFFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B3534),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/home': (context) => const HomeScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/music': (context) => const MusicScreen(),
        '/games': (context) => const GamesScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      // home: const AuthWrapper(),
    );
  }
}


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const LoginScreen();
          } else {
            return const HomeScreen();
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'StressLens')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png', // Replace with your app logo
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 70),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removed AppBar as instructed
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // App Logo
            Image.asset(
              'assets/logo.png', // Replace with your app logo
              width: 220,
              height: 220,
            ),
            const SizedBox(height: 20),

            // App Name (StressLens)
            const Text(
              'StressLens',
              style: TextStyle(
                fontSize: 32, // Adjust font size as necessary
                fontWeight: FontWeight.bold,
                color: Colors.black, // Adjust text color as necessary
              ),
            ),
            const SizedBox(height: 10),

            // Tagline
            const Text(
              'See Stress clearly, Live more calmly',
              style: TextStyle(
                fontSize: 16, // Adjust font size as necessary
                fontStyle: FontStyle.italic,
                color: Colors.grey, // Adjust text color as necessary
              ),
            ),
            const SizedBox(height: 40), // Adjust spacing as necessary

            // Login and Sign Up Buttons (Side by Side)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Login Screen
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  child: const Text('Log In'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: const Color(0xFF0E8388), // Button color
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Sign Up Screen
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
                  },
                  child: const Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: const Color(0xFF0E8388), // Button color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

