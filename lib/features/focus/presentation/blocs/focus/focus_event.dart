part of 'focus_bloc.dart';

abstract class FocusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FocusInitialized extends FocusEvent{}

class FocusStarted extends FocusEvent{}

class FocusPaused extends FocusEvent{}

class FocusResume extends FocusEvent{}

class FocusFinished extends FocusEvent{}
