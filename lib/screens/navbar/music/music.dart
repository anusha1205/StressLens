import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 1; // Default to music being selected
  String _selectedGenre = 'All';
  String _searchQuery = ''; // Variable to hold the search query
  @override
  void initState() {
    super.initState();
    // Additional initialization if needed
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Clean up the player when the widget is disposed
    super.dispose();
  }

  final List<Map<String, String>> musicList = [
    // Seasonal/ASMR
    {"title": "Birdsong Bliss", "genre": "Seasonal/ASMR", "image": "assets/music/birdsong.png", "url": "https://example.com/birdsong.mp3"},
    {"title": "Fireplace Glow", "genre": "Seasonal/ASMR", "image": "assets/music/fireplace_glow.png"},
    {"title": "Forest Dawn", "genre": "Seasonal/ASMR", "image": "assets/music/forest_dawn.png"},
    {"title": "Mountain Breeze", "genre": "Seasonal/ASMR", "image": "assets/music/mountain_breeze.png"},
    {"title": "Thunderstorm Calm", "genre": "Seasonal/ASMR", "image": "assets/music/thunderstorm_calm.png"},

    // Calm & Soothing
    {"title": "Calm Waves", "genre": "Calm & Soothing", "image": "assets/music/calm_waves.png"},
    {"title": "Gentle Winds", "genre": "Calm & Soothing", "image": "assets/music/gentle_winds.png"},
    {"title": "Ocean of Peace", "genre": "Calm & Soothing", "image": "assets/music/ocean_of_peace.png"},
    {"title": "Soft Glow", "genre": "Calm & Soothing", "image": "assets/music/soft_glow.png"},
    {"title": "Tranquil Paths", "genre": "Calm & Soothing", "image": "assets/music/tranquil_paths.png"},

    // Youth-Focused
    {"title": "Electric Sunset", "genre": "Youth-Focused", "image": "assets/music/electric_sunset.png"},
    {"title": "Feel the Flow", "genre": "Youth-Focused", "image": "assets/music/feel_the_flow.png"},
    {"title": "Groove Wave", "genre": "Youth-Focused", "image": "assets/music/groove_wave.png"},
    {"title": "Retro Vibes", "genre": "Youth-Focused", "image": "assets/music/retro_vibes.png"},
    {"title": "Soulful Symphony", "genre": "Youth-Focused", "image": "assets/music/soulful_symphony.png"},

  ];

  List<Map<String, String>> get filteredMusicList {
    return musicList.where((music) {
      final matchesGenre = _selectedGenre == 'All' || music['genre'] == _selectedGenre;
      final matchesSearch = music['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesGenre && matchesSearch;
    }).toList();
  }
  Future<void> _playMusic(String url) async {
    try {
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
      _audioPlayer.play();
    } catch (e) {
      print("Error playing music: $e");
    }
  }

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
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8, // Adjusts height of each card
              ),
              itemCount: filteredMusicList.length,
              itemBuilder: (context, index) {
                return _buildMusicTile(
                  filteredMusicList[index]["title"]!,
                  filteredMusicList[index]["genre"]!,
                  filteredMusicList[index]["image"]!,
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

  Widget _buildMusicTile(String title, String genre, String imagePath, String duration) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100, // Adjust height as needed
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  genre,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  duration,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
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
