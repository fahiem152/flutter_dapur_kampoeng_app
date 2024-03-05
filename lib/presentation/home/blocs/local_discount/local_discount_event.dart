part of 'local_discount_bloc.dart';

@freezed
class LocalDiscountEvent with _$LocalDiscountEvent {
  const factory LocalDiscountEvent.started() = _Started;
  const factory LocalDiscountEvent.getLocalDiscounts() = _GetLocalDiscounts;
}
