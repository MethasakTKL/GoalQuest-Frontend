import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';

class TaskRepoFromDb extends TaskRepository {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late List<TaskModel> tasks;
  late TaskModelList taskModelList;

  final String baseUrl;

  // กำหนดค่า baseUrl
  //RewardRepoFromDb({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  TaskRepoFromDb({this.baseUrl = '10.0.2.2'}); // Android Simulator

  @override
  Future<List<TaskModel>> loadTask() async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }
    final url = Uri.parse('http://$baseUrl:8000/tasks/all_task');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // พิมพ์ response.body เพื่อดูข้อมูล JSON ที่ได้รับจาก backend
        debugPrint('Response tasks body: ${response.body}');

        List<dynamic> data = json.decode(response.body);
        return data.map((task) => TaskModel.fromJson(task)).toList();
      } else {
        throw Exception(
            'Failed to load tasks. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  @override
  Future<void> addTask({
    required int goalId,
    required String title,
    required String taskType,
    required int repeatDays,
    required int duration,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final url = Uri.parse('http://$baseUrl:8000/tasks/');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode({
            'goal_id': goalId,
            'title': title,
            'task_type': taskType,
            'repeat_day': repeatDays,
            'task_duration': duration,
            'start_date': startDate.toIso8601String(),
            'due_date': endDate.toIso8601String(),
            'description': 'Task description',
          }));

      if (response.statusCode == 200) {
        // สำเร็จ
        debugPrint('Task added successfully');
      } else {
        // เกิดข้อผิดพลาด
        debugPrint('Failed to add task. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  @override
  Future<void> deleteTask({required int id}) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    debugPrint('Attempting to delete task with id: $id');

    final url = Uri.parse('http://$baseUrl:8000/tasks/$id');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Task deleted successfully');
      } else {
        debugPrint(
            'Failed to delete task. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: Failed to delete task: $e');
      throw Exception('Failed to delete task: $e');
    }
  }

  @override
  Future<TaskModel> getTaskId({required int id}) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final url = Uri.parse('http://$baseUrl:8000/tasks/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return TaskModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception(
            'Unauthorized access: You do not have permission to view this task.');
      } else if (response.statusCode == 401) {
        throw Exception('Task not found: The task with ID $id does not exist.');
      } else {
        throw Exception(
            'Failed to load goal. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: Failed to load task: $e');
      throw Exception('Failed to load task: $e');
    }
  }

  @override
  Future<void> updateTask({
    required int id,
    required String newTitle,
  }) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final existingTask = await getTaskId(id: id);

    final url = Uri.parse('http://$baseUrl:8000/tasks/$id');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'goal_id': existingTask.goalId,
          'title': newTitle,
          'task_type': existingTask.taskType,
          'repeat_day': existingTask.repeatDays,
          'task_duration': existingTask.duration,
          'start_date': existingTask.startDate.toIso8601String(),
          'due_date': existingTask.endDate?.toIso8601String(),
          'description': 'Task description',
        }),
      );
      if (response.statusCode == 200) {
        debugPrint('Task updated successfully');
      } else {
        debugPrint(
            'Failed to update task. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: Failed to update task: $e');
      throw Exception('Failed to update task: $e');
    }
  }

  @override
  Future<void> completeTask({
    required int id,
  }) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final url =
        Uri.parse('http://$baseUrl:8000/action_task/complete/?task_id=$id');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        debugPrint('Task Completed');
        debugPrint('Response: ${response.body}'); // Debug print body ถ้าต้องการ
      } else {
        // แสดงข้อมูลเมื่อ status code ไม่ใช่ 200
        debugPrint(
            'Failed to complete task. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception(
            'Failed to complete task. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // จัดการข้อผิดพลาด
      debugPrint('Error: Failed to complete task: $e');
      throw Exception('Failed to complete task: $e');
    }
  }

  @override
  Future<void> clickTask({
    required int id,
    required DateTime lastAction,
  }) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final url = Uri.parse('http://$baseUrl:8000/action_task/click_task/')
        .replace(queryParameters: {
      'task_id': id.toString(),
      'last_action': lastAction.toIso8601String(),
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Task Clicked');
        final data = jsonDecode(response.body);
        debugPrint('Task clicked successfully: $data');
      } else {
        debugPrint('Failed to click task. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: Failed to click task: $e');
      throw Exception('Failed to click task: $e');
    }
  }

  @override
  Future<void> giveUpTask({required int id}) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final url =
        Uri.parse('http://$baseUrl:8000/action_task/give_up_task/?task_id=$id');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        debugPrint('Give Up Completed');
        debugPrint('Response: ${response.body}'); // Debug print body ถ้าต้องการ
      } else {
        // แสดงข้อมูลเมื่อ status code ไม่ใช่ 200
        debugPrint(
            'Failed to give up task. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception(
            'Failed to give up task. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // จัดการข้อผิดพลาด
      debugPrint('Error: Failed to give up task: $e');
      throw Exception('Failed to give up task: $e');
    }
  }

  // @override
  // Future<List<TaskModel>> searchTask(String key) async {
  //   await Future.delayed(const Duration(seconds: 0));
  //   return tasks.where((task) => task.title.contains(key)).toList();
  // }
}
