part of 'delete_discount_bloc.dart';

@freezed
class DeleteDiscountState with _$DeleteDiscountState {
  const factory DeleteDiscountState.initial() = _Initial;
  const factory DeleteDiscountState.loading() = _Loading;
  const factory DeleteDiscountState.loaded() = _Loaded;
  const factory DeleteDiscountState.error(String message) = _Error;
}
