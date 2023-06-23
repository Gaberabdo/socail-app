abstract class HomePageStates {}

class InitialHomePageStates extends HomePageStates {}

class ChangeBottomNavState extends HomePageStates {}


class GetUserLoadingHomePageStates extends HomePageStates {}

class GetUserSuccessHomePageStates extends HomePageStates {}

class GetUserErrorHomePageStates extends HomePageStates {
  final String error;
  GetUserErrorHomePageStates(this.error);
}

class GetAllUserLoadingHomePageStates extends HomePageStates {}

class GetAllUserSuccessHomePageStates extends HomePageStates {}

class GetAllUserErrorHomePageStates extends HomePageStates {}

class GetTeamLoadingHomePageStates extends HomePageStates {}

class GetTeamSuccessHomePageStates extends HomePageStates {}

class GetTeamErrorHomePageStates extends HomePageStates {
  final String error;
  GetTeamErrorHomePageStates(this.error);
}

class UpdateUserLoadingHomePageStates extends HomePageStates {}

class UpdateUserSuccessHomePageStates extends HomePageStates {}

class UpdateUserErrorHomePageStates extends HomePageStates {
  final String error;
  UpdateUserErrorHomePageStates(this.error);
}

class ProfileImageSuccessState extends HomePageStates {}

class ProfileImageErrorState extends HomePageStates {}

class ProfileImageCoverSuccessState extends HomePageStates {}

class ProfileImageCoverErrorState extends HomePageStates {}

class AppChangeBottomSheetState extends HomePageStates {}

class CreatePostLoadingHomePageStates extends HomePageStates {}

class CreatePostSuccessHomePageStates extends HomePageStates {}

class CreatePostErrorHomePageStates extends HomePageStates {
  final String error;
  CreatePostErrorHomePageStates(this.error);
}

class CreateStoryLoadingHomePageStates extends HomePageStates {}

class CreateStorySuccessHomePageStates extends HomePageStates {}

class CreateStoryErrorHomePageStates extends HomePageStates {
  final String error;
  CreateStoryErrorHomePageStates(this.error);
}
class GetPostsLoadingHomePageStates extends HomePageStates {}

class GetPostsSuccessHomePageStates extends HomePageStates {}

class GetPostsErrorHomePageStates extends HomePageStates {
  final String error;
  GetPostsErrorHomePageStates(this.error);
}
class GetStoryLoadingHomePageStates extends HomePageStates {}

class GetStorySuccessHomePageStates extends HomePageStates {}

class GetStoryErrorHomePageStates extends HomePageStates {
  final String error;
  GetStoryErrorHomePageStates(this.error);
}
class GetPostsLikeLoadingHomePageStates extends HomePageStates {}

class GetPostsLikeSuccessHomePageStates extends HomePageStates {}

class GetPostsLikeErrorHomePageStates extends HomePageStates {}

class GetPostsSavedLoadingHomePageStates extends HomePageStates {}

class GetPostsSavedSuccessHomePageStates extends HomePageStates {}

class GetPostsSavedErrorHomePageStates extends HomePageStates {}

class LikePostsSuccessHomePageStates extends HomePageStates {}

class LikePostsErrorHomePageStates extends HomePageStates {
  final String error;
  LikePostsErrorHomePageStates(this.error);
}

class SavedPostsSuccessHomePageStates extends HomePageStates {}
class SavedPostsErrorHomePageStates extends HomePageStates {}


class CommentPostsSuccessHomePageStates extends HomePageStates {}

class CommentPostsErrorHomePageStates extends HomePageStates {}

class SocialPostImagePickedSuccessState extends HomePageStates {}

class SocialStoryImagePickedSuccessState extends HomePageStates {}
class SocialStoryImagePickedErrorState extends HomePageStates {}

class SocialPostImagePickedErrorState extends HomePageStates {}

class SocialRemovePostImageState extends HomePageStates {}

class SocialErrorRemovePostState extends HomePageStates {}

class SocialSuccessRemovePostState extends HomePageStates {}

class SocialSendMessageSuccessState extends HomePageStates {}

class SocialSendMessageErrorState extends HomePageStates {}

class SocialGetMessagesSuccessState extends HomePageStates {}
class SocialGetMessagesLoadingState extends HomePageStates {}
class SocialGetMessagesErrorState extends HomePageStates {}


class SignOutState extends HomePageStates{}

class SearchSuccessState extends HomePageStates {}
class SearchLoadingState extends HomePageStates {}
class SearchErrorState extends HomePageStates {}

class GetVideoSuccessState extends HomePageStates {}
class GetVideoLoadingState extends HomePageStates {}
class GetVideoErrorState extends HomePageStates {}

class SuccessGetMessage extends HomePageStates {}



class CommentSuccessState extends HomePageStates {}
class CommentLoadingState extends HomePageStates {}
class CommentErrorState extends HomePageStates {}

class PostLoadingState extends HomePageStates{}
class PostSuccessState extends HomePageStates{}
class PostErrorState extends HomePageStates{}
class PostWithVideoSuccess extends HomePageStates{}


class VideoSuccess extends HomePageStates{}
class VideoError extends HomePageStates{}


//send Messages
class SuccessSendMessage extends HomePageStates{}
class ErrorSendMessage extends HomePageStates{}
//get Messages
class SucessGetMessage extends HomePageStates{}
class Errorgetmessage extends HomePageStates{}

class PostLoadingstate extends HomePageStates{}
class PostSucessstate extends HomePageStates{}
class PostErrorstate extends HomePageStates{}