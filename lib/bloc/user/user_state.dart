import 'package:goal_quest/models/models.dart';

sealed class UserState{
  final UserModel user;
  final String error ;
  final String message;

  UserState({required this.user, this.error = ' ', this.message = ' '});
}

class UserInitial extends UserState {
  UserInitial() : super(user: UserModel.empty());
}

class UserLoading extends UserState {
  UserLoading() : super(user: UserModel.empty());
}

class UserCreated extends UserState {
  
  UserCreated({required super.message}) : super(user: UserModel.empty());

}

class UserLoginSuccess extends UserState {
  UserLoginSuccess() : super(user: UserModel.empty());
}



class UserFailure extends UserState {
  UserFailure({required super.error}) : super(user: UserModel.empty()); 
}

class ReadyUserState extends UserState {
  ReadyUserState({required super.user});
}