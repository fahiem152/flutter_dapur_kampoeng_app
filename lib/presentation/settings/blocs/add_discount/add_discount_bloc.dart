import 'package:dapur_kampoeng_app/data/datasource/discount_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_discount_event.dart';
part 'add_discount_state.dart';
part 'add_discount_bloc.freezed.dart';

class AddDiscountBloc extends Bloc<AddDiscountEvent, AddDiscountState> {
  final DiscountRemoteDatasource datasource;
  AddDiscountBloc(this.datasource) : super(const _Initial()) {
    on<_AddDiscount>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.addDiscount(
        event.name,
        event.description,
        event.value,
      );

      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
