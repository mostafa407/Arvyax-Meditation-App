import 'package:flutter/material.dart';
import '../../data/models/ambience_model.dart';
import '../../logic/player_bloc/player_bloc.dart';
import '../session/screens/session_player_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final AmbienceModel ambience;

  const DetailsScreen({super.key, required this.ambience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 1. Hero Image
          Hero(
            tag: ambience.id,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ambience.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ambience.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ambience.tag,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    ambience.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sensory Recipes (The Chips)
                  const Text(
                    "Sensory Recipe",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: ambience.recipes
                        .map(
                          (recipe) => Chip(
                            label: Text(recipe),
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                        )
                        .toList(),
                  ),

                  const Spacer(),

                  // Start Session Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // 1. نبدأ الجلسة في الـ Bloc
                        context.read<PlayerBloc>().add(StartSession(ambience));

                        // 2. نفتح شاشة الـ Player
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SessionPlayerScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Start Session",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
