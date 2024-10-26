import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  int _currentIndex = 1; // Default to music being selected
  String _selectedGenre = 'All';
  String _searchQuery = ''; // Variable to hold the search query

  final List<Map<String, String>> musicList = [
    {"title": "Birdsong Bliss", "genre": "Seasonal/ASMR"},
    {"title": "Calm Waves", "genre": "Calm & Soothing"},
    {"title": "Electric Sunset", "genre": "Youth-Focused"},
    {"title": "Feel the Flow", "genre": "Youth-Focused"},
    {"title": "Fireplace Glow", "genre": "Seasonal/ASMR"},
    {"title": "Forest Dawn", "genre": "Seasonal/ASMR"},
    {"title": "Gentle Winds", "genre": "Calm & Soothing"},
    {"title": "Groove Wave", "genre": "Youth-Focused"},
    {"title": "Mountain Breeze", "genre": "Seasonal/ASMR"},
    {"title": "Ocean of Peace", "genre": "Calm & Soothing"},
    {"title": "Raindrop Rhythm", "genre": "Seasonal/ASMR"},
    {"title": "Retro Vibes", "genre": "Youth-Focused"},
    {"title": "Rhythmic Escape", "genre": "Youth-Focused"},
    {"title": "Soft Glow", "genre": "Calm & Soothing"},
    {"title": "Soulful Symphony", "genre": "Calm & Soothing"},
    {"title": "Thunderstorm Calm", "genre": "Seasonal/ASMR"},
    {"title": "Tranquil Paths", "genre": "Calm & Soothing"},
    {"title": "Urban Melody", "genre": "Youth-Focused"},
    {"title": "Waterfall Harmony", "genre": "Seasonal/ASMR"},
    {"title": "Whispers of the Forest", "genre": "Calm & Soothing"},
    {"title": "Vibrant Skies", "genre": "Youth-Focused"},
    {"title": "Raindrop Serenade", "genre": "Calm & Soothing"},
    {"title": "Sunset Chill", "genre": "Youth-Focused"},
    {"title": "Gentle Stream", "genre": "Calm & Soothing"},
    {"title": "Nature's Heartbeat", "genre": "Seasonal/ASMR"},
    {"title": "Joyful Laughter", "genre": "Youth-Focused"},
    {"title": "Calm Under the Stars", "genre": "Calm & Soothing"},
    {"title": "Winds of Change", "genre": "Youth-Focused"},
    {"title": "Evening Tranquility", "genre": "Seasonal/ASMR"},
    {"title": "Rainforest Echoes", "genre": "Seasonal/ASMR"},
    {"title": "Breezy Days", "genre": "Seasonal/ASMR"},
    {"title": "Ocean Whisper", "genre": "Calm & Soothing"},
    {"title": "Twilight Groove", "genre": "Youth-Focused"},
    {"title": "Golden Fields", "genre": "Seasonal/ASMR"},
    {"title": "Soothing Sounds", "genre": "Calm & Soothing"},
    {"title": "Endless Summer", "genre": "Youth-Focused"},
    {"title": "Rainy Day Comfort", "genre": "Calm & Soothing"},
    {"title": "Energizing Beats", "genre": "Youth-Focused"},
    {"title": "Soft Petals", "genre": "Seasonal/ASMR"},
    {"title": "Harmonious Reflections", "genre": "Calm & Soothing"},
    {"title": "Life in Color", "genre": "Youth-Focused"},
    {"title": "Winter's Whisper", "genre": "Seasonal/ASMR"},
    {"title": "Melody of the Earth", "genre": "Calm & Soothing"},
    {"title": "Festival of Lights", "genre": "Youth-Focused"},
    {"title": "Awakening Spirit", "genre": "Youth-Focused"},
    {"title": "Dewy Mornings", "genre": "Seasonal/ASMR"},
    {"title": "Ethereal Calm", "genre": "Calm & Soothing"},
    {"title": "Exciting Adventures", "genre": "Youth-Focused"},
    {"title": "Mystical Forest", "genre": "Seasonal/ASMR"},
    {"title": "Urban Dance", "genre": "Youth-Focused"},
    {"title": "Waves of Serenity", "genre": "Calm & Soothing"},
    {"title": "Sundown Bliss", "genre": "Youth-Focused"},
    {"title": "Echoing Valleys", "genre": "Seasonal/ASMR"},
    {"title": "Restful Night", "genre": "Calm & Soothing"},
    {"title": "Dance of Joy", "genre": "Youth-Focused"},
    {"title": "Nature's Embrace", "genre": "Seasonal/ASMR"},
    {"title": "Embers of Hope", "genre": "Calm & Soothing"},
    {"title": "Rhythmic Waves", "genre": "Youth-Focused"},
    {"title": "Morning Haze", "genre": "Seasonal/ASMR"},
    {"title": "Calm Reflection", "genre": "Calm & Soothing"}
];

  List<Map<String, String>> get filteredMusicList {
    return musicList.where((music) {
      final matchesGenre = _selectedGenre == 'All' || music['genre'] == _selectedGenre;
      final matchesSearch = music['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesGenre && matchesSearch;
    }).toList();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
        backgroundColor: const Color(0xFF0B3534), // Dark green AppBar
      ),
      backgroundColor: const Color(0xFFD1FFFF), // Light background color
      body: Column(
        children: [
          // Curved Search Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the search box
                borderRadius: BorderRadius.circular(30.0), // Curve the corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Search Music Here',
                        border: InputBorder.none, // Remove the default border
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value; // Update the search query
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        // The search will be automatically applied in filteredMusicList
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _showGenreSelectionDialog,
            child: const Text('Select Music Genre'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: const Color(0xFF0B3534), // White text
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMusicList.length,
              itemBuilder: (context, index) {
                return _buildMusicTile(
                  filteredMusicList[index]["title"]!,
                  filteredMusicList[index]["genre"]!,
                  '3:45', // Placeholder duration
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }


  Widget _buildMusicTile(String title, String genre, String duration) {
    return ListTile(
      leading: const Icon(Icons.music_note, color: Colors.lightGreenAccent),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        genre,
        style: TextStyle(color: Colors.black.withOpacity(0.7)),
      ),
      trailing: Text(
        duration,
        style: const TextStyle(color: Colors.black),
      ),
      onTap: () {
        // Implement music playback logic here
      },
    );
  }

  Future<void> _showGenreSelectionDialog() async {
    String? selectedGenre = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Music Genre'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Seasonal/ASMR'),
                onTap: () => Navigator.pop(context, 'Seasonal/ASMR'),
              ),
              ListTile(
                title: const Text('Calm & Soothing'),
                onTap: () => Navigator.pop(context, 'Calm & Soothing'),
              ),
              ListTile(
                title: const Text('Youth-Focused'),
                onTap: () => Navigator.pop(context, 'Youth-Focused'),
              ),
            ],
          ),
        );
      },
    );

    if (selectedGenre != null) {
      setState(() {
        _selectedGenre = selectedGenre;
      });
    }
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 90,
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B3534),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
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
}
