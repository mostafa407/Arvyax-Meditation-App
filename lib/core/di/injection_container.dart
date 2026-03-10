import 'package:get_it/get_it.dart';
import '../../data/datasources/audio_service.dart';
import '../../data/repositories/ambience_repository.dart';
import '../../data/repositories/journal_repository.dart';
import '../../logic/home_cubit/home_cubit.dart';
import '../../logic/journal/journal_cubit.dart';
import '../../logic/player_bloc/player_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => AudioService());
  sl.registerLazySingleton(() => AmbienceRepository());
  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => PlayerBloc(sl()));
  sl.registerFactory(() => JournalCubit(sl()));
  sl.registerLazySingleton(() => JournalRepository());
}
