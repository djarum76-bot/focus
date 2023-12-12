import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/features/dashboard/data/models/dashboard_model.dart';

class DashboardCubit extends Cubit<DashboardModel>{
  DashboardCubit() : super(DashboardModel(0, PageController()));

  void changePage(int val){
    emit(DashboardModel(val, state.pageController));
  }
}