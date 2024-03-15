import 'dart:developer';

import 'package:dapur_kampoeng_app/core/constants/variables.dart';
import 'package:dapur_kampoeng_app/data/datasource/auth_local_datasource.dart';
import 'package:dapur_kampoeng_app/data/models/response/discount_response_model.dart';
import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

class DiscountRemoteDatasource {
  Future<Either<String, DiscountResponseModel>> getDiscounts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return Right(DiscountResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get discounts');
    }
  }

  Future<Either<String, bool>> addDiscount(
    String name,
    String description,
    int value,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    }, body: {
      'name': name,
      'description': description,
      'value': value.toString(),
      'type': 'percentage',
    });
    log("Response Code; ${response.statusCode}");
    log("Response body; ${response.body}");
    if (response.statusCode == 201) {
      return const Right(true);
    } else {
      return const Left('Failed to add discount');
    }
  }

  Future<Either<String, bool>> editDiscount(
    String id,
    String name,
    String description,
    int value,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts/$id');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.put(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    }, body: {
      'name': name,
      'description': description,
      'value': value.toString(),
      'type': 'percentage',
    });

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to add discount');
    }
  }

  Future<Either<String, bool>> deleteDiscount(
    String id,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts/$id');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to add discount');
    }
  }
}
