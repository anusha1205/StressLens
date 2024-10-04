import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DinoRun(),
  ));
}

class DinoRun extends StatefulWidget {
  const DinoRun({Key? key}) : super(key: key);

  @override
  _DinoRunState createState() => _DinoRunState();
}

class _DinoRunState extends State<DinoRun> with TickerProviderStateMixin {
  double dinoY = 0; // Y-position of the dinosaur
  double obstacleX = 1; // X-position of the obstacle
  double velocity = 0; // Velocity for jumping
  bool isJumping = false; // Check if the dinosaur is jumping
  bool isGameOver = false; // Check if the game is over
  int score = 0; // Player's score
  late Timer timer; // Timer for game updates
  List<double> obstaclePositions = []; // List to keep track of obstacles
  Random random = Random();

  void startGame() {
    isGameOver = false;
    dinoY = 0; // Reset dinosaur position
    obstaclePositions.clear(); // Clear previous obstacles
    score = 0; // Reset score

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        // Move obstacles
        for (int i = 0; i < obstaclePositions.length; i++) {
          obstaclePositions[i] -= 0.02; // Move obstacle to the left
          if (obstaclePositions[i] < -1) {
            obstaclePositions.removeAt(i); // Remove off-screen obstacle
            score++; // Increment score
            break;
          }
        }

        // Add new obstacle
        if (random.nextBool()) {
          obstaclePositions.add(1); // Add new obstacle from the right
        }

        // Handle jumping
        if (isJumping) {
          velocity += 0.005; // Apply gravity
          dinoY -= velocity; // Update dinosaur position
        }

        // Reset dinosaur position when it falls
        if (dinoY < -0.3) {
          dinoY = -0.3; // Ground level
          isJumping = false; // Reset jumping
        }

        // Collision detection
        for (double obstacle in obstaclePositions) {
          if (obstacle < 0.1 && obstacle > -0.1 && dinoY <= -0.1) {
            isGameOver = true; // Game over
            timer.cancel(); // Stop the game
          }
        }
      });
    });
  }

  void jump() {
    if (!isJumping) {
      velocity = 0.1; // Set initial jump velocity
      isJumping = true; // Set jumping state
    }
  }

  @override
  void initState() {
    super.initState();
    startGame(); // Start the game on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dino Run'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Colors.blue[200], // Background color
            ),
            AnimatedContainer(
              alignment: Alignment(0, dinoY), // Dinosaur position
              duration: const Duration(milliseconds: 0),
              child: Image.asset(
                'assets/games/dino_run_logo.png', // Use your dinosaur image
                width: 50,
                height: 50,
              ),
            ),
            for (double obstacle in obstaclePositions) // Obstacles
              AnimatedContainer(
                alignment: Alignment(obstacle, -0.3), // Obstacle position
                duration: const Duration(milliseconds: 0),
                child: Container(
                  color: Colors.brown,
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
            if (isGameOver) // Game over screen
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Game Over',
                      style: TextStyle(fontSize: 40, color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        startGame(); // Restart the game
                      },
                      child: const Text('Restart'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isGameOver ? null : jump, // Jump action
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel timer on dispose
    super.dispose();
  }
}
