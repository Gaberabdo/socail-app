import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/home_screen.dart';
import 'package:social/helper/component/video_detail.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../home/cubit/home_state.dart';

bool isDark = darkNotifier.value;

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<HomeCubit, HomePageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var textController = TextEditingController();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  navigatorTo(context, HomeScreen());
                },
                icon: const Icon(Icons.close),
              ),
              title: const Text('Add Video'),
              actions: [
                IconButton(
                  onPressed: () {
                    var now = DateTime.now();
                    HomeCubit.get(context)
                        .uploadVideo(dateTime: now.toString());
                  },
                  icon: const Icon(IconBroken.Upload),
                ),
              ],
            ),
            body: Column(
              children: [
                if (state is CreateStoryLoadingHomePageStates)
                  const LinearProgressIndicator(),
                if (state is CreateStoryLoadingHomePageStates)
                  const SizedBox(
                    height: 10.0,
                  ),
                if (cubit.hotVideo == null)
                  Expanded(
                    child: Image.network(
                      'https://img.freepik.com/free-vector/video-content-creator-blogger-colorful-cartoon-character-video-editing-uploading-cutting-arrangement-video-shot-manipulation_335657-762.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais',
                      fit: BoxFit.contain,
                    ),
                  ),
                if (cubit.hotVideo != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NowPlayingVideoWidget(
                          url: cubit.hotVideo!, height: 100),
                    ),
                  ),
                if (cubit.hotVideo != null)
                  TextButton(
                      onPressed: () {
                        cubit.removePostImage();
                      },
                      child: const Text('Remove video')),

              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                HomeCubit.get(context).getHotVideo();
              },
              child: Icon(IconBroken.Plus),
            ),
          );
        },
      );
    });
  }
}
