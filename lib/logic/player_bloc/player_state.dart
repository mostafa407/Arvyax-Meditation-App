part of 'player_bloc.dart';

enum PlayerStatus { initial, loading, playing, paused, completed }

class PlayerState {
  final AmbienceModel? currentAmbience;
  final PlayerStatus status;
  final Duration position;
  final Duration totalDuration;

  PlayerState({
    this.currentAmbience,
    this.status = PlayerStatus.initial,
    this.position = Duration.zero,
    this.totalDuration = Duration.zero,
  });

  PlayerState copyWith({
    AmbienceModel? currentAmbience,
    PlayerStatus? status,
    Duration? position,
    Duration? totalDuration,
  }) {
    return PlayerState(
      currentAmbience: currentAmbience ?? this.currentAmbience,
      status: status ?? this.status,
      position: position ?? this.position,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }
}
