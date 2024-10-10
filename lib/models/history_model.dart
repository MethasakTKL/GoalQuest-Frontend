import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable {
  final int historyId;
  final int historyPoint;
  final String historyTitle;
  final DateTime redeemDate;

  const HistoryModel({
    required this.historyId,
    required this.historyPoint,
    required this.historyTitle, 
    required this.redeemDate,
  });

  @override List<Object?> get props => [
    historyId,
    historyPoint,
    historyTitle,
    redeemDate,
  ];
}