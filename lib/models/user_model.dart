import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String lastLoginDate;
  final String registerDate; 

  const UserModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.lastLoginDate = '',
    this.registerDate = '', 
    this.id = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      lastLoginDate: json['last_login_date'],
      registerDate: json['register_date'],
      );
  }
  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'last_login_date': lastLoginDate,
      'register_date': registerDate,
    };
  }
  @override  
  List<Object?> get props => [
    id,
    username,
    firstName,
    lastName,
    email,
    password,
    lastLoginDate,
    registerDate,
  ];
}

