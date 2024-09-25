
import 'package:goal_quest/models/models.dart';

sealed class UserState{
  final UserModel user;
  final String responseText;
  UserState({required this.user,this.responseText = ' '});
}

class LoadingUserState extends UserState{
  LoadingUserState({super.responseText}) : super(user: UserModel.empyt());
}

class ReadyUserState extends UserState{
  ReadyUserState({required super.user});
}