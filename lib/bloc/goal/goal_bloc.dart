import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalRepository goalRepository;

  GoalBloc(this.goalRepository) : super(LodingGoalState()) {
    on<LoadGoalEvent>(_onLoadGoalEvent);
    on<AddGoalEvent>(_onAddGoalEvent);
    on<DeleteGoalEvent>(_onDeleteGoalEvent);
    on<EditGoalEvent>(_onEditGoalEvent); // สำหรับแก้ไข
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

  _onDeleteGoalEvent(DeleteGoalEvent event, Emitter<GoalState> emit) async {
    emit(LodingGoalState());

    try {
      // ส่ง request ไปที่ goalRepository เพื่อลบ goal
      await goalRepository.deleteGoal(goalId: event.goalId);

      // โหลดข้อมูล goal ใหม่หลังจากลบสำเร็จ
      final goals = await goalRepository.loadGoal();

      // ส่งสถานะ Ready พร้อมกับข้อมูล goal ที่อัปเดตกลับไปที่ UI
      emit(ReadyGoalState(goals: goals));
    } catch (e) {
      // จับข้อผิดพลาดและส่ง error state กลับไปที่ UI
      emit(ErrorGoalState(error: e.toString()));
    }
  }

  _onEditGoalEvent(EditGoalEvent event, Emitter<GoalState> emit) async {
    emit(LodingGoalState());
    try {
      await goalRepository.updateGoal(
        goalId: event.goalId,
        newTitle: event.updatedTitle,
        newDescription: event.updatedDescription,
      );

      final goals = await goalRepository.loadGoal();
      emit(ReadyGoalState(
          goals: goals)); // ส่งข้อมูล goal ที่อัปเดตแล้วกลับไปที่ UI
    } catch (e) {
      emit(ErrorGoalState(error: e.toString()));
    }
  }
}
