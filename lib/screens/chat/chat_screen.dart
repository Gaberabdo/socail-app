import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/helper/component/video_detail.dart';
import 'package:social/screens/chat/call.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/cubit/home_state.dart';
import 'package:social/screens/home/home_screen.dart';

import '../../main.dart';
import '../../model/chat_model.dart';
import '../../model/user_model.dart';
import 'videoCall.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({
    super.key,
    required this.userModel,
  });

  var messageController = TextEditingController();

  bool isDark = darkNotifier.value;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomeCubit.get(context).getMessages(userModel);
        return BlocConsumer<HomeCubit, HomePageStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return Scaffold(
              backgroundColor: isDark ? Colors.white10 : Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    navigatorTo(context, HomeScreen());
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CallScreen()));
                    },
                    icon: const Icon(IconBroken.Call),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoCallScreen()));
                    },
                    icon: const Icon(IconBroken.Video),
                  ),
                ],
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        userModel.image.toString(),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      userModel.name.toString(),
                      style: const TextStyle(
                          fontSize: 14, overflow: TextOverflow.clip),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                HomeCubit.get(context).messagesList[index];
                            if (uId == message.senderId) {
                              return buildMyMessage(message, context);
                            } else {
                              return buildMessage(message, context);
                            }
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: HomeCubit.get(context).messagesList.length,
                        ),
                      ),
                      Column(
                        children: [
                          if (cubit.chatImage != null)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Card(
                                  elevation: 10,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image(
                                    image: FileImage(cubit.chatImage!),
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.removePostImage();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                    ))
                              ],
                            ),
                          if (cubit.VideoChat != null)
                            Stack(
                              alignment: AlignmentDirectional.topStart,
                              children: [
                                Card(
                                    elevation: 10,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: NowPlayingVideoWidget(
                                          url: cubit.VideoChat!, height: 300),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      cubit.removePostImage();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color:
                                    isDark ? Colors.white70 : Colors.lightBlue,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    keyboardType: TextInputType.multiline,
                                    keyboardAppearance: Brightness.dark,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here...',
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          HomeCubit.get(context)
                                              .uploadvideochat();
                                        },
                                        icon: const Icon(IconBroken.Chart),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).getChatImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Image_2,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.lightBlue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (cubit.chatImage == null &&
                                        cubit.VideoChat == null) {
                                      HomeCubit.get(context).sendMessage(
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                        receiverId: userModel.uId!,
                                      );
                                    } else if (cubit.chatImage != null) {
                                      HomeCubit.get(context).sendChatImage(
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                        receiverId: userModel.uId!,
                                      );
                                    } else if (cubit.VideoChat != null) {
                                      cubit.UplaodVideochat(
                                          reciverid: userModel.uId!,
                                          text: messageController.text,
                                          datatime: DateTime.now().toString());
                                    }
                                    messageController.clear();
                                  },
                                  icon: Icon(
                                    IconBroken.Send,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.lightBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model, context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                15.0,
              ),
              topStart: Radius.circular(
                15.0,
              ),
              topEnd: Radius.circular(
                15.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Column(
            children: [
              if (model.image!.isNotEmpty)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.0,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(model.image.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              if (model.video!.isNotEmpty)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 200.0,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.0,
                        ),
                      ),
                      child:
                          HotVideo(url: model.video.toString()!, height: 200),
                    ),
                  ],
                ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  model.message.toString(),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.lightBlue.shade200,
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                15.0,
              ),
              topStart: Radius.circular(
                15.0,
              ),
              topEnd: Radius.circular(
                15.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.image!.isNotEmpty)
                Container(
                  height: 200.0,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(model.image.toString()),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (model.video!.isNotEmpty)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 200.0,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.0,
                        ),
                      ),
                      child:
                          HotVideo(url: model.video.toString()!, height: 200),
                    ),
                  ],
                ),
              Text(
                model.message.toString(),
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                model.time!.substring(0, 10).toString(),
                style: const TextStyle(fontSize: 10, color: Colors.black38),
              ),
            ],
          ),
        ),
      );
}
