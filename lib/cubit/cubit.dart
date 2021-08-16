import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/health/health_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/Sports_Screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sport',
    ),

    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_hospital),
      label: 'Health',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    HealthScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    if (index == 1) getSports();
    else if (index == 2) getScience();
    else if (index == 3) getHealth();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': '1130c2013ed4410393d666c936cdd02e'
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apikey': '1130c2013ed4410393d666c936cdd02e'
    }).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }


  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apikey': '1130c2013ed4410393d666c936cdd02e'
    }).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }


  List<dynamic> health = [];

  void getHealth() {
    emit(NewsGetHealthLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'health',
        'apikey': '1130c2013ed4410393d666c936cdd02e'
      },
    ).then((value) {
      health = value.data['articles'];
      emit(NewsGetHealthSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetHealthErrorState(error));
    });
  }


  List<dynamic> search = [];

  void getSearch(value) {
    emit(NewsGetSearchLoadingState());

    search = [];

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apikey': '1130c2013ed4410393d666c936cdd02e'
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
