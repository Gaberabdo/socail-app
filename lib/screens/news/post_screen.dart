// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:icon_broken/icon_broken.dart';
// import 'package:social/helper/component/component.dart';
// import 'package:social/screens/home/cubit/home_cubit.dart';
// import 'package:social/screens/home/home_screen.dart';
// import 'package:social/screens/home/cubit/home_state.dart';
//
// class PostScreen extends StatelessWidget {
//   const PostScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomePageStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var userModel = HomeCubit.get(context).userModel;
//         var cubit = HomeCubit.get(context);
//         var textController =TextEditingController();
//         return Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//               icon: const Icon(IconBroken.Arrow___Left_2),
//               onPressed: () {
//                 navigatorTo(context, HomeScreen());
//               },
//             ),
//             title: const Text('Add Post'),
//             actions: [
//               IconButton(
//                 icon: const Icon(IconBroken.Upload),
//                 onPressed: () {
//                   var now = DateTime.now();
//
//                   if (cubit.postImage == null)
//                   {
//                     cubit.createPost(
//                       dateTime: now.toString(),
//                       text: textController.text,
//                     );
//                   } else
//                   {
//                     cubit.uploadPostImage(
//                       dateTime: now.toString(),
//                       text: textController.text,
//                     );
//                   }
//
//                 },
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   if(state is CreatePostLoadingHomePageStates)
//                     const LinearProgressIndicator(),
//                   if(state is CreatePostLoadingHomePageStates)
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                   Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: Image(
//                           width: 50,
//                           height: 50,
//                           image: NetworkImage(
//                             userModel!.image.toString(),
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       nameEdit(text: userModel!.name!, fontSize: 16),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   TextField(
//                     controller: textController,
//                     maxLines: null,
//                     keyboardType: TextInputType.multiline,
//                     style: const TextStyle(height: 2),
//                     decoration: const InputDecoration(
//                         alignLabelWithHint: true,
//                         hintText: "Write......",
//                         hintStyle: TextStyle(fontSize: 20)),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   if(cubit.postImage != null)
//                   Stack(
//                       alignment: AlignmentDirectional.topEnd,
//                       children: [
//                         Container(
//                           height: 400.0,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4.0,),
//                             image: DecorationImage(
//                               image: FileImage(cubit.postImage!),
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const CircleAvatar(
//                             radius: 20.0,
//                             child: Icon(
//                               Icons.close,
//                               size: 16.0,
//                             ),
//                           ),
//                           onPressed: ()
//                           {
//                             cubit.removePostImage();
//                           },
//                         ),
//                       ],
//                     ),
//                   const SizedBox(
//                     height: 20.0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           floatingActionButton: Container(
//             height: 70,
//             width: 70,
//             child: FloatingActionButton(
//
//               elevation: 30,
//               onPressed: () {
//                 cubit.getPostImage();
//               },
//               child:const Icon(IconBroken.Image,size: 35,),
//
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/screens/home/cubit/home_state.dart';
import 'package:video_player/video_player.dart';

import '../../helper/component/component.dart';
import '../../helper/component/video_detail.dart';
import '../home/cubit/home_cubit.dart';
import '../home/home_screen.dart';

class PostScreen extends StatelessWidget {
  TextEditingController textcontrroler = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                navigatorTo(context, HomeScreen());
              },
            ),
            title: const Text('Create Post'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(cubit.userModel.image!),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${cubit.userModel.name}',
                      style: GoogleFonts.eduNswActFoundation(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textcontrroler,
                    decoration: const InputDecoration(
                      hintText: 'What is on your Mind.....?',
                    ),
                  ),
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: FileImage(cubit.postImage!),
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
                            Icons.delete_rounded,
                          ))
                    ],
                  ),
                if (cubit.video != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          NowPlayingVideoWidget(url: cubit.video!, height: 100),
                    ),
                  ),
                if (cubit.video != null)
                  TextButton(
                      onPressed: () {
                        cubit.removePostImage();
                      },
                      child: const Text('Remove video')),
                Row(
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: const Icon(IconBroken.Image)),
                    ),
                    Expanded(
                        child: RawMaterialButton(
                            onPressed: () {
                              if (cubit.postImage == null &&
                                  cubit.video == null) {
                                cubit.createPost(
                                    text: textcontrroler.text,
                                    dataTime: now.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Post Added')));
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeScreen();
                                }));
                              } else if (cubit.video != null) {
                                cubit.uploadNewPostWithVideo(
                                    text: textcontrroler.text,
                                    dataTime: now.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Post Added')));

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeScreen();
                                }));
                              } else {
                                cubit.uploadPostImage(
                                    text: textcontrroler.text,
                                    dateTime: now.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Post Added')));
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeScreen();
                                }));
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.grey),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18),
                                child: Row(
                                  children: [
                                    Text(
                                      'Add Post',
                                      style: GoogleFonts.eduNswActFoundation(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Spacer(),
                                    const Icon(IconBroken.Upload)
                                  ],
                                ),
                              ),
                            ))),
                    Expanded(
                        child: RawMaterialButton(
                            onPressed: () {
                              cubit.uploadvideo();
                            },
                            child: const Icon(IconBroken.Video))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
