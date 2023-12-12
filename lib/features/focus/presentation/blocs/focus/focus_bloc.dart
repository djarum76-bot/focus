import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'focus_event.dart';
part 'focus_state.dart';

class FocusBloc extends Bloc<FocusEvent, FocusState> {
  FocusBloc() : super(const FocusState()) {
    on<FocusInitialized>(_onFocusInitialized);
    on<FocusStarted>(_onFocusStarted);
    on<FocusPaused>(_onFocusPaused);
    on<FocusResume>(_onFocusResume);
    on<FocusFinished>(_onFocusFinished);
  }

  void _onFocusInitialized(FocusInitialized event, Emitter<FocusState> emit)async{
    emit(state.copyWith(
      status: FocusStatus.initial,
      duration: 10,
      ringtone: state.ringtone,
      message: null
    ));
  }

  void _onFocusStarted(FocusStarted event, Emitter<FocusState> emit)async{
    emit(state.copyWith(
      status: FocusStatus.start
    ));
  }

  void _onFocusPaused(FocusPaused event, Emitter<FocusState> emit)async{
    emit(state.copyWith(
      status: FocusStatus.pause
    ));
  }

  void _onFocusResume(FocusResume event, Emitter<FocusState> emit)async{
    emit(state.copyWith(
      status: FocusStatus.resume
    ));
  }

  void _onFocusFinished(FocusFinished event, Emitter<FocusState> emit)async{
    emit(state.copyWith(
      status: FocusStatus.finished
    ));
  }
}
