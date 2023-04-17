import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/helper/component/video_detail.dart';
import 'package:social/model/post_model.dart';
import 'package:social/model/story_model.dart';
import 'package:social/model/user_model.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/cubit/home_state.dart';
import 'package:social/screens/news/story.dart';
import 'package:social/screens/news/story_details.dart';

import 'comments_screen.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Container(
                      height: 80,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      gradient: const LinearGradient(
                                          colors: [Colors.pink, Colors.purple]),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.5),
                                      child: Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  HomeCubit.get(context)
                                                      .userModel
                                                      .image
                                                      .toString(),
                                                ))),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.pink.shade400,
                                        Colors.purple
                                      ],
                                    ),
                                  ),
                                  child: IconButton(
                                    iconSize: 16,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      navigatorTo(context, const StoryScreen());
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return buildStoryItem(
                                    context, cubit.stories[index], index);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 8.0,
                              ),
                              itemCount: cubit.stories.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPostItem(context, cubit.posts[index], index,cubit),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                    itemCount: cubit.posts.length,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          },
        );
      },
    );
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Widget buildPostItem(context, PostModel model, index ,HomeCubit cubit) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      model.image.toString(),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name.toString(),
                              style: const TextStyle(
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                          ],
                        ),
                        Text(
                          model.dateTime.toString().substring(0, 10),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  PopupMenuButton<int>(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: InkWell(
                          onTap: () {
                            HomeCubit.get(context).removePost(
                                HomeCubit.get(context).postId[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Success Remove')));
                          },
                          child: const Row(
                            children: [
                              Text('Remove post'),
                              Spacer(),
                              Icon(Icons.remove)
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: InkWell(
                          onTap: () {
                            HomeCubit.get(context).savedPosts();
                          },
                          child: const Row(
                            children: [
                              Text('Saved post'),
                              Spacer(),
                              Icon(Icons.bookmark_border_outlined)
                            ],
                          ),
                        ),
                      ),
                    ],
                    icon: const Icon(
                      Icons.more_horiz,
                    ),
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                model.text.toString(),
                maxLines: 6,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 12,
              ),
              if (model.postImage! != '')
                Container(
                  height: 400.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(model.postImage.toString()),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              if (model.video! != '')
                Container(
                  height: 400.0,
                  width: double.infinity,
                  child: HotVideo(url: model.video!, height: 100),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                HomeCubit.get(context).likes[index].toString(),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                HomeCubit.get(context)
                                    .comment[index]
                                    .toString(),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextField(
                        onSubmitted: (value) {

                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CommentsScreen(commentId: cubit.postId[index],
                                  image: cubit.userModel.image,name: cubit.userModel.name,);

                              }

                              ));
                              cubit.getComment(postId: cubit.postId[index]);
                            },
                            icon: const Icon(
                              Icons.send,
                              size: 16,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadiusDirectional.circular(100),
                              child: Image(
                                image: NetworkImage(model.image.toString()),
                                fit: BoxFit.contain,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: "Add comment..",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Expanded(
                  //   child: InkWell(
                  //     child: Row(
                  //       children: [
                  //          CircleAvatar(
                  //           radius: 18.0,
                  //           backgroundImage: NetworkImage(
                  //             model.image.toString(),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           width: 15.0,
                  //         ),
                  //         Text(
                  //           'write a comment ...',
                  //           style:
                  //           Theme.of(context).textTheme.caption?.copyWith(),
                  //         ),
                  //       ],
                  //     ),
                  //     onTap: () {
                  //
                  //     },
                  //   ),
                  // ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      HomeCubit.get(context)
                          .likePosts(HomeCubit.get(context).postId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildStoryItem(context, StoryModel model, int index) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => StoryDetails(storyModel: model),
              ));
          print(HomeCubit.get(context).storyId[index]);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                          colors: [Colors.pink, Colors.purple])),
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(model.image.toString()),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
