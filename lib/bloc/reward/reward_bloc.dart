import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:goal_quest/repositories/repositories.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepository rewardRepository;
  final HistoryBloc historyBloc;

  RewardBloc(this.rewardRepository, this.historyBloc) : super(LodingRewardState()) {
    on<LoadRewardEvent>(_onLoadRewardEvent);
    on<RedeemRewardEvent>(_onRedeemRewardEvent);
  }
  _onLoadRewardEvent(LoadRewardEvent event, Emitter<RewardState> emit) async {
    emit(LodingRewardState());
    try {
      final rewards = await rewardRepository.getAllRewards();
      emit(ReadyRewardState(rewards: rewards));
    } catch (e) {
      emit(ErrorRewardState(error: e.toString()));
    }
  }

  _onRedeemRewardEvent(
      RedeemRewardEvent event, Emitter<RewardState> emit) async {
     try {
    final reward = await rewardRepository.redeemReward(rewardId: event.rewardId);

    debugPrint('Reward redeemed: ${reward.rewardTitle}');
    debugPrint('Reward redeemed: ${reward.rewardId}');

    // ส่ง State พร้อมกับรายการ rewards ที่อัพเดต
    emit(RewardRedeemedState(rewards: state.rewards, rewardId: event.rewardId));
    historyBloc.add(LoadHistoryEvent());  // เรียกให้โหลดประวัติใหม่หลังจาก redeem สำเร็จ
  } catch (e) {
    debugPrint('Failed to redeem reward: $e');
    emit(ErrorRewardState(error: "Failed to redeem reward."));
  }
  }
}
