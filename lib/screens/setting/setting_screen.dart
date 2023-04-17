import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/home_screen.dart';
import 'package:social/screens/home/cubit/home_state.dart';
import 'package:social/screens/profile/profile.dart';

import '../../helper/component/drawer.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var userModel = HomeCubit.get(context).userModel;
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();
        var formKey = GlobalKey<FormState>();
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigatorTo(context, HomeScreen());
                  },
                  icon: const Icon(
                    IconBroken.Home,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    cubit.updateCoverProfile(
                    );
                    cubit.updateProfile();
                  },
                  icon: const Icon(IconBroken.Upload))
            ],
          ),
          drawer: const CustomDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    4.0,
                                  ),
                                  topRight: Radius.circular(
                                    4.0,
                                  ),
                                ),
                                image: DecorationImage(
                                  image: cubit.imageProfileCover == null
                                      ? NetworkImage(
                                          '${userModel.cover}',
                                        ) as ImageProvider
                                      : FileImage(cubit.imageProfileCover!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                backgroundColor:
                                    ThemeData.light().scaffoldBackgroundColor,
                                radius: 20.0,
                                child: const Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                cubit.getProfileCoverImage();
                              },
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: cubit.imageProfile == null
                                  ? NetworkImage(
                                      '${userModel.image}',
                                    ) as ImageProvider
                                  : FileImage(cubit.imageProfile!),
                            ),
                          ),
                          IconButton(
                            icon: CircleAvatar(
                              backgroundColor:
                                  ThemeData.light().scaffoldBackgroundColor,
                              radius: 20.0,
                              child: const Icon(
                                IconBroken.Camera,
                                size: 16.0,
                              ),
                            ),
                            onPressed: () {
                              cubit.getProfileImage();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          label: Text('name'),
                          prefixIcon: Icon(IconBroken.User),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          label: Text('Phone'),
                          prefixIcon: Icon(IconBroken.Call),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: bioController,
                        decoration: const InputDecoration(
                          label: Text('Bio'),
                          prefixIcon: Icon(IconBroken.Edit),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                          ),
                          onPressed: () {
                            cubit.updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              bio: bioController.text,
                            );
                          },
                          child: Text(
                            'Upload',
                            style: GoogleFonts.aBeeZee(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
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
