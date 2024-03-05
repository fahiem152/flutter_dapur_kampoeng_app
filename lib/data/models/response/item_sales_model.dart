import 'dart:convert';

class ItemSalesResponseModel {
  String? status;
  List<ItemSales>? data;

  ItemSalesResponseModel({
    this.status,
    this.data,
  });

  factory ItemSalesResponseModel.fromJson(String str) =>
      ItemSalesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemSalesResponseModel.fromMap(Map<String, dynamic> json) =>
      ItemSalesResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ItemSales>.from(
                json["data"]!.map((x) => ItemSales.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ItemSales {
  int? id;
  int? orderId;
  int? productId;
  int? quantity;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? productName;

  ItemSales({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.productName,
  });

  factory ItemSales.fromJson(String str) => ItemSales.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemSales.fromMap(Map<String, dynamic> json) => ItemSales(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productName: json["product_name"]!,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_name": productName,
      };
}
