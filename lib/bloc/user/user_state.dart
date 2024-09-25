
import 'package:goal_quest/models/models.dart';

sealed class UserState{
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserCreated extends UserState {
  final String message;

  UserCreated({required this.message});

  @override
  List<Object> get props => [message];
}

class UserLoginSuccess extends UserState {}

class UserFailure extends UserState {
  final String error;

  UserFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ReadyUserState extends UserState {
  final UserModel user;

  ReadyUserState({required this.user});

  @override
  List<Object?> get props => [user];
}