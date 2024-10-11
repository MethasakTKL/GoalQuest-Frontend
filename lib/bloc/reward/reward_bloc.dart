import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/models/history_model.dart';
import 'package:goal_quest/repositories/repositories.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepository rewardRepository;
  final HistoryRepository historyRepository;
  RewardBloc(this.rewardRepository, this.historyRepository)
      : super(LodingRewardState()) {
    on<LoadRewardEvent>(_onLoadRewardEvent);
    on<RedeemRewardEvent>(_onRedeemRewardEvent);
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

  _onRedeemRewardEvent(
      RedeemRewardEvent event, Emitter<RewardState> emit) async {
    try {
      final reward =
          await rewardRepository.redeemReward(rewardId: event.rewardId);
      historyRepository.addHistory(HistoryModel(
        historyId:
            DateTime.now().millisecondsSinceEpoch, // สร้าง ID ประวัติการแลกใหม่
        historyPoint: reward.rewardPoints,
        historyTitle: reward.rewardTitle,
        redeemDate: DateTime.now(),
      ));
    } catch (e) {
      emit(ErrorRewardState(error: e.toString()));
    }
  }
}
