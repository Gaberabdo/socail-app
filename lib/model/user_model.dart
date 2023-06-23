import 'package:flutter/material.dart.';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified = false;
  String? image;
  String? cover;
  String? bio;

  UserModel(
      {this.name,
      this.email,
      this.phone,
      this.uId,
      this.isEmailVerified,
      this.image,
      this.cover,
      this.bio});

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'] ?? '.......example@gmail.com';
    name = json!['name'] ?? 'user';
    phone = json!['phone'] ?? '0102601400';
    uId = json!['uId'] ?? '';
    isEmailVerified = json!['isEmailVerified'];
    image = json!['image'] ?? 'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt3125544effd09308/639f60c65d0ea95c1ee0e6c3/GettyImages-1450106798.jpg?width=1920&height=1080';
    cover = json!['cover'] ?? 'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt3125544effd09308/639f60c65d0ea95c1ee0e6c3/GettyImages-1450106798.jpg?width=1920&height=1080';
    bio = json!['bio'] ??'Write Bio..';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'cover': cover,
      'bio': bio,
      'uId': uId,
    };
  }
}
