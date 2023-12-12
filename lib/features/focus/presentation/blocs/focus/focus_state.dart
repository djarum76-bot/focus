part of 'focus_bloc.dart';

enum FocusStatus { initial, start, pause, resume, loading, finished, error }

class FocusState extends Equatable{
  const FocusState({
    this.status = FocusStatus.initial,
    this.duration = 10,
    this.ringtone = "",
    this.message
  });

  final FocusStatus status;
  final int duration;
  final String ringtone;
  final String? message;

  @override
  List<Object?> get props => [status, duration, ringtone, message];

  FocusState copyWith({
    FocusStatus? status,
    int? duration,
    String? ringtone,
    String? message,
  }) {
    return FocusState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      ringtone: ringtone ?? this.ringtone,
      message: message ?? this.message,
    );
  }
}