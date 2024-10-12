import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class PointBloc extends Bloc<PointEvent, PointState>{
  final PointRepository pointRepository;

  PointBloc(this.pointRepository) : super(LodingPointState()){
    on<LoadCurrentUserPointEvent>(_onLoadPointEvent);
    on<LoadAllPointsEvent>(_onLoadAllPoints);
  }

  _onLoadPointEvent(LoadCurrentUserPointEvent event, Emitter<PointState> emit) async {
    emit(LodingPointState());
    try {
       final currentUserPoints = await pointRepository.getCurrentUserPoint();
      emit(ReadyPointState(points: [currentUserPoints]));
    } catch (e) {
      emit(ErrorPointState(error: e.toString()));
    }
  }

  _onLoadAllPoints(LoadAllPointsEvent event, Emitter<PointState> emit) async {
    emit(LodingPointState());
    try {
       final allPoints = await pointRepository.getAllPoints();
      emit(ReadyPointState(points: allPoints));
    } catch (e) {
      emit(ErrorPointState(error: e.toString()));
    }
  }
}