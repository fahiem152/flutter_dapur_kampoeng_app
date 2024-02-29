import 'package:dapur_kampoeng_app/core/extensions/string_text.dart';
import 'package:dapur_kampoeng_app/data/datasource/auth_local_datasource.dart';
import 'package:dapur_kampoeng_app/data/datasource/product_local_datasource.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/order_model.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/product_quantity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(_Initial()) {
    on<_Order>((event, emit) async {
      emit(_Loading());
      final subTotal = event.items.fold(
          0,
          (previousValue, element) =>
              previousValue +
              (element.product.price!.toIntegerFromText * element.quantity));
      final total = subTotal + event.tax + event.serviceCharge - event.discount;

      final totalItem = event.items.fold(
          0, (previousValue, element) => previousValue + element.quantity);
      final userData = await AuthLocalDataSource().getAuthData();
      final dataInput = OrderModel(
          subTotal: subTotal,
          paymentAmount: event.paymentAmount,
          tax: event.tax,
          discount: event.discount,
          serviceCharge: event.serviceCharge,
          total: total,
          paymentMethod: 'Cash',
          totalItem: totalItem,
          idKasir: userData.user!.id!,
          namaKasir: userData.user!.name!,
          transactionTime: DateTime.now().toIso8601String(),
          isSync: 0,
          orderItems: event.items);
      await ProductLocalDatasource.instance.saveOrder(dataInput);
      emit(_Loaded(
        dataInput,
      ));
    });
  }
}
