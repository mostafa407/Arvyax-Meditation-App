part of 'player_bloc.dart';

abstract class PlayerEvent {}

class StartSession extends PlayerEvent {
  final AmbienceModel ambience;
  StartSession(this.ambience);
}

class TogglePlayPause extends PlayerEvent {}

class UpdatePosition extends PlayerEvent {
  final Duration position;
  UpdatePosition(this.position);
}

class EndSession extends PlayerEvent {}
