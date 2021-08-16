import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_cubit/cubit.dart';
import 'package:news_app/components/component/component.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                    navigatTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomNavItems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
