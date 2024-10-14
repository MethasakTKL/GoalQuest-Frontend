import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';

class RewardRepoFromDb extends RewardRepository {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late List<RewardModel> rewards;
  late RewardModelList rewardModelList;

  final String baseUrl;

  // กำหนดค่า baseUrl
  // RewardRepoFromDb({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  RewardRepoFromDb({this.baseUrl = '10.0.2.2'}); // Android Simulator
  // RewardRepoFromDb({this.baseUrl = 'https://goalquest-backend.onrender.com'});

  @override
  Future<List<RewardModel>> getAllRewards() async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }
    final url = Uri.parse('http://$baseUrl:8000/rewards/allreward');
    // final url = Uri.parse('$baseUrl/rewards/allreward');

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
        debugPrint('Response reward body: ${response.body}');

        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          final rewardModelList =
              jsonData.map((reward) => RewardModel.fromJson(reward)).toList();
          return rewardModelList;
        } else {
          throw Exception(
              'Unexpected JSON format: Expected a List but got ${jsonData.runtimeType}');
        }
      } else {
        throw Exception(
            'Failed to load rewards. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while fetching users: $e');
      throw Exception('Failed to load users. Error: $e');
    }
  }

  @override
  Future<RewardModel> redeemReward({required int rewardId}) async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }
    final url = Uri.parse('http://$baseUrl:8000/redeems/');
    // final url = Uri.parse('$baseUrl/redeems/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'reward_id': rewardId, // ส่ง reward_id ผ่าน body
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        debugPrint('Response from backend: $responseBody');
        final rewardModel = RewardModel.fromJson(responseBody);
        return rewardModel;
      } else {
        debugPrint('Failed to redeem reward: ${response.body}');
        throw Exception(
            'Failed to redeem reward. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to redeem reward. Error: $e');
    }
  }
}
