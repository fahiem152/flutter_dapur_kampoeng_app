import 'dart:convert';

class ProductSalesResponseModel {
  String? status;
  List<ProductSales>? data;

  ProductSalesResponseModel({
    this.status,
    this.data,
  });

  factory ProductSalesResponseModel.fromJson(String str) =>
      ProductSalesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductSalesResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductSalesResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ProductSales>.from(
                json["data"]!.map((x) => ProductSales.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ProductSales {
  int? productId;
  String? productName;
  String? totalQuantity;

  ProductSales({
    this.productId,
    this.productName,
    this.totalQuantity,
  });

  factory ProductSales.fromJson(String str) =>
      ProductSales.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductSales.fromMap(Map<String, dynamic> json) => ProductSales(
        productId: json["product_id"],
        productName: json["product_name"],
        totalQuantity: json["total_quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "product_name": productName,
        "total_quantity": totalQuantity,
      };
}
