// ignore_for_file: avoid_print
// ignore_for_file: unnecessary_non_null_assertion
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/model/story_model.dart';
import 'package:social/model/team_model.dart';
import 'package:social/model/user_model.dart';
import 'package:social/model/video_model.dart';
import 'package:social/screens/login/login_screen.dart';
import 'package:social/screens/news/news_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../model/chat_model.dart';
import '../../../model/comment_model.dart';
import '../../../model/post_model.dart';
import '../../../model/search_model.dart';
import '../../Video/video_screen.dart';
import '../../chat/user/user_screen.dart';
import 'home_state.dart';
import '../../profile/profile.dart';

class HomeCubit extends Cubit<HomePageStates> {
  HomeCubit() : super(InitialHomePageStates());

  static HomeCubit get(context) => BlocProvider.of(context);

  //Model & variable
  UserModel userModel = UserModel(uId: uId, name: '', phone: '', bio: '');

  TeamModel teamModel = TeamModel('', '');
  int currentIndex = 0;
  File? imageProfileCover;
  File? imageProfile;
  var picker = ImagePicker();
  List<PostModel> posts = [];
  List<PostModel> getLike = [];
  List<PostModel> getSaved = [];
  List<String> postId = [];
  List<String> storyId = [];
  List<int> likes = [];
  List<dynamic> saved = [];
  List<dynamic> comment = [];
  File? postImage;
  File? story;
  File? storyVideo;
  File? hotVideo;
  File? chatImage;
  List<UserModel> user = [];
  List<StoryModel> stories = [];
  //AppBar& navButton
  List<Widget> screen = [
    NewsScreen(),
    VideoScreen(),
    UserScreen(),
    ProfileScreen(),
  ];
  List<String> title = [
    'News Feed',
    'Hot Video',
    'User',
    'Your Profile',
  ];

  //Get Method
  void getTeamData() {
    emit(GetTeamLoadingHomePageStates());
    FirebaseFirestore.instance
        .collection('team')
        .doc('mlvcxaxsI1PQQ0FvE1f8')
        .get()
        .then((value) {
      teamModel = TeamModel.fromJson(value.data());

      print(value.data());
      emit(GetTeamSuccessHomePageStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetTeamErrorHomePageStates(onError.toString()));
    });
  }

  List<SearchModel> searchModel = [];
  Future<void> searchMethod({required String search}) async {
    emit(SearchLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .where('phone', arrayContains: search)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        searchModel.add(SearchModel.fromJson(element.data()));
        print(searchModel.toString());
      }
      emit(SearchSuccessState());
    }).onError((handleError) {
      print(handleError.toString());
      emit(SearchErrorState());
    });
  }

  void getUserData() {
    emit(GetUserLoadingHomePageStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .snapshots()
        .listen((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessHomePageStates());
    }).onError((onError) {
      print(onError.toString());
      emit(GetUserErrorHomePageStates(onError.toString()));
    });
  }

  List<VideoModel> videoModel = [];
  void getHotVideoPiker() {
    emit(GetVideoLoadingState());
    FirebaseFirestore.instance.collection('video').snapshots().listen((event) {
      videoModel = [];
      for (var element in event.docs) {
        element.reference.collection('video').get().then((value) {
          videoModel.add(VideoModel.fromJson(element.data()));
          print(element.id.toString());
        }).catchError((onError) {});
      }
      emit(GetVideoSuccessState());
    }).onError((handleError) {});
  }

  List<UserModel> allUser = [];
  void getAllUserData() {
    emit(GetAllUserLoadingHomePageStates());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != uId) {
          allUser.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUserSuccessHomePageStates());
    }).onError((onError) {
      print(onError.toString());
      emit(GetAllUserErrorHomePageStates());
    });
  }

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      imageProfile = File(pickerFile.path);
      emit(ProfileImageSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImageErrorState());
    }
  }

  Future<void> getProfileCoverImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      imageProfileCover = File(pickerFile.path);
      emit(ProfileImageCoverSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImageCoverErrorState());
    }
  }

  Future<void> getPosts() async {
    emit(GetPostsLoadingHomePageStates());
    FirebaseFirestore.instance.collection('posts').snapshots().listen((value) {
      posts = [];
      emit(GetPostsSuccessHomePageStates());
      print(value.toString());
      for (var element in value.docs) {
        element.reference.collection('comment').get().then((value) {
          comment.add(value.docs.length);
        }).catchError((onError) {});
      }

      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postId.add(element.id);
        }).catchError((onError) {});
      }
    }).onError((onError) {
      emit(GetPostsErrorHomePageStates(onError.toString()));
    });
  }

  void savedPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .doc()
        .collection('saved')
        .doc(userModel!.uId)
        .set({'saved': true}).then((value) {
      emit(SavedPostsSuccessHomePageStates());
    }).catchError((onError) {
      emit(SavedPostsErrorHomePageStates());
    });
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> getChatImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> getCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      story = File(pickedFile.path);
      emit(SocialStoryImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialStoryImagePickedErrorState());
    }
  }

  Future<void> getStoryVideo() async {
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      storyVideo = File(pickedFile.path);
      emit(SocialStoryImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialStoryImagePickedErrorState());
    }
  }

  Future<void> getHotVideo() async {
    final pickedFile = await picker.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(seconds: 40));

    if (pickedFile != null) {
      hotVideo = File(pickedFile.path);
      emit(SocialStoryImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialStoryImagePickedErrorState());
    }
  }

  Future<void> getStoryImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      story = File(pickedFile.path);
      emit(SocialStoryImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialStoryImagePickedErrorState());
    }
  }

  Future<void> getStory() async {
    emit(GetStoryLoadingHomePageStates());
    FirebaseFirestore.instance.collection('story').snapshots().listen((value) {
      stories = [];
      emit(GetStorySuccessHomePageStates());
      print(value.toString());
      for (var element in value.docs) {
        element.reference.collection('story').get().then((value) {
          stories.add(StoryModel.fromJson(element.data()));
          storyId.add(element.id);
          print(element.id.toString());
        }).catchError((onError) {});
      }
    }).onError((onError) {
      emit(GetStoryErrorHomePageStates(onError.toString()));
    });
  }

  //Update Method
  Future<void> updateProfile() async {
    emit(UpdateUserLoadingHomePageStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(imageProfile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            name: userModel!.name!,
            phone: userModel!.phone!,
            bio: userModel!.bio!,
            image: value,
            cover: userModel!.cover);
        emit(UpdateUserSuccessHomePageStates());
      }).catchError((onError) {
        print(onError.toString());
        emit(UpdateUserErrorHomePageStates(onError.toString()));
      });
    });
  }

  Future<void> sendChatImage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
  }) async {
    emit(UpdateUserLoadingHomePageStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
            receiverId: receiverId,
            dateTime: dateTime,
            text: text,
            image: value);
        emit(UpdateUserSuccessHomePageStates());
      }).catchError((onError) {
        print(onError.toString());
        emit(UpdateUserErrorHomePageStates(onError.toString()));
      });
    });
  }

  Future<void> updateCoverProfile() async {
    emit(UpdateUserLoadingHomePageStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfileCover!.path).pathSegments.last}')
        .putFile(imageProfileCover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            name: userModel!.name!,
            phone: userModel!.phone!,
            bio: userModel!.bio!,
            image: userModel!.image,
            cover: value);
        emit(UpdateUserSuccessHomePageStates());
      }).catchError((onError) {
        print(onError.toString());
        emit(UpdateUserErrorHomePageStates(onError.toString()));
      });
    });
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) async {
    emit(UpdateUserLoadingHomePageStates());
    userModel = UserModel(
      email: userModel!.email,
      name: name,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      bio: bio,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(userModel!.toMap())
        .then((value) {
      getUserData();
      print(bio.toString());
      emit(UpdateUserSuccessHomePageStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateUserErrorHomePageStates(onError.toString()));
    });
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingHomePageStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dataTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(CreatePostErrorHomePageStates(error.toString()));
      });
    }).catchError((error) {
      emit(CreatePostErrorHomePageStates(error.toString()));
    });
  }

  //Post Method
  Future<void> createPost({
    String? postImage,
    String? videoPost,
    required String text,
    required String dataTime,
  }) async {
    emit(CreatePostLoadingHomePageStates());
    PostModel model = PostModel(
      name: userModel!.name,
      text: text,
      dateTime: dataTime,
      image: userModel!.image,
      uId: uId,
      postImage: postImage ?? '',
      video: videoPost ?? '',
    );
    await FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessHomePageStates());
    }).catchError((error) {
      emit(CreatePostErrorHomePageStates(error.toString()));
    });
  }

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(LikePostsSuccessHomePageStates());
    }).catchError((onError) {
      emit(LikePostsErrorHomePageStates(onError.toString()));
    });
  }

  void commentPosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(userModel!.uId)
        .set({'comment': true}).then((value) {
      emit(CommentPostsSuccessHomePageStates());
    }).catchError((onError) {
      emit(CommentPostsErrorHomePageStates());
    });
  }

  Future<void> createStory({
    required String text,
    required String dateTime,
    String? object,
  }) async {
    emit(CreateStoryLoadingHomePageStates());
    StoryModel model = StoryModel(
      image: userModel.image,
      name: userModel.name,
      text: text,
      dateTime: dateTime,
      object: object ?? '',
      uId: uId,
    );
    await FirebaseFirestore.instance
        .collection('story')
        .add(model.toMap())
        .then((value) {
      emit(CreateStorySuccessHomePageStates());
    }).catchError((error) {
      emit(CreateStoryErrorHomePageStates(error.toString()));
    });
  }

  Future<void> createVideo({
    required String dateTime,
    String? object,
  }) async {
    emit(CreateStoryLoadingHomePageStates());
    VideoModel model = VideoModel(
      image: userModel.image,
      name: userModel.name,
      dateTime: dateTime,
      object: object ?? '',
      uId: uId,
    );
    await FirebaseFirestore.instance
        .collection('video')
        .add(model.toMap())
        .then((value) {
      emit(CreateStorySuccessHomePageStates());
    }).catchError((error) {
      emit(CreateStoryErrorHomePageStates(error.toString()));
    });
  }

  void uploadVideo({
    required String dateTime,
  }) {
    emit(CreateStoryLoadingHomePageStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('video/${Uri.file(hotVideo!.path).pathSegments.last}')
        .putFile(hotVideo!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createVideo(
          dateTime: dateTime,
          object: value,
        );
      }).catchError((error) {
        emit(CreateStoryErrorHomePageStates(error.toString()));
      });
    }).catchError((error) {
      emit(CreateStoryErrorHomePageStates(error.toString()));
    });
  }

  void uploadStory({
    required String dateTime,
    required String text,
  }) {
    emit(CreateStoryLoadingHomePageStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('story/${Uri.file(story!.path).pathSegments.last}')
        .putFile(story!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createStory(
          text: text,
          dateTime: dateTime,
          object: value,
        );
      }).catchError((error) {
        emit(CreateStoryErrorHomePageStates(error.toString()));
      });
    }).catchError((error) {
      emit(CreateStoryErrorHomePageStates(error.toString()));
    });
  }

  void uploadStoryVideo({
    required String dateTime,
    required String text,
  }) {
    emit(CreateStoryLoadingHomePageStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('story/${Uri.file(storyVideo!.path).pathSegments.last}')
        .putFile(storyVideo!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createStory(
          text: text,
          dateTime: dateTime,
          object: value,
        );
      }).catchError((error) {
        emit(CreateStoryErrorHomePageStates(error.toString()));
      });
    }).catchError((error) {
      emit(CreateStoryErrorHomePageStates(error.toString()));
    });
  }

  //Delete Method
  void removePostImage() {
    postImage = null;
    chatImage = null;
    story = null;
    storyVideo = null;
    hotVideo = null;
    video=null;
    VideoChat=null;

    emit(SocialRemovePostImageState());
  }

  Future<void> removePost(String? postId) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      emit(SocialSuccessRemovePostState());
      print('Deleted');
    }).catchError((onError) {
      emit(SocialErrorRemovePostState());
    });

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('saved')
        .doc()
        .delete()
        .then((value) {
      emit(SocialSuccessRemovePostState());
      print('Deleted');
    }).catchError((onError) {
      emit(SocialErrorRemovePostState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
    String? video,
  }) {
    MessageModel massageModel = MessageModel(
      message: text,
      senderId: uId!,
      receiverId: receiverId,
      time: dateTime,
      image: image ?? '',
      video: video ??'',
    );
    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(uId)
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  //users/VF2t7hHVbfUyh1tmUVGFnOFJNnV2/chat/6TPhznfECJONpN5mFPSPEn4XBJO2/massage
  List<MessageModel> messagesList = [];

  void getMessages(UserModel userDataModel) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(userDataModel.uId)
        .collection('message')
        .orderBy('time', descending: false)
        .snapshots()
        .listen((value) {
      messagesList = [];

      for (var element in value.docs) {
        messagesList.add(MessageModel.fromJson(element.data()));
      }

      debugPrint(messagesList.length.toString());

      emit(SocialGetMessagesSuccessState());
    });
  }

  Future<void> signOut({context}) async {
    await FirebaseAuth.instance.signOut().then((value) async {
      userModel = UserModel(
        uId: '',
        name: '',
        phone: '',
        bio: '',
        image: '',
        email: '',
        cover: '',
      );
      uId = '';
      navigatorTo(context, LoginScreen());
    }).catchError((onError) {});
    emit(SignOutState());
  }

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  TextEditingController messageController = TextEditingController();

  //Comment
  List<CommentModel> commentPost = [];

  void getComment({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      commentPost = [];
      event.docs.forEach((element) {
        commentPost.add(CommentModel.fromJson(element.data()));
      });
      print('Comeeeeeeeeeeeeeeeeeeeent donnnnnnnnnne');
      // print(messages[1].text);
      print(commentPost.length);
      emit(SuccessGetMessage());
    });
  }

  void commentPostDetails(
      {required String comment,
      required String commentId,
      String? videoComment,
      required String dataTime}) {
    emit(CommentLoadingState());
    CommentModel commentModel = CommentModel(
        videochat: videoComment,
        commentId: commentId,
        name: userModel.name,
        uid: uId,
        image: userModel.image,
        text: comment,
        dataTime: dataTime);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(commentId)
        .collection('comments')
        .doc()
        .set(commentModel.toMap())
        .then((value) {
      print('commmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmment');
      emit(CommentSuccessState());
    }).catchError((error) {
      emit(CommentErrorState());
    });
  }

  File? video;
  Future<void> uploadvideo() async {
    final pickerFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickerFile != null) {
      video = File(pickerFile.path);
      print('vidddddddddddddddddddddddo heer');
      print(video.toString());
      emit(VideoSuccess());
    } else {
      print('no video');
      emit(VideoError());
    }
  }
  File? VideoChat;

  Future<void> uploadvideochat() async {
    final pickerfile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickerfile != null) {
      VideoChat = File(pickerfile.path);
      print('vidddddddddddddddddddddddo heer');
      print(VideoChat.toString());
      emit(VideoSuccess());
    } else {
      print('no video');
      emit(VideoError());
    }
  }
  void uploadNewPostWithVideo({
    String? postVideo,
    required String text,
    required String dataTime,
  }) {
    emit(PostLoadingState());
    print('looooooooooooooooooooooooad');
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(video!.path).pathSegments.last}')
        .putFile(video!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('linnnnnnnnnk video here');
        print(value);
        createPost(videoPost: value, text: text, dataTime: dataTime);
        print('donnnne post uplaoad');
        emit(PostWithVideoSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(PostErrorState());
      });
    }).catchError((onError) {
      emit(PostErrorState());
    });
  }


  void UplaodVideochat({
    String? chatvideo,
    required String reciverid,
    required String text,
    required String datatime,
  }) {
    emit(PostLoadingstate());
    print('looooooooooooooooooooooooad');
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(VideoChat!.path).pathSegments.last}')
        .putFile(VideoChat!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('linnnnnnnnnk video here');
        print(value);
        sendMessage(
            receiverId: reciverid,
            dateTime: datatime,
            text: text,
            video: value
        );
        print('donnnne post uplaoad');
        emit(PostSucessstate());
      }).catchError((error) {
        print(error.toString());
        emit(PostErrorstate());
      });
    }).catchError((onError) {});
  }
}
