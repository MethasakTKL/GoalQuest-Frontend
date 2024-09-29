import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:goal_quest/mockup/user_models_list.dart';

class UserModel extends Equatable {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String lastLoginDate;
  final String registerDate;

  const UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.lastLoginDate = '',
    this.registerDate = '',
    this.id = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      lastLoginDate: json['last_login_date'],
      registerDate: json['register_date'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'last_login_date': lastLoginDate,
      'register_date': registerDate,
    };
  }

  factory UserModel.empty() {
    return const UserModel(
      id: 0,
      username: '',
      firstName: '',
      lastName: '',
      email: '',
      lastLoginDate: '',
      registerDate: '',
    );
  }
  @override
  List<Object?> get props => [
        id,
        username,
        firstName,
        lastName,
        email,
        lastLoginDate,
        registerDate,
      ];
}

class UserModelList extends Equatable {
  final List<UserModel> users;

  const UserModelList({
    required this.users,
  });

  factory UserModelList.fromJson(Map<String, dynamic> json) {
    final List<UserModel> users = (json['users'] as List)
        .map((userJson) => UserModel.fromJson(userJson))
        .toList();
    return UserModelList(users: users);
  }
  List<Map<String, String>> get simplifiedUsers{
    return users.map((user){
      return{
        'username': user.username,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
      };
    }).toList();
    }
    @override
    List<Object?> get props => [users];
}
