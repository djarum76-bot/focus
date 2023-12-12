import 'package:focus/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:focus/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:focus/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:focus/features/focus/presentation/blocs/focus/focus_bloc.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

void injectorSetup() {
  /// For authentication
  injector.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl());

  /// For dashboard
  injector.registerSingleton<DashboardCubit>(DashboardCubit());

  /// For focus
  injector.registerSingleton<FocusBloc>(FocusBloc());
}
