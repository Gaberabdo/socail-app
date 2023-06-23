import 'package:flutter/material.dart.';
class SearchModel {
  String? name;
  String? phone;
  String? image;

  SearchModel({
    this.name,
    this.phone,
    this.image,
  });

  SearchModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'] ?? '';
    phone = json!['phone'] ?? '';

    image = json!['image'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'image': image,
    };
  }
}
