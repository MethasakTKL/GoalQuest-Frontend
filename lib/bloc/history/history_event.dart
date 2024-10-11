import 'package:goal_quest/models/history_model.dart';

sealed class HistoryEvent {}

class LoadHistoryEvent extends HistoryEvent {}

class AddHistoryEvent extends HistoryEvent{
  final HistoryModel history;
  AddHistoryEvent({required this.history});
}