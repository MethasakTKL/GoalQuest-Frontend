import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class PointBloc extends Bloc<PointEvent, PointState>{
  final PointRepository pointRepository;

  PointBloc(this.pointRepository) : super(LodingPointState()){
    on<LoadPointEvent>(_onLoadPointEvent);
  }

  _onLoadPointEvent(LoadPointEvent event, Emitter<PointState> emit) async {
    emit(LodingPointState());
    try {
      final points = await pointRepository.loadPoint();
      emit(ReadyPointState(points: points));
    } catch (e) {
      emit(ErrorPointState(error: e.toString()));
    }
  }
}