import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(LodingTaskState()) {
    on<LoadTaskEvent>(_onLoadTaskEvent);
    on<AddTaskEvent>(_onAddTaskEvent);
  }

  _onLoadTaskEvent(LoadTaskEvent event, Emitter<TaskState> emit) async {
    if (state is LodingTaskState) {
      final tasks = await taskRepository.loadTask();
      emit(ReadyTaskState(tasks: tasks));
    }
  }

  _onAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) async {
    await taskRepository.addTask(
      title: event.title,
      taskType: event.taskType,
      repeatDays: event.repeatDays ?? 0,
      duration: event.duration ?? 0,
      startDate: event.startDate,
      endDate: event.endDate,
    );
    emit(LodingTaskState());
    add(LoadTaskEvent());
  }

}
