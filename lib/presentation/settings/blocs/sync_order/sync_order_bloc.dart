// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dapur_kampoeng_app/data/datasource/order_remote_datasource.dart';
import 'package:dapur_kampoeng_app/data/datasource/cache_local_datasource.dart';

part 'sync_order_bloc.freezed.dart';
part 'sync_order_event.dart';
part 'sync_order_state.dart';

class SyncOrderBloc extends Bloc<SyncOrderEvent, SyncOrderState> {
  final OrderRemoteDatasource datasource;
  SyncOrderBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_SyncOrder>((event, emit) async {
      emit(const _Loading());
      final dataOrderNotSynced =
          await CacheLocalDatasource.instance.getOrderByIsNotSync();
      for (var order in dataOrderNotSynced) {
        final orderItem = await CacheLocalDatasource.instance
            .getOrderItemByOrderId(order.id!);
        final newOrder = order.copyWith(orderItems: orderItem);
        log("DISCOUNtAMOUNT SYNC ORDER: ${newOrder.discountAmount}");
        final result = await datasource.saveOrder(newOrder);
        if (result) {
          await CacheLocalDatasource.instance.updateOrderIsSync(order.id!);
        } else {
          emit(const _Error('Sync Order Failed'));
          return;
        }
      }
      emit(const _Loaded());
    });
  }
}
