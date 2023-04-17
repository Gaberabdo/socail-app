import 'dart:io';

import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/helper/component/video_detail.dart';
import 'package:social/model/video_model.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/cubit/home_state.dart';

import '../../model/post_model.dart';
import 'add_video.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: PageView.builder(
            itemCount: cubit.videoModel.length,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.height,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: NetworkImage(
              //               'https://img.freepik.com/free-photo/red-white-cat-i-white-studio_155003-13189.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296'))),
              // );
              return buildVideo(cubit.videoModel[index],context);
            },
          ),
        );
      },
    );
  }

  Widget buildVideo(VideoModel model,context) => Stack(
        children: [
          Expanded(child: HotVideo(url: model.object!, height: double.infinity)),
          Padding(
            padding: const EdgeInsets.only(
              top: 2,
              left: 20,
              right: 30
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                  NetworkImage(model.image.toString()),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  model.name.toString(),
                  style:
                  const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    navigatorTo(context, AddVideoScreen());
                  },
                  icon: Icon(IconBroken.Plus,size: 25,color: Colors.grey,),
                ),
              ],
            ),
          )

        ],
      );
}
