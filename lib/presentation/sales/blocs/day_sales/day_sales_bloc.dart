import 'package:dapur_kampoeng_app/data/datasource/cache_local_datasource.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_sales_event.dart';
part 'day_sales_state.dart';
part 'day_sales_bloc.freezed.dart';

class DaySalesBloc extends Bloc<DaySalesEvent, DaySalesState> {
  final CacheLocalDatasource datasource;
  DaySalesBloc(this.datasource) : super(const _Initial()) {
    on<_GetDaySales>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getAllOrder();
      emit(_Loaded(result));
    });
  }
}
