import 'dart:developer';
import 'package:dapur_kampoeng_app/core/constants/variables.dart';
import 'package:dapur_kampoeng_app/data/datasource/auth_local_datasource.dart';
import 'package:dapur_kampoeng_app/data/models/response/item_sales_model.dart';
import 'package:http/http.dart' as http;
import 'package:dapur_kampoeng_app/data/models/response/order_response_model.dart';
import 'package:dartz/dartz.dart';

class OrderItemRemoteDatasource {
  Future<Either<String, ItemSalesResponseModel>> getItemSalesByRangeDate(
    String stratDate,
    String endDate,
  ) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final response = await http.get(
        Uri.parse(
            '${Variables.baseUrl}/api/order-item?start_date=$stratDate&end_date=$endDate'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      log("Response: ${response.statusCode}");
      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        return Right(ItemSalesResponseModel.fromJson(response.body));
      } else {
        return const Left("Failed Load Data");
      }
    } catch (e) {
      log("Error: $e");
      return Left("Failed: $e");
    }
  }
}
