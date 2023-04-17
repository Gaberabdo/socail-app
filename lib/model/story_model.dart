class StoryModel {
  String? object;
  String? text;
  String? uId;
  String? dateTime;
  String? image;
  String? name;
  String? id;

  StoryModel({
    this.object,
    this.text,
    this.uId,
    this.dateTime,
    this.name,
    this.image,
    this.id,
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    text = json['text'];
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
      'text': text,
      'dateTime':dateTime,
      'image':image,
      'name':name,
      'id':id,

    };
  }
}
