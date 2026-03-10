import '../../data/models/ambience_model.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  final HomeStatus status;
  final List<AmbienceModel> allAmbiences;
  final List<AmbienceModel> filteredList;
  final String selectedTag;

  HomeState({
    this.status = HomeStatus.initial,
    this.allAmbiences = const [],
    this.filteredList = const [],
    this.selectedTag = 'All',
  });

  HomeState copyWith({
    HomeStatus? status,
    List<AmbienceModel>? allAmbiences,
    List<AmbienceModel>? filteredList,
    String? selectedTag,
  }) {
    return HomeState(
      status: status ?? this.status,
      allAmbiences: allAmbiences ?? this.allAmbiences,
      filteredList: filteredList ?? this.filteredList,
      selectedTag: selectedTag ?? this.selectedTag,
    );
  }
}
