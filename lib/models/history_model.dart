import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable {
  final int historyId;
  final int historyPoint;
  final String historyTitle;
  final DateTime historyDate;

  const HistoryModel({
    required this.historyId,
    required this.historyPoint,
    required this.historyTitle, 
    required this.historyDate,
  });

  @override List<Object?> get props => [
    historyId,
    historyPoint,
    historyTitle,
    historyDate,
  ];
}