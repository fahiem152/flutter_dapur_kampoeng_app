import 'dart:convert';

class OrderResponseModel {
  String? status;
  List<ItemOrder>? data;

  OrderResponseModel({
    this.status,
    this.data,
  });

  factory OrderResponseModel.fromJson(String str) =>
      OrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ItemOrder>.from(
                json["data"]!.map((x) => ItemOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ItemOrder {
  int? id;
  int? paymentAmount;
  int? subTotal;
  int? tax;
  int? discount;
  String? discountAmount;
  int? serviceCharge;
  int? total;
  String? paymentMethod;
  int? totalItem;
  int? idKasir;
  String? namaKasir;
  DateTime? transactionTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  ItemOrder({
    this.id,
    this.paymentAmount,
    this.subTotal,
    this.tax,
    this.discount,
    this.discountAmount,
    this.serviceCharge,
    this.total,
    this.paymentMethod,
    this.totalItem,
    this.idKasir,
    this.namaKasir,
    this.transactionTime,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemOrder.fromJson(String str) => ItemOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemOrder.fromMap(Map<String, dynamic> json) => ItemOrder(
        id: json["id"],
        paymentAmount: json["payment_amount"],
        subTotal: json["sub_total"],
        tax: json["tax"],
        discount: json["discount"],
        discountAmount: json["discount_amount"],
        serviceCharge: json["service_charge"],
        total: json["total"],
        paymentMethod: json["payment_method"]!,
        totalItem: json["total_item"],
        idKasir: json["id_kasir"],
        namaKasir: json["nama_kasir"],
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "payment_amount": paymentAmount,
        "sub_total": subTotal,
        "tax": tax,
        "discount": discount,
        "discount_amount": discountAmount,
        "service_charge": serviceCharge,
        "total": total,
        "payment_method": paymentMethod,
        "total_item": totalItem,
        "id_kasir": idKasir,
        "nama_kasir": namaKasir,
        "transaction_time": transactionTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
