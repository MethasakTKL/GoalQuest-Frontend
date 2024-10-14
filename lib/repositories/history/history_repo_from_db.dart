import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryRepoFromDb extends HistoryRepository {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String baseUrl;

  // กำหนดค่า baseUrl
  // HistoryRepoFromDb({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  // HistoryRepoFromDb({this.baseUrl = '10.0.2.2'}); // Android Simulator
  HistoryRepoFromDb({this.baseUrl = 'https://goalquest-backend.onrender.com'});
  @override
  Future<List<HistoryModel>> loadHistory() async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final url = Uri.parse('$baseUrl/redeems/history');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<HistoryModel> histories = jsonData.map((json) {
          return HistoryModel.fromJson(json);
        }).toList();
        return histories;
      } else {
        throw Exception(
            'Failed to load history. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load history: $e');
    }
  }
}
