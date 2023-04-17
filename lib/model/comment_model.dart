class CommentModel {
  String? commentId;
  String? text;
  String? dataTime;
  String? videochat;
  String? name;
  String? image;
  String? uid;

  CommentModel(
      {this.text,
      this.dataTime,
      this.videochat,
      this.commentId,
      this.name,
      this.uid,
      this.image});
  CommentModel.fromJson(Map<dynamic, dynamic> json) {
    text = json['text'];
    commentId = json['commentId'];
    dataTime = json['dataTime'];
    videochat = json['videochat'];
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dataTime': dataTime,
      'videochat': videochat,
      'commentId': commentId,
      'name': name,
      'uid': uid,
      'image': image
    };
  }
}
