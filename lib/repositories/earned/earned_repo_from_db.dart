import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';

class EarnedRepoFromDb extends EarnedRepository {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String baseUrl;

  // กำหนดค่า baseUrl
  //HistoryRepoFromDb({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  EarnedRepoFromDb({this.baseUrl = '10.0.2.2'}); // Android Simulator

  @override
  Future<List<EarnedModel>> loadEarned() async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final url = Uri.parse('http://$baseUrl:8000/earn_history/');

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

        List<EarnedModel> histories = jsonData.map((json) {
          return EarnedModel.fromJson(json);
        }).toList();

        return histories;
      } else {
        debugPrint(
            'Failed to load earned. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to load earned. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
      throw Exception('Failed to load earned: $e');
    }
  }
}
