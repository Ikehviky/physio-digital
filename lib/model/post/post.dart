import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "image")
  List<String> images;

  @JsonKey(name: "category")
  List<String> category;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.category,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      images: (json['image'] as List<dynamic>).map((e) => e.toString()).toList(),
      category: (json['category'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'image': images,
    'category': category,
  };
}