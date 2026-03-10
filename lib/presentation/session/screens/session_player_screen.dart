import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/player_bloc/player_bloc.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import '../widgets/BreathingCircle.dart'; // مكتبة الـ Seek bar

class SessionPlayerScreen extends StatelessWidget {
  const SessionPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PlayerBloc, PlayerState>(
        listener: (context, state) {
          if (state.status == PlayerStatus.completed) {
            // سنوجه المستخدم لشاشة الـ Journaling هنا لاحقاً
            print("Session Completed!");
          }
        },
        builder: (context, state) {
          if (state.currentAmbience == null) return const SizedBox();

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueGrey[900]!, Colors.black],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // زرار الإغلاق (Exit)
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),

                  // الـ Breathing Animation (الدائرة النابضة)
                  BreathingCircle(
                    isPlaying: state.status == PlayerStatus.playing,
                  ),

                  const Spacer(),

                  // معلومات الجلسة
                  Text(
                    state.currentAmbience!.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.currentAmbience!.tag,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // الـ Progress Bar (الـ Seek bar)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ProgressBar(
                      progress: state.position,
                      total: state.totalDuration,
                      progressBarColor: Colors.white,
                      baseBarColor: Colors.white.withOpacity(0.2),
                      thumbColor: Colors.white,
                      onSeek: (duration) {
                        // سنضيف الـ seek لاحقاً في الـ Bloc
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // أزرار التحكم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 64,
                        icon: Icon(
                          state.status == PlayerStatus.playing
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            context.read<PlayerBloc>().add(TogglePlayPause()),
                      ),
                    ],
                  ),

                  // زرار إنهاء الجلسة
                  TextButton(
                    onPressed: () => _showEndDialog(context),
                    child: const Text(
                      "End Session",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEndDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("End Session?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // إغلاق الديالوج
              context.read<PlayerBloc>().add(EndSession());
              Navigator.pop(context); // العودة للشاشة السابقة
            },
            child: const Text("End"),
          ),
        ],
      ),
    );
  }
}
