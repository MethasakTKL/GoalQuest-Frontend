import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';


class HistoryBloc extends Bloc<HistoryEvent, HistoryState>{
  final HistoryRepository historyRepository;
  HistoryBloc(this.historyRepository) : super(LoadingHistoryState()){
    on<LoadHistoryEvent>(_onLoadHistoryEvent);
    on<AddHistoryEvent>(_onAddHistoryEvent);
  }
  _onLoadHistoryEvent(LoadHistoryEvent event, Emitter<HistoryState> emit) async{
    emit(LoadingHistoryState());
    try{
      final histories = await historyRepository.loadHistory();
      emit(ReadyHistoryState(histories: histories));
    }catch(e){
      emit(ErrorHistoryState(error: e.toString()));
    }
  }
  _onAddHistoryEvent(AddHistoryEvent event, Emitter<HistoryState> emit) async{
    try{
    await historyRepository.addHistory(event.history);
    final histories = await historyRepository.loadHistory();
    emit(ReadyHistoryState(histories: histories));
    }catch(e){
      emit(ErrorHistoryState(error: e.toString()));
    }
  }
}