import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(LodingTaskState()) {
    on<LoadTaskEvent>(_onLoadTaskEvent);
    on<AddTaskEvent>(_onAddTaskEvent);
    on<ActionTaskEvent>(_onActionTaskEvent);
    on<SearchTaskEvent>(_onSearchTaskEvent);
  }

  _onLoadTaskEvent(LoadTaskEvent event, Emitter<TaskState> emit) async {
    emit(LodingTaskState());
    try {
    final tasks = await taskRepository.loadTask();

    // จัดการกับ nextAction ที่อาจเป็น null
    tasks.sort((a, b) {
      if (a.nextAction == null && b.nextAction == null) {
        return 0;
      } else if (a.nextAction == null) {
        return 1; 
      } else if (b.nextAction == null) {
        return -1; 
      } else {
        return a.nextAction!.compareTo(b.nextAction!); // เปรียบเทียบเมื่อไม่เป็น null
      }
    });
    emit(ReadyTaskState(tasks: tasks));
  } catch (e) {
    emit(ErrorTaskState(error: e.toString()));
  }
  }

  _onAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.addTask(
        title: event.title,
        taskType: event.taskType,
        repeatDays: event.repeatDays ?? 0,
        duration: event.duration ?? 0,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      add(LoadTaskEvent());
    } catch (e) {
      emit(ErrorTaskState(error: e.toString()));
    }
  }

  _onSearchTaskEvent(SearchTaskEvent event, Emitter<TaskState> emit) async {
    emit(LodingTaskState());
    try {
      final tasks = await taskRepository.searchTask(event.key);
      emit(ReadyTaskState(tasks: tasks));
    } catch (e) {
      emit(ErrorTaskState(error: e.toString()));
    }
  }

  _onActionTaskEvent(ActionTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.actionTask(
          id: event.id,
          lastAction: event.lastAction,
          taskCount: event.taskCount);
      emit(LodingTaskState());
      add(LoadTaskEvent());
    } catch (e) {
      emit(ErrorTaskState(error: e.toString()));
    }
  }
}
