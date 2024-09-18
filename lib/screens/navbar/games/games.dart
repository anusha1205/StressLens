import 'package:flutter/material.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  int _currentIndex = 3; // Default to games being selected

  // Reuse the BottomNavigationBar
  Widget _buildBottomNavigationBar() {
    return Container(
      height: 90, // Set your desired height here
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B3534), // Dark green background
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
              Navigator.pushNamed(context, '/home');
              break;
            case 3:
              break; // Stay on Games
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
        unselectedItemColor: Colors.green[300],
        selectedLabelStyle: TextStyle(color: Colors.green[300]),
        unselectedLabelStyle: TextStyle(color: Colors.green[300]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
        backgroundColor: const Color(0xFF0B3534), // Dark green AppBar
      ),
      backgroundColor: const Color(0xFFF3FFFF), // Light background color
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildGameTile('Puzzle', Icons.extension),
          _buildGameTile('Memory', Icons.memory),
          _buildGameTile('Quiz', Icons.quiz),
          _buildGameTile('Sudoku', Icons.grid_on),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(), // Add BottomNavigationBar here
    );
  }

  Widget _buildGameTile(String title, IconData icon) {
    return Card(
      color: Colors.black.withOpacity(0.1), // Semi-transparent dark card background
      child: InkWell(
        onTap: () {
          // Implement game launch logic here
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.lightGreenAccent), // Light green icons
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold), // Dark text
            ),
          ],
        ),
      ),
    );
  }
}
