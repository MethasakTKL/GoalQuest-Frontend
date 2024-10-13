import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:flutter/widgets.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(LodingTaskState()) {
    on<LoadTaskEvent>(_onLoadTaskEvent);
    on<AddTaskEvent>(_onAddTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
    on<EditTaskEvent>(_onEditTaskEvent);
    // on<ActionTaskEvent>(_onActionTaskEvent);
    // on<SearchTaskEvent>(_onSearchTaskEvent);
  }

  _onLoadTaskEvent(LoadTaskEvent event, Emitter<TaskState> emit) async {
    emit(LodingTaskState());
    try {
      final tasks = await taskRepository.loadTask();

      // Debug: ตรวจสอบว่า Task ถูกโหลดมาหรือไม่
      debugPrint('Tasks Loaded: ${tasks.length} tasks found.');

      // จัดการกับ nextAction ที่อาจเป็น null
      tasks.sort((a, b) {
        if (a.nextAction == null && b.nextAction == null) {
          return 0;
        } else if (a.nextAction == null) {
          return 1;
        } else if (b.nextAction == null) {
          return -1;
        } else {
          return a.nextAction!
              .compareTo(b.nextAction!); // เปรียบเทียบเมื่อไม่เป็น null
        }
      });

      emit(ReadyTaskState(tasks: tasks));
    } catch (e) {
      // Debug: แสดงข้อความ error ถ้าเกิดปัญหา
      debugPrint('Error loading tasks: $e');
      emit(ErrorTaskState(error: e.toString()));
    }
  }

  _onAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.addTask(
        goalId: event.goalId,
        title: event.title,
        taskType: event.taskType,
        repeatDays: event.repeatDays ?? 0,
        duration: event.duration ?? 0,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      // หลังจากเพิ่ม Task เรียบร้อยแล้ว ให้โหลด Task ใหม่
      debugPrint('Task added successfully. Loading tasks...');
      add(LoadTaskEvent()); // เพิ่ม goalId ให้ LoadTaskEvent เพื่อโหลด task ของ goal นั้น ๆ
    } catch (e) {
      // แสดงข้อความ error ถ้าเกิดข้อผิดพลาด
      debugPrint('Error adding task: $e');
      emit(ErrorTaskState(error: e.toString()));
    }
  }

  _onDeleteTaskEvent(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(LodingTaskState());

    try {
      await taskRepository.deleteTask(id: event.id);
      final tasks = await taskRepository.loadTask();
      emit(ReadyTaskState(tasks: tasks));
    } catch (e) {
      emit(ErrorTaskState(error: e.toString()));
    }
  }

  _onEditTaskEvent(EditTaskEvent event, Emitter<TaskState> emit) async {
    emit(LodingTaskState());
    try {
      await taskRepository.updateTask(
        id: event.id,
        newTitle: event.newTitle,
      );

      final tasks = await taskRepository.loadTask();
      emit(ReadyTaskState(tasks: tasks));
    } catch (e) {
      emit(ErrorTaskState(error: e.toString()));
    }
  }

  // _onSearchTaskEvent(SearchTaskEvent event, Emitter<TaskState> emit) async {
  //   emit(LodingTaskState());
  //   try {
  //     final tasks = await taskRepository.searchTask(event.key);
  //     emit(ReadyTaskState(tasks: tasks));
  //   } catch (e) {
  //     emit(ErrorTaskState(error: e.toString()));
  //   }
  // }

  // _onActionTaskEvent(ActionTaskEvent event, Emitter<TaskState> emit) async {
  //   try {
  //     await taskRepository.actionTask(
  //         id: event.id,
  //         lastAction: event.lastAction,
  //         taskCount: event.taskCount);
  //     emit(LodingTaskState());
  //     add(LoadTaskEvent());
  //   } catch (e) {
  //     emit(ErrorTaskState(error: e.toString()));
  //   }
  // }
}
