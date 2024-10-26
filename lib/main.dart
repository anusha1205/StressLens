// Import necessary packages at the top of the file
import 'package:StressLens/screens/home/journal/journal.dart';
import 'package:StressLens/screens/home/qna_page/qna_page.dart';
import 'package:StressLens/screens/navbar/chatbot/chatbot.dart';
import 'package:StressLens/screens/navbar/games/dino_run.dart';
import 'package:StressLens/screens/navbar/games/game_2048.dart';
import 'package:StressLens/screens/navbar/games/games.dart';
import 'package:StressLens/screens/navbar/games/snake_game.dart';
import 'package:StressLens/screens/navbar/games/tetris_game.dart';
import 'package:StressLens/screens/navbar/music/music.dart';
import 'package:StressLens/screens/navbar/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFBFFFFE),
        scaffoldBackgroundColor: const Color(0xFFF3FFFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B3534),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const AuthWrapper(),
        '/home': (context) => const HomeScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/music': (context) => const MusicScreen(),
        '/games': (context) => const GamesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/qna': (context) =>  QnaPage(), // Ensure const constructors
        '/journal': (context) =>  JournalPage(), // Ensure const constructors
        '/games': (context) => const GamesScreen(),
        '/dino_run': (context) => const DinoRun(),
        '/game_2048': (context) => const Game2048(),
        '/snake_game': (context) => const SnakeGame(),
        '/tetris_game': (context) => const TetrisGame(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(  // Ensure User import is correct
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const LoginScreen(); // Add const
          } else {
            return const HomeScreen(); // Add const
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
  Future<User?> _checkAuthStatus() async {
    // Set persistence to LOCAL (this keeps the user logged in across app restarts)
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    
    // Get the current user (if any)
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      // If we have a user, verify the token to ensure it's still valid
      try {
        await user.getIdToken(true);
      } catch (e) {
        // If token refresh fails, sign out the user
        await FirebaseAuth.instance.signOut();
        user = null;
      }
    }
    
    return user;
  }
}

// Your other classes remain unchanged

