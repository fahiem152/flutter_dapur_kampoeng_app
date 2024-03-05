import 'package:dapur_kampoeng_app/data/datasource/cache_local_datasource.dart';
import 'package:dapur_kampoeng_app/presentation/settings/models/discount_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_discount_event.dart';
part 'local_discount_state.dart';
part 'local_discount_bloc.freezed.dart';

class LocalDiscountBloc extends Bloc<LocalDiscountEvent, LocalDiscountState> {
  final CacheLocalDatasource datasource;
  LocalDiscountBloc(this.datasource) : super(const _Initial()) {
    on<_GetLocalDiscounts>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getDiscounts();

      emit(_Loaded(result));
    });
  }
}
