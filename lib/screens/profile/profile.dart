import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../helper/component/component.dart';
import '../home/cubit/home_cubit.dart';
import '../home/cubit/home_state.dart';
import '../login/login_screen.dart';
import '../setting/setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var userModel = HomeCubit.get(context).userModel;
        var textController = TextEditingController();
        textController.text = userModel.bio!;

        return Column(
          children: [
            SizedBox(
              height: 250.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                        height: 180.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              4.0,
                            ),
                            topRight: Radius.circular(
                              4.0,
                            ),
                          ),
                        ),
                        child: Image(
                          image: cubit.imageProfileCover == null
                              ? NetworkImage(cubit.userModel!.cover.toString())
                              : FileImage(cubit.imageProfileCover!)
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        )),
                  ),
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 54.0,
                      backgroundImage: cubit.imageProfile == null
                          ? NetworkImage(cubit.userModel!.image.toString())
                          : FileImage(cubit.imageProfile!) as ImageProvider,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel!.name!,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        cubit.userModel!.bio!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 4,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SettingScreen();
                            },
                          ),
                        );
                      },
                      icon: const Icon(IconBroken.Edit)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 40,
                thickness: 3,
              ),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("100"),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Post"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("250"),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Photos"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("10K"),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Followers"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("64"),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Following"),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 40,
                thickness: 3,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    FirebaseMessaging.instance.subscribeToTopic('user_not');
                  },
                  child: const Text(
                    'Subscribe',
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    FirebaseMessaging.instance.unsubscribeFromTopic('user_not');
                  },
                  child: const Text(
                    'UnSubscribe',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
