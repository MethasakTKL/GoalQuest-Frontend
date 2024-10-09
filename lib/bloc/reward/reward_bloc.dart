import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepository rewardRepository;
  RewardBloc(this.rewardRepository) : super(LodingRewardState()) {
    on<LoadRewardEvent>(_onLoadRewardEvent);
  }
  _onLoadRewardEvent(LoadRewardEvent event, Emitter<RewardState> emit) async {
    emit(LodingRewardState());
    try {
      final rewards = await rewardRepository.getAlllRewards();
      emit(ReadyRewardState(rewards: rewards));
    } catch (e) {
      emit(ErrorRewardState(error: e.toString()));
    }
  }
}