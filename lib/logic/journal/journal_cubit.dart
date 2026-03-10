import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/journal_repository.dart';
import 'journal_state.dart';

class JournalCubit extends Cubit<JournalState> {
  final JournalRepository _repository;

  JournalCubit(this._repository) : super(JournalInitial());

  void loadJournals() {
    try {
      emit(JournalLoading());
      final journals = _repository.getJournals();
      emit(JournalLoaded(journals));
    } catch (e) {
      emit(const JournalError("Failed to load your journey history"));
    }
  }

  // ميزة إضافية: تحديث القائمة بعد إضافة سجل جديد
  void addJournalEntry() {
    loadJournals();
  }
}
