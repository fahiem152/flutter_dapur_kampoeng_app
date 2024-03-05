import 'package:dapur_kampoeng_app/data/datasource/discount_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_discount_event.dart';
part 'delete_discount_state.dart';
part 'delete_discount_bloc.freezed.dart';

class DeleteDiscountBloc
    extends Bloc<DeleteDiscountEvent, DeleteDiscountState> {
  final DiscountRemoteDatasource datasource;
  DeleteDiscountBloc(this.datasource) : super(const _Initial()) {
    on<_DeleteDiscount>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.deleteDiscount(event.id);
      result.fold((l) => emit(_Error(l)), (r) => emit(const _Loaded()));
    });
  }
}
