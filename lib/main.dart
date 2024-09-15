import 'package:flutter/material.dart';
import 'dart:async';
import 'screens/login/login.dart'; // Import the login screen
import 'screens/signup/signup.dart'; // Import the signup screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StressLens',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFD8A25E)), // Updated theme color
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Set splash screen as the initial page
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
    Timer(const Duration(seconds: 3), () {
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
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // App Logo
            Image.asset(
              'assets/logo.png', // Replace with your app logo
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),

            // App Name and Tagline
            const Text(
              'StressLens',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'See stress clearly, live more calmly',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

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
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: const Color(0xFFD8A25E),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    // Navigate to Sign Up Screen
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
                  },
                  child: const Text('Sign Up'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    side: const BorderSide(color: Color(0xFFD8A25E)),
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
