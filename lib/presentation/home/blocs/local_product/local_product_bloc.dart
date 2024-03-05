// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dapur_kampoeng_app/data/datasource/cache_local_datasource.dart';
import 'package:dapur_kampoeng_app/data/models/response/product_response_model.dart';

part 'local_product_bloc.freezed.dart';
part 'local_product_event.dart';
part 'local_product_state.dart';

class LocalProductBloc extends Bloc<LocalProductEvent, LocalProductState> {
  final CacheLocalDatasource datasource;
  LocalProductBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_GetLocalProduct>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getProducts();

      emit(_Loaded(result));
    });
  }
}
