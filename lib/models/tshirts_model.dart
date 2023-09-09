import 'dart:convert';

List<TshirtsModel> tshirtsFromJson(String str) => List<TshirtsModel>.from(
    json.decode(str).map((x) => TshirtsModel.fromJson(x)));

class TshirtsModel {
  final String? id;
  final String? title;
  final String? details;
  final String image;
  final String? category;
  final List<dynamic>? sizes;
  final String? price;

  TshirtsModel({
    required this.id,
    required this.title,
    required this.details,
    required this.image,
    required this.category,
    required this.sizes,
    required this.price,
  });

  factory TshirtsModel.fromJson(Map<String, dynamic> json) => TshirtsModel(
        id: json["id"],
        title: json["title"],
        details: json["details"],
        image: json["image"],
        category: json["category"],
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        price: json["price"],
      );
}
