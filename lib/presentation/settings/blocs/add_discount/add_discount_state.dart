part of 'add_discount_bloc.dart';

@freezed
class AddDiscountState with _$AddDiscountState {
  const factory AddDiscountState.initial() = _Initial;
  const factory AddDiscountState.loading() = _Loading;
  const factory AddDiscountState.error(String message) = _Error;
  const factory AddDiscountState.success() = _Success;
}
