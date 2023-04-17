import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../main.dart';
import '../../screens/home/cubit/home_cubit.dart';
import '../../screens/home/cubit/home_state.dart';
import '../../screens/setting/help_support.dart';
import '../../screens/setting/setting_screen.dart';
import '../../screens/setting/team_about.dart';
import 'component.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  GlobalKey<FormState> drawerKey =
      GlobalKey<FormState>(debugLabel: 'HomeScreen');

  bool isDark = darkNotifier.value;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit =HomeCubit.get(context);
        return  Drawer(
          key: drawerKey,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    top: 100,
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image(
                          image: NetworkImage(
                            cubit.userModel!.image.toString(),
                          ),
                          fit: BoxFit.cover,
                          height: 75,
                          width: 75,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        cubit.userModel!.name!,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    navigatorTo(context,  SettingScreen());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        IconBroken.Setting,
                        size: 20,
                      ),
                      Text(
                        'Setting and Privacy',
                      ),
                      Icon(IconBroken.Arrow___Right_2)
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    navigatorTo(context,  HelpScreen());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        IconBroken.Edit_Square,
                        size: 20,
                      ),
                      Text(
                        'Help and Support',
                      ),
                      Icon(IconBroken.Arrow___Right_2)
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    navigatorTo(context,  TeamScreen());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 20,
                      ),
                      Text(
                        'Teem and About',
                      ),
                      Icon(IconBroken.Arrow___Right_2)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        CupertinoIcons.leaf_arrow_circlepath,
                        size: 20,
                      ),
                      const Text(
                        'Dark Mode',
                      ),
                      IconButton(
                        onPressed: () {
                          isDark = !isDark;
                          darkNotifier.value = isDark;
                        },
                        icon: Icon(Icons.bubble_chart),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Push Notification',
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notification_add_outlined),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 110,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          HomeCubit.get(context).signOut(context: context);
                        },
                        child: Text(
                          'Log Out',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
