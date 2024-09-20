import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(LodingTaskState()) {
    on<LoadTaskEvent>(_onLoadTaskEvent);
  }

  _onLoadTaskEvent(LoadTaskEvent event, Emitter<TaskState> emit) async {
    if (state is LodingTaskState) {
      final tasks = await taskRepository.loadTask();
      emit(ReadyTaskState(tasks: tasks));
    }
  }
}
