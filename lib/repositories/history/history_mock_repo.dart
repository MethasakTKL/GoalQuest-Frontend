import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class HistoryMockRepository extends HistoryRepository{
  List<HistoryModel> histories = [
     HistoryModel(
      historyId: 1,
      historyPoint: 100,
      historyTitle: 'Test1',
      redeemDate: DateTime(2023,10,8)
    ),
   HistoryModel(
      historyId: 2,
      historyPoint: 200,
      historyTitle: 'Test2',
      redeemDate: DateTime(2023,10,9),
    ),
  ];
  @override
  Future<List<HistoryModel>> loadHistory() async{
    await Future.delayed(const Duration(seconds: 0));
    return histories;
  }
}