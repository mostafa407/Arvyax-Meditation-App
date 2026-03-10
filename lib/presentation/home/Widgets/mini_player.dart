import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/player_bloc/player_bloc.dart';
import '../../session/screens/session_player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        // يظهر الميني بلاير فقط إذا كان هناك جلسة نشطة (Playing أو Paused)
        if (state.currentAmbience == null ||
            state.status == PlayerStatus.initial) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SessionPlayerScreen()),
          ),
          child: Container(
            height: 70,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // الصورة المصغرة
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    state.currentAmbience!.imagePath,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // اسم الجلسة
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.currentAmbience!.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      // شريط تقدم صغير (Thin progress indicator) كما هو مطلوب
                      LinearProgressIndicator(
                        value:
                            state.position.inSeconds /
                            state.totalDuration.inSeconds,
                        backgroundColor: Colors.grey[200],
                        color: Colors.black87,
                        minHeight: 2,
                      ),
                    ],
                  ),
                ),
                // زر التشغيل/الإيقاف
                IconButton(
                  icon: Icon(
                    state.status == PlayerStatus.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () =>
                      context.read<PlayerBloc>().add(TogglePlayPause()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
