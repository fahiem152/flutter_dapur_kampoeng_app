import 'package:dapur_kampoeng_app/core/constants/variables.dart';
import 'package:dapur_kampoeng_app/data/datasource/auth_local_datasource.dart';
import 'package:dapur_kampoeng_app/data/models/response/order_response_model.dart';
import 'package:dapur_kampoeng_app/data/models/response/summary_response_model.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/order_model.dart';
import 'package:dartz/dartz.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  Future<bool> saveOrder(OrderModel orderModel) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/save-order'),
        body: orderModel.toJson(),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      log("Response: ${response.statusCode}");
      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error: $e");
      return false;
    }
  }

  Future<Either<String, OrderResponseModel>> getOrderByRangeDate(
    String stratDate,
    String endDate,
  ) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final response = await http.get(
        Uri.parse(
            '${Variables.baseUrl}/api/orders?start_date=$stratDate&end_date=$endDate'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      log("Response: ${response.statusCode}");
      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        return Right(OrderResponseModel.fromJson(response.body));
      } else {
        return const Left("Failed Load Data");
      }
    } catch (e) {
      log("Error: $e");
      return Left("Failed: $e");
    }
  }

  Future<Either<String, SummaryResponseModel>> getSummaryByRangeDate(
    String stratDate,
    String endDate,
  ) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final response = await http.get(
        Uri.parse(
            '${Variables.baseUrl}/api/summary?start_date=$stratDate&end_date=$endDate'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      log("Response: ${response.statusCode}");
      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        return Right(SummaryResponseModel.fromJson(response.body));
      } else {
        return const Left("Failed Load Data");
      }
    } catch (e) {
      log("Error: $e");
      return Left("Failed: $e");
    }
  }
}
