// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dapur_kampoeng_app/data/datasource/discount_remote_datasource.dart';

part 'edit_discount_bloc.freezed.dart';
part 'edit_discount_event.dart';
part 'edit_discount_state.dart';

class EditDiscountBloc extends Bloc<EditDiscountEvent, EditDiscountState> {
  final DiscountRemoteDatasource datasource;
  EditDiscountBloc(
    this.datasource,
  ) : super(_Initial()) {
    on<_EditDiscount>((event, emit) async {
      emit(_Loading());
      final result = await datasource.editDiscount(
          event.id, event.name, event.name, event.value);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Loaded()));
    });
  }
}
