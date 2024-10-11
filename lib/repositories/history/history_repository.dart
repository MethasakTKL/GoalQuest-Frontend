import 'package:goal_quest/models/models.dart';

abstract class HistoryRepository {
  Future<List<HistoryModel>> loadHistory();
  Future<void> addHistory(HistoryModel history);
}