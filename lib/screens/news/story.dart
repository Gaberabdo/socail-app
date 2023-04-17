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

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {

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
              title: const Text('Add Story'),
              actions: [
                IconButton(
                  onPressed: () {
                    var now = DateTime.now();

                    if (cubit.story == null && cubit.storyVideo == null) {
                      cubit.createStory(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    } else if (cubit.story != null) {
                      cubit.uploadStory(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    } else if (cubit.storyVideo != null) {
                      cubit.uploadStoryVideo(
                          dateTime: now.toString(), text: textController.text);
                    }
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
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            width: 50,
                            height: 50,
                            image: NetworkImage(
                              cubit.userModel!.image.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        nameEdit(text: cubit.userModel!.name!, fontSize: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: textController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,

                        style: const TextStyle(height: 2),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            alignLabelWithHint: true,
                            hintText: "Write......",
                            hintStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (cubit.story != null)
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                4.0,
                              ),
                              image: DecorationImage(
                                image: FileImage(cubit.story!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                          onPressed: () {
                            cubit.removePostImage();
                          },
                        ),
                      ],
                    ),
                  ),
                if (cubit.storyVideo != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NowPlayingVideoWidget(
                          url: cubit.storyVideo!, height: 100),
                    ),
                  ),
                if (cubit.storyVideo != null)
                  TextButton(
                      onPressed: () {
                        cubit.removePostImage();
                      },
                      child: const Text('Remove video')),
                if (cubit.storyVideo == null  && cubit.story == null)
                  Spacer(),
                  const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {
                          cubit.getStoryVideo();
                        },
                        shape: const CircleBorder(),
                        elevation: 2.0,
                        fillColor:
                            isDark ? Colors.white70 : Colors.purple.shade100,
                        padding: const EdgeInsets.all(12.0),
                        child: const Icon(
                          IconBroken.Video,
                          size: 20.0,
                          color: Colors.purple,
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          cubit.getCamera();
                        },
                        shape: const CircleBorder(),
                        elevation: 2.0,
                        fillColor: Colors.purple,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white70,
                          radius: 30,
                          child: Icon(Icons.camera),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          cubit.getStoryImage();
                        },
                        shape: const CircleBorder(),
                        elevation: 2.0,
                        fillColor:
                            isDark ? Colors.white70 : Colors.purple.shade100,
                        padding: const EdgeInsets.all(12.0),
                        child: const Icon(
                          IconBroken.Image,
                          color: Colors.purple,
                          size: 20.0,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
