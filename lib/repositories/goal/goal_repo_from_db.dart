import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goal_quest/models/goal_model.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';

class GoalRepoFromDb extends GoalRepository {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late List<GoalModel> goals;
  late GoalModelList goalModelList;

  final String baseUrl;

  // กำหนดค่า baseUrl
  // GoalRepoFromDb({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  GoalRepoFromDb({this.baseUrl = '10.0.2.2'}); // Android Simulator
  //GoalRepoFromDb({this.baseUrl = 'https://goalquest-backend.onrender.com'});

  @override
  Future<List<GoalModel>> loadGoal() async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }
    final url = Uri.parse('http://$baseUrl:8000/goals/all_goal');
    // final url = Uri.parse('$baseUrl/goals/all_goal');
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
        debugPrint('Response goals body: ${response.body}');

        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          final goalModelList =
              jsonData.map((goal) => GoalModel.fromJson(goal)).toList();
          return goalModelList;
        } else {
          throw Exception(
              'Unexpected JSON format: Expected a List but got ${jsonData.runtimeType}');
        }
      } else {
        throw Exception(
            'Failed to load rewards. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load rewards: $e');
    }
  }

  @override
  Future<void> addGoal({
    required String goalTitle,
    required String goalDescription,
  }) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }
    final url = Uri.parse('http://$baseUrl:8000/goals/');
    // final url = Uri.parse('$baseUrl/goals/');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'title': goalTitle,
          'description': goalDescription,
          'progress_percentage': 0.0,
          'start_date':
              DateTime.now().toIso8601String(), // วันเริ่มต้นเป็นวันที่ปัจจุบัน
          'end_date': DateTime.now()
              .add(const Duration(days: 365))
              .toIso8601String(), // บวก 1 ปี (365 วัน)
          'is_complete': false, // ค่าเริ่มต้น goal ยังไม่เสร็จ
        }));
    if (response.statusCode == 200) {
      // สำเร็จ
      debugPrint('Goal added successfully');
    } else {
      // เกิดข้อผิดพลาด
      debugPrint('Failed to add goal. Status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
    }
  }

  @override
  Future<GoalModel> getGoalId({required int goalId}) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }
    final url = Uri.parse('http://$baseUrl:8000/goals/$goalId');
    // final url = Uri.parse('$baseUrl/goals/$goalId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // แปลงข้อมูล JSON ที่ได้จาก response body ไปเป็น GoalModel
        final jsonData = jsonDecode(response.body);
        return GoalModel.fromJson(jsonData); // คืนค่า GoalModel จาก JSON
      }
      // ตรวจสอบกรณีที่สถานะไม่ใช่ 200
      else if (response.statusCode == 403) {
        throw Exception(
            'Unauthorized access: You do not have permission to view this goal.');
      } else if (response.statusCode == 404) {
        throw Exception(
            'Goal not found: The goal with ID $goalId does not exist.');
      } else {
        throw Exception(
            'Failed to load goal. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // จับข้อผิดพลาดที่อาจเกิดขึ้นและโยนข้อผิดพลาดนั้นออกไป
      throw Exception('Failed to load goal: $e');
    }
  }

  @override
  Future<void> updateGoal({
    required int goalId,
    required String newTitle,
    required String newDescription,
  }) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final existingGoal = await getGoalId(goalId: goalId);
    final url = Uri.parse('http://$baseUrl:8000/goals/$goalId');
    // final url = Uri.parse('$baseUrl/goals/$goalId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'title': newTitle,
          'description': newDescription,
          'progress_percentage': existingGoal.goalProgressPercent,
          'start_date': existingGoal.startDate.toIso8601String(),
          'end_date': existingGoal.endDate.toIso8601String(),
          'is_complete': existingGoal.isCompleted,
        }),
      );
      if (response.statusCode == 200) {
        // สำเร็จ
        debugPrint('Goal updated successfully');
      } else {
        debugPrint(
            'Failed to update goal. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to update goal: $e');
    }
  }

  @override
  Future<void> deleteGoal({required int goalId}) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    debugPrint('Attempting to delete goal with id: $goalId');
    final url = Uri.parse('http://$baseUrl:8000/goals/$goalId');
    // final url = Uri.parse('$baseUrl/goals/$goalId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Goal deleted successfully');
      } else {
        debugPrint(
            'Failed to delete goal. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to delete goal. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: Failed to delete goal: $e');
      throw Exception('Failed to delete goal: $e');
    }
  }
}
