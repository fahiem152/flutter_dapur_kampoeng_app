import 'dart:convert';

class SummaryResponseModel {
  String? status;
  SummaryModel? data;

  SummaryResponseModel({
    this.status,
    this.data,
  });

  factory SummaryResponseModel.fromJson(String str) =>
      SummaryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SummaryResponseModel.fromMap(Map<String, dynamic> json) =>
      SummaryResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : SummaryModel.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
      };
}

class SummaryModel {
  String? totalRevenue;
  String? totalDiscount;
  String? totalTax;
  String? totalSubtotal;
  String? totalServiceCharge;
  int? total;

  SummaryModel({
    this.totalRevenue,
    this.totalDiscount,
    this.totalTax,
    this.totalSubtotal,
    this.totalServiceCharge,
    this.total,
  });

  factory SummaryModel.fromJson(String str) =>
      SummaryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SummaryModel.fromMap(Map<String, dynamic> json) => SummaryModel(
        totalRevenue: json["total_revenue"],
        totalDiscount: json["total_discount"],
        totalTax: json["total_tax"],
        totalSubtotal: json["total_subtotal"],
        totalServiceCharge: json["total_service_charge"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "total_revenue": totalRevenue,
        "total_discount": totalDiscount,
        "total_tax": totalTax,
        "total_subtotal": totalSubtotal,
        "total_service_charge": totalServiceCharge,
        "total": total,
      };
}
