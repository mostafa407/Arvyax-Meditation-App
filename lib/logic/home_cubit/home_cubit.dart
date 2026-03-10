import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/ambience_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AmbienceRepository _repository;

  HomeCubit(this._repository) : super(HomeState());

  Future<void> loadAmbiences() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final ambiences = await _repository.getAmbiences();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          allAmbiences: ambiences,
          filteredList: ambiences,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  void filterAmbiences(String query, String tag) {
    var list = state.allAmbiences;

    if (tag != 'All') {
      list = list.where((item) => item.tag == tag).toList();
    }

    if (query.isNotEmpty) {
      list = list
          .where(
            (item) => item.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    emit(state.copyWith(filteredList: list, selectedTag: tag));
  }

  void clearFilters() {
    emit(state.copyWith(filteredList: state.allAmbiences, selectedTag: 'All'));
  }
}
