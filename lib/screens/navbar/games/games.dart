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
      height: 90,
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B3534), // Dark green background
        currentIndex: _currentIndex,
        onTap: (int index) {
          // Navigate to different screens based on index
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/chatbot');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/music');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 3:
              break; // Stay on Games
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
          // Update the current index
          setState(() {
            _currentIndex = index;
          });
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
        title: const Text('Games'),
        backgroundColor: const Color(0xFF0B3534), // Dark green AppBar
      ),
      backgroundColor: const Color(0xFFF3FFFF), // Light background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // Center the column
          child: SingleChildScrollView( // Enable scrolling
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                _buildGameCard('Dino Run', 'assets/games/dino_run_logo.png', '/dino_run'),
                const SizedBox(height: 32), // Double the space between cards
                _buildGameCard('2048 Game', 'assets/games/2048.png', '/game_2048'),
                const SizedBox(height: 32), // Double the space between cards
                _buildGameCard('Snake Game', 'assets/games/snake_game.png', '/snake_game'),
                const SizedBox(height: 32), // Double the space between cards
                _buildGameCard('Tetris', 'assets/games/tetris_logo.png', '/tetris_game'),
                // Add more games here if needed
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildGameCard(String title, String imagePath, String route) {
    return SizedBox(
      width: 280, // Increased width for the game cards
      child: Card(
        color: Color(0xFF0B3534), // Semi-transparent dark card background
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                Image.asset(imagePath, width: 150, height: 150), // Image centered
                const SizedBox(height: 8), // Space between image and text
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28, // Font size for the title
                    fontWeight: FontWeight.bold,
                  ), // Dark text
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
