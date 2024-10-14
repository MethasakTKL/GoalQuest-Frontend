import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class EarnedBloc extends Bloc<EarnedEvent, EarnedState>{
  final EarnedRepository earnedRepository;

  EarnedBloc(this.earnedRepository) : super(LoadingEarnedState()){
    on<LoadEarnedEvent>(_onLoadEarnedEvent);
  }

  _onLoadEarnedEvent(LoadEarnedEvent event, Emitter<EarnedState> emit) async{
    emit(LoadingEarnedState());
    try{
      final earneds = await earnedRepository.loadEarned();
      emit(ReadyEarnedState(earneds: earneds));
    } catch (e){
      emit(ErrorEarnedState(error: e.toString()));
    }
  }
}