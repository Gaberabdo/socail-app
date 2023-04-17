import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/helper/component/drawer.dart';
import 'package:social/screens/chat/chat_screen.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/cubit/home_state.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/screens/news/post_screen.dart';

import '../chat/user/search_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> homeKey = GlobalKey<FormState>(debugLabel: 'HomeScreen');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context) {
            return Scaffold(

                key: homeKey,
                endDrawerEnableOpenDragGesture: true,
                drawer: const CustomDrawer(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.red, Colors.purple]),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      navigatorTo(context, PostScreen());
                    },
                    child: const Icon(
                      IconBroken.Plus,
                    ),
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 0,
                  onTap: (int index) {
                    cubit.changeBottom(index);
                  },
                  currentIndex: cubit.currentIndex,
                  type: BottomNavigationBarType.fixed,
                  landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(IconBroken.Home), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(IconBroken.Video), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(IconBroken.Category), label: ''),
                  ],
                ),
                appBar: AppBar(
                  elevation: 0,
                  title: Text(cubit.title[cubit.currentIndex]),
                  actions: [
                    IconButton(
                      onPressed: () {
                        navigatorTo(context, SearchScreen());
                      },
                      icon: Icon(
                        IconBroken.Search,
                      ),
                    )
                  ],
                ),
                body: cubit.screen[cubit.currentIndex]);
          },
          fallback: (context) => const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: LinearProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
