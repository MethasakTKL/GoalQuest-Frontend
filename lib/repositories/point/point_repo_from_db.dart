import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';

class PointRepoFromDb extends PointRepository {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late List<PointModel> points;
  late PointModelList pointModelList;

  final String baseUrl;

  // กำหนดค่า baseUrl
  // PointRepoFromDb({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  PointRepoFromDb({this.baseUrl = '10.0.2.2'}); // Android Simulator
  // PointRepoFromDb({this.baseUrl = 'https://goalquest-backend.onrender.com'});

  @override
  Future<PointModel> getCurrentUserPoint() async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }
    final url = Uri.parse('http://$baseUrl:8000/points/');
    // final url = Uri.parse('$baseUrl/points/');

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
        debugPrint('Response point body: ${response.body}');

        final responseBody = jsonDecode(response.body);
        return PointModel.fromJson(responseBody);
      } else {
        throw Exception(
            'Failed to load point. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load point: $e');
    }
  }

  @override
  Future<List<PointModel>> getAllPoints() async {
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found');
    }
    final url = Uri.parse('http://$baseUrl:8000/points/all');
    // final url = Uri.parse('$baseUrl/points/all');
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
        debugPrint('Response point body: ${response.body}');
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          final pointModelList =
              jsonData.map((point) => PointModel.fromJson(point)).toList();
          return pointModelList;
        } else {
          throw Exception('Unexpected JSON format.');
        }
      } else {
        // เพิ่มการจัดการกรณี response.statusCode ไม่ใช่ 200
        throw Exception(
            'Failed to load points. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // จับ error ทั้งหมดแล้ว throw Exception ใหม่
      throw Exception('Failed to load points: $e');
    }
  }
}
