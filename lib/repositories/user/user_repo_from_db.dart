import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepoFromDb extends UserRepository {
  late UserModel user;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

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
        body: json.encode({
          'username': username,
          'password': password,
        }));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final accessToken = responseBody['access_token'];
      await storage.write(key: 'access_token', value: accessToken);
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<void> logoutUser() async {
    await storage.delete(key: 'access_token');
  }

  @override
  Future<UserModel> getMeUser() async {
    final url = Uri.parse('http://10.0.2.2:8000/users/me/');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final user = UserModel.fromJson(responseBody);
      return user;
    } else {
      throw Exception('Failed to get user');
    }
  }
}
