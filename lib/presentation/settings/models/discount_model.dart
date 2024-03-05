import '../../home/models/product_category.dart';

class DiscountModel {
  final int? id;
  final String name;
  // final String code;
  final int value;
  // final ProductCategory category;
  final String? description;

  DiscountModel({
    this.id,
    required this.name,
    required this.value,
    // required this.discount,
    // required this.category,
    required this.description,
  });
  factory DiscountModel.fromLocalMap(Map<String, dynamic> json) =>
      DiscountModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        value: json["value"],
      );
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "value": value,
    };
  }
}
