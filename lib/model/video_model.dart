class VideoModel {
  String? object;
  String? uId;
  String? dateTime;
  String? image;
  String? name;
  String? id;

  VideoModel({
    this.object,
    this.uId,
    this.dateTime,
    this.name,
    this.image,
    this.id,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    name = json['name'];
    image = json['image'];
    id = json['id'];

  }

  Map<String, dynamic> toMap() {
    return {
      'object': object,
      'uId': uId,
      'dateTime':dateTime,
      'image':image,
      'name':name,
      'id':id,

    };
  }
}
