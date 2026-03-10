import 'package:hive/hive.dart';
import '../models/journal_model.dart';

class JournalRepository {
  final Box<JournalModel> _box = Hive.box<JournalModel>('journals');

  List<JournalModel> getJournals() {
    return _box.values.toList().reversed.toList();
  }

  Future<void> saveJournal(JournalModel journal) async {
    await _box.add(journal);
  }
}
