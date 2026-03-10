import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Duration> get positionStream => _player.positionStream;

  Future<void> load(String assetPath) async {
    try {
      await _player.setAsset(assetPath);
      await _player.setLoopMode(LoopMode.one);
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> stop() => _player.stop();

  void dispose() => _player.dispose();
}
