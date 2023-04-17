import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/setting/setting_screen.dart';
import 'package:video_player/video_player.dart';
import '../../helper/component/component.dart';
import '../home/cubit/home_state.dart';
import '../login/login_screen.dart';

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
        var textController =TextEditingController();
        textController.text = userModel.bio!;

        return  Column(
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
                          decoration:   const BoxDecoration(
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
                            image: cubit.imageProfileCover == null ? NetworkImage(cubit.userModel!.cover.toString()) : FileImage(cubit.imageProfileCover!) as ImageProvider,
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    CircleAvatar(
                      radius: 54,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 54.0,
                        backgroundImage: cubit.imageProfile == null ? NetworkImage(cubit.userModel!.image.toString()) : FileImage(cubit.imageProfile!) as ImageProvider,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
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

                            SizedBox(
                              height: 80,
                              width: 320,
                              child: TextField(
                                enabled: false,
                                maxLines: 2,
                                controller: textController,
                                style:  GoogleFonts.eduNswActFoundation(height: 2,fontSize: 16,),

                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  alignLabelWithHint: true,
                                  border:InputBorder.none,
                                ),
                              ),
                            ),

                            // Text(
                            //   cubit.userModel!.bio!,
                            //   style: const TextStyle(fontSize: 10, color: Colors.black),
                            //   maxLines: 4,
                            // ),
                          ],
                        ),


                      ],
                    ),

                  ],
                ),
              ),

              Buttonhelper(
                title: 'Edit Profile',
                onchange: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SettingScreen();
                  }));
                },
              ),

            ],
          );
      },
    );
  }
}
