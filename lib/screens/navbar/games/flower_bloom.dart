import 'package:flutter/material.dart';

void main() {
  runApp(FlowerBloomApp());
}

class FlowerBloomApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowerBloomScreen(),
    );
  }
}

class FlowerBloomScreen extends StatefulWidget {
  @override
  _FlowerBloomScreenState createState() => _FlowerBloomScreenState();
}

class _FlowerBloomScreenState extends State<FlowerBloomScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bloomAnimation;
  bool isInhale = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4), // 4 seconds per breath (2 inhale + 2 exhale)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isInhale = !isInhale;
        });
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isInhale = !isInhale;
        });
        _controller.forward();
      }
    });

    _bloomAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        backgroundColor: Color(0xFF0B3534),
        title: Text('Flower Bloom', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isInhale ? 'Inhale...' : 'Exhale...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
            SizedBox(height: 20),
            ScaleTransition(
              scale: _bloomAnimation,
              child: Image.asset(
                'assets/games/flower_bloom.png', // Add a flower image in assets folder
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
