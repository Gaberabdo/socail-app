
class MessageModel {
  MessageModel({
     this.senderId,
     this.receiverId,
     this.message,
     this.time,
     this.image,
     this.video,
  });

  late final String? senderId;
  late final String? receiverId;
  late final String? message;
  late final String? time;
  late final String? image;
  late final String? video;

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'] ?? '';
    receiverId = json['receiverId'] ?? '';
    message = json['message'] ?? '';
    time = json['time'] ?? '';
    image = json['image'] ?? '';
    video = json['video'] ?? '';
  }
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message':message,
      'time':time,
      'image':image,
      'video':video,
    };
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'time': time,
      'image': image,
      'video': video,
    };
  }
}
