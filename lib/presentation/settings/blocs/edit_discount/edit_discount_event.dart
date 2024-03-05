part of 'edit_discount_bloc.dart';

@freezed
class EditDiscountEvent with _$EditDiscountEvent {
  const factory EditDiscountEvent.started() = _Started;
  const factory EditDiscountEvent.editDiscount(
      String id, String name, String description, int value) = _EditDiscount;
}
