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
    on<CompleteTaskEvent>(_onCompleteTaskEvent);
    on<ClickTaskEvent>(_onClickTaskEvent);
    on<GiveUpTaskEvent>(_onGiveUpTaskEvent);
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

  _onCompleteTaskEvent(CompleteTaskEvent event, Emitter<TaskState> emit) async {
    debugPrint("CompleteTaskEvent started with task ID: ${event.id}");

    emit(LodingTaskState());
    debugPrint("Emitted LodingTaskState");

    try {
      // เรียกใช้งาน completeTask จาก taskRepository
      await taskRepository.completeTask(id: event.id);
      debugPrint("Task ID: ${event.id} completed successfully");

      // โหลดรายการ tasks หลังจากทำ task เสร็จแล้ว
      final tasks = await taskRepository.loadTask();
      debugPrint("Loaded ${tasks.length} tasks after task completion");

      emit(ReadyTaskState(tasks: tasks));
      debugPrint("Emitted ReadyTaskState with updated task list");
    } catch (e) {
      // เมื่อเกิดข้อผิดพลาด
      debugPrint(
          "Error occurred while completing task ID: ${event.id}, Error: $e");
      emit(ErrorTaskState(error: e.toString()));
    }
  }

//   _onSearchTaskEvent(SearchTaskEvent event, Emitter<TaskState> emit) async {
//   try {
//     // กรองรายการ tasks จาก state ที่มีอยู่แล้วตาม search query
//     final filteredTasks = state.tasks.where((task) {
//       return task.title.toLowerCase().contains(event..toLowerCase());
//     }).toList();

//     // ถ้าไม่มีอะไรค้นหา (searchQuery เป็นค่าว่าง) แสดง tasks ทั้งหมด
//     final displayedTasks = event.searchQuery.isEmpty ? state.tasks : filteredTasks;

//     // ส่งผลลัพธ์ไปให้ state
//     emit(ReadyTaskState(tasks: displayedTasks));
//   } catch (e) {
//     emit(ErrorTaskState(error: e.toString()));
//   }
// }

  _onClickTaskEvent(ClickTaskEvent event, Emitter<TaskState> emit) async {
    emit(LodingTaskState());
    try {
      await taskRepository.clickTask(
        id: event.id,
        lastAction: event.lastAction,
      );
      emit(LodingTaskState());
      add(LoadTaskEvent());
    } catch (e) {
      emit(ErrorTaskState(error: e.toString()));
    }
  }

  _onGiveUpTaskEvent(GiveUpTaskEvent event, Emitter<TaskState> emit) async {
    emit(LodingTaskState());
    try {
      await taskRepository.giveUpTask(
        id: event.id,
      );
      emit(LodingTaskState());
      add(LoadTaskEvent());
    } catch (e) {
      emit(ErrorTaskState(error: e.toString()));
    }
  }
}
