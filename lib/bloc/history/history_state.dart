import 'package:goal_quest/models/models.dart';

sealed class HistoryState {
  final List<HistoryModel> histories;
  final String error;
  HistoryState({required this.histories, this.error = ''});
}

const List<HistoryModel> emptyHistories = [];

class LoadingHistoryState extends HistoryState {
  LoadingHistoryState() : super(histories: emptyHistories);
}

class ReadyHistoryState extends HistoryState {
  ReadyHistoryState({required super.histories});
}

class ErrorHistoryState extends HistoryState {
  ErrorHistoryState({required super.error}) : super(histories: emptyHistories);
}
