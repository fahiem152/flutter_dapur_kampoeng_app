part of 'add_discount_bloc.dart';

@freezed
class AddDiscountEvent with _$AddDiscountEvent {
  const factory AddDiscountEvent.started() = _Started;
  const factory AddDiscountEvent.addDiscount({
    required String name,
    required String description,
    required int value,
  }) = _AddDiscount;
}
