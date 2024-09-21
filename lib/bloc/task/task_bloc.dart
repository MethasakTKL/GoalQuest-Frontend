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

  _onSearchTaskEvent(SearchTaskEvent event, Emitter<TaskState> emit) async {
    final tasks = await taskRepository.searchTask(event.key);
    emit(ReadyTaskState(tasks: tasks));
  }

  _onActionTaskEvent(ActionTaskEvent event, Emitter<TaskState> emit) async {
    await taskRepository.actionTask(id: event.id, lastAction: event.lastAction);
    emit(LodingTaskState());
    add(LoadTaskEvent());
  }
}
