import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/screens/home/cubit/home_state.dart';

import '../home/cubit/home_cubit.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen(
      {required this.commentId, required this.image, required this.name});
  var now = DateTime.now();
  String? image;
  String? name;
  TextEditingController textController = TextEditingController();
  String? commentId;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomeCubit().getComment(postId: commentId!);
        return BlocConsumer<HomeCubit, HomePageStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            print(cubit.commentPost.length);
            print(commentId);
            print('lennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
            return Scaffold(
              appBar: AppBar(
                title: Text('Comments'),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        print(cubit.commentPost.length);
                        print('lennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
                        return buildCommentItem(cubit, index,context);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: cubit.commentPost.length,
                      shrinkWrap: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.commentPostDetails(
                                  comment: textController.text,
                                  commentId: commentId!,
                                  dataTime: now.toString());
                              textController.clear();
                            },
                            icon: const Icon(
                              IconBroken.Send,
                              size: 16,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadiusDirectional.circular(100),
                              child: Image(
                                image: NetworkImage(HomeCubit.get(context)
                                    .userModel
                                    .image
                                    .toString()),
                                fit: BoxFit.cover,
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
                ],
              ),
            );
          },
        );
      },
    );
  }

  Column buildCommentItem(HomeCubit cubit, int index,context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(radius: 25, backgroundImage: NetworkImage(image!)),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width-100,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name!,
                        style: GoogleFonts.eduNswActFoundation(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(cubit.commentPost[index].text!),
                          Spacer(),
                          Text(cubit.commentPost[index].dataTime!.substring(0,11),style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700
                          ),),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
