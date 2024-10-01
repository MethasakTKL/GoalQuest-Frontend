import 'package:flutter/widgets.dart';
import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepoFromDb extends UserRepository {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late List<UserModel> users;
  late UserModelList userModelList;
  @override
  Future<String> createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/users/');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      return 'User created successfully';
    } else {
      throw Exception('Failed to create user');
    }
  }

  @override
  Future<void> loginUser({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/token');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: ({
          'username': username,
          'password': password,
        }));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final accessToken = responseBody['access_token'];
      await storage.write(key: 'access_token', value: accessToken);
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  @override
  Future<void> logoutUser() async {
    await storage.delete(key: 'access_token');
  }

  @override
  Future<UserModel> getMeUser() async {
    final url = Uri.parse('http://10.0.2.2:8000/users/me/');
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    if (response.statusCode == 200) {
      debugPrint("response.body: ${response.body}");
      final responseBody = json.decode(response.body);
      debugPrint("response: $responseBody");
      final user = UserModel.fromJson(responseBody);
      debugPrint("user: $user");
      return user;
    } else {
      throw Exception('Failed to get user');
    }
  }

  @override
  Future<String> updateUser({
    required String email,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/users/edit-profile/');
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      debugPrint("response: $responseBody");
      final user = UserModel.fromJson(responseBody);
      debugPrint("userUpdated: $user");
      return 'User updated successfully';
    } else {
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<String> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/users/change-password/');
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      debugPrint("Response: $responseBody");
      return responseBody['message'];
    } else if (response.statusCode == 400) {
      final responseBody = json.decode(response.body);

      // เช็คว่าข้อความ error คืออะไร
      final errorMessage = responseBody['detail'] ?? 'Bad Request';

      // เช็คตามข้อความ error ที่ส่งกลับมา
      if (errorMessage == "Current password is incorrect") {
        throw Exception("Current password is incorrect. Please try again.");
      } else if (errorMessage ==
          "New password must be different from the current password") {
        throw Exception(
            "New password must be different from the current password.");
      } else {
        throw Exception(errorMessage); // สำหรับ error อื่นๆ
      }
    } else if (response.statusCode == 404) {
      throw Exception('User not found. Please check your login credentials.');
    } else {
      final responseBody = json.decode(response.body);
      final errorMessage =
          responseBody['detail'] ?? 'Failed to update password';
      throw Exception(errorMessage);
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final url = Uri.parse('http://10.0.2.2:8000/users/get-allUsers/');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // พิมพ์ response.body เพื่อดูข้อมูล JSON ที่ได้รับจาก backend
        debugPrint('Response body: ${response.body}');

        // ตรวจสอบว่า JSON ที่ได้รับเป็น List หรือไม่
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          // แปลง JSON เป็น UserModelList
          final userModelList = UserModelList.fromJson(jsonData);
          return userModelList.users;
        } else {
          throw Exception(
              'Unexpected JSON format: Expected a List but got ${jsonData.runtimeType}');
        }
      } else {
        throw Exception(
            'Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while fetching users: $e');
      throw Exception('Failed to load users. Error: $e');
    }
  }
}
