import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalRepository goalRepository;

  GoalBloc(this.goalRepository) : super(LodingGoalState()) {
    on<LoadGoalEvent>(_onLoadGoalEvent);
    on<AddGoalEvent>(_onAddGoalEvent);
  }
  _onLoadGoalEvent(LoadGoalEvent event, Emitter<GoalState> emit) async {
    emit(LodingGoalState());
    try {
      final goals = await goalRepository.loadGoal();
      emit(ReadyGoalState(goals: goals));
    } catch (e) {
      emit(ErrorGoalState(error: e.toString()));
    }
  }

  _onAddGoalEvent(AddGoalEvent event, Emitter<GoalState> emit) async {
    try {
      await goalRepository.addGoal(
        goalTitle: event.goalTitle,
        goalDescription: event.goalDescription,
      );
      add(LoadGoalEvent());
    } catch (e) {
      emit(ErrorGoalState(error: e.toString()));
    }
  }
}
