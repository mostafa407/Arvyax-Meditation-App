import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/ambience_model.dart';
import '../../data/datasources/audio_service.dart';
part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final AudioService _audioService;
  Timer? _timer;

  PlayerBloc(this._audioService) : super(PlayerState()) {
    on<StartSession>(_onStartSession);
    on<TogglePlayPause>(_onTogglePlayPause);
    on<UpdatePosition>(_onUpdatePosition);
    on<EndSession>(_onEndSession);
  }

  Future<void> _onStartSession(
    StartSession event,
    Emitter<PlayerState> emit,
  ) async {
    emit(
      state.copyWith(
        currentAmbience: event.ambience,
        status: PlayerStatus.loading,
      ),
    );

    // تحميل الصوت
    await _audioService.load(event.ambience.audioPath);
    await _audioService.play();

    // تحويل الـ duration من JSON (02:00) لـ Duration Object
    final parts = event.ambience.duration.split(':');
    final totalDuration = Duration(
      minutes: int.parse(parts[0]),
      seconds: int.parse(parts[1]),
    );

    emit(
      state.copyWith(
        status: PlayerStatus.playing,
        totalDuration: totalDuration,
        position: Duration.zero,
      ),
    );

    // بدأ التايمر الخاص بالجلسة
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdatePosition(state.position + const Duration(seconds: 1)));
    });
  }

  void _onUpdatePosition(UpdatePosition event, Emitter<PlayerState> emit) {
    if (event.position >= state.totalDuration) {
      _timer?.cancel();
      _audioService.stop();
      emit(
        state.copyWith(
          status: PlayerStatus.completed,
          position: state.totalDuration,
        ),
      );
    } else {
      emit(state.copyWith(position: event.position));
    }
  }

  void _onTogglePlayPause(TogglePlayPause event, Emitter<PlayerState> emit) {
    if (state.status == PlayerStatus.playing) {
      _audioService.pause();
      emit(state.copyWith(status: PlayerStatus.paused));
    } else {
      _audioService.play();
      emit(state.copyWith(status: PlayerStatus.playing));
    }
  }

  void _onEndSession(EndSession event, Emitter<PlayerState> emit) {
    _timer?.cancel();
    _audioService.stop();
    emit(PlayerState()); // Reset state
  }
}
