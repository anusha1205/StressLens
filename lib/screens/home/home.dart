import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2; // Default to home being selected
  Timer? _timer;
  int _start = 600; // 10 minutes in seconds

  // Start meditation timer logic
  void _startMeditationTimer() {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel(); // Cancel any previous timer
    setState(() {
      _start = 600; // Reset timer to 10 minutes (600 seconds)
    });
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        timer.cancel();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Meditation Complete!'),
            content: const Text('Your 10-minute session has ended.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  // Timer display widget
  Widget _buildCountdownTimer() {
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return Text(
      'Time Left: $minutes:$seconds',
      style: const TextStyle(fontSize: 18,
          fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // Build Meditation Timer Section
  Widget _buildMeditationTimerSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0A3737), // Light blue background
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reminder: 10-minute session for today\'s mood',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Use 'color' instead of 'foreground'
            ),
          ),

          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _startMeditationTimer,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start meditation'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Timer button color
              foregroundColor: Colors.white, // Text and icon color
            ),
          ),
          const SizedBox(height: 10),
          _buildCountdownTimer(), // Countdown Timer widget
        ],
      ),
    );
  }




// Stress level graph placeholder (image from assets)
  Widget _buildStressLevelSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFDAFBFF), // Light background color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stress Level Graph',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: Container(
              height: 213, // Height for the graph
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/stress_graph/stress_graph_image.png', // Replace with the actual image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add analyze logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // Dark color
              foregroundColor: Colors.white, // White text
            ),
            child: const Text('Analyze'),
          ),
        ],
      ),
    );
  }

// Music recommendation section
  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommended for you',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildRecommendationCard(
          'Meditation',
          'Deep Sleep',
          'Sooth your mind and body, drift into dreamland',
          Color(0xDAA1FBFF),
        ),
        _buildRecommendationCard(
          'Calm',
          'Peaceful Music',
          'Relax with soothing sounds',
          Color(0xBEA1FFB7),
        ),
      ],
    );
  }
  Widget _buildRecommendationCard(String category, String title, String description, Color bgColor) {
    return Container(
      height: 110, // Set your desired height here
      child: Card(
        color: bgColor, // Light background color
        elevation: 4,
        child: ListTile(
          leading: const Icon(Icons.play_circle_fill, size: 60),
          title: Text(title, style: const TextStyle(fontSize: 18)),
          subtitle: Text(description, style: const TextStyle(fontSize: 14)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onTap: () {
            // Add play music logic here
          },
        ),
      ),
    );
  }






// How are you feeling section
  Widget _buildFeelingSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How are you feeling today?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/qna'); // This should match '/qna'
                    // Navigate to Q&A page
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.blueAccent, width: 2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.question_answer, size: 50, color: Colors.blue),
                        SizedBox(height: 10),
                        Text(
                          'Let\'s Do a Q&A',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/journal'); // Navigate to Journal page
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.greenAccent, width: 2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.edit_note, size: 50, color: Colors.green),
                        SizedBox(height: 10),
                        Text(
                          'Journal Section',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }




  Widget _buildBottomNavigationBar() {
    return Container(
      height: 90, // Set your desired height here
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B3534),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          // Navigate to different screens based on index
          switch (_currentIndex) {
            case 0:
              Navigator.pushNamed(context, '/chatbot');
              break;
            case 1:
              Navigator.pushNamed(context, '/music');
              break;
            case 2:
              break;
            case 3:
              Navigator.pushNamed(context, '/games');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'ChatBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games_outlined),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.green,
        selectedLabelStyle: TextStyle(color: Colors.green[300]),
        unselectedLabelStyle: TextStyle(color: Colors.green[300]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0B3534),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // No need to navigate, AuthWrapper will handle it
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF3FFFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildMeditationTimerSection(),
              const SizedBox(height: 20),
              _buildStressLevelSection(),
              const SizedBox(height: 20),
              _buildFeelingSection(), // Add the feeling section here
              const SizedBox(height: 20),
              _buildRecommendedSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
