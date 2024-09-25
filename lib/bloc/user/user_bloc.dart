import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(LoadingUserState()){
    on<CreateUserEvent>(_onCreateUser);
    on<LoginUserEvent>(_onLoginUser);
    on<LogoutUserEvent>(_onLogoutUser);
  }

  _onCreateUser(CreateUserEvent event, Emitter<UserState> emit) async{
    if (state is ReadyUserState){
      final response = await userRepository.createUser(
        username: event.username, 
        firstName: event.firstName, 
        lastName: event.lastName, 
        email: event.email, 
        password: event.password,
      );
        emit(LoadingUserState(responseText: response));
    }
  }

  _onLoginUser(LoginUserEvent event, Emitter<UserState> emit) async{
    await userRepository.loginUser(
      username: event.username,
      password: event.password,
    );
    emit(LoadingUserState());
  }

  _onLogoutUser(LogoutUserEvent event, Emitter<UserState> emit) async{
    await userRepository.logoutUser();
    emit(LoadingUserState());
  }
}



