import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  int _currentIndex = 1; // Default to music being selected

  // Reuse the BottomNavigationBar from HomeScreen
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
              break; // Stay on Music
            case 2:
              Navigator.pushNamed(context, '/home');
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
        title: const Text('Music'),
        backgroundColor: Color(0xFF0B3534), // Dark green AppBar
      ),
      backgroundColor: const Color(0xFFF3FFFF), // Light background color
      body: ListView(
        children: [
          _buildMusicTile('Relaxing Melody', 'Ambient', '3:45'),
          _buildMusicTile('Ocean Waves', 'Nature Sounds', '5:20'),
          _buildMusicTile('Peaceful Piano', 'Classical', '4:10'),
          _buildMusicTile('Meditation Chimes', 'Meditation', '6:30'),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(), // Add BottomNavigationBar here
    );
  }

  Widget _buildMusicTile(String title, String artist, String duration) {
    return ListTile(
      leading: const Icon(Icons.music_note, color: Colors.lightGreenAccent), // Custom color for icon
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Black text
      ),
      subtitle: Text(
        artist,
        style: TextStyle(color: Colors.black.withOpacity(0.7)), // Slightly transparent subtitle
      ),
      trailing: Text(
        duration,
        style: const TextStyle(color: Colors.black), // Black duration text
      ),
      onTap: () {
        // Implement music playback logic here
      },
    );
  }
}
