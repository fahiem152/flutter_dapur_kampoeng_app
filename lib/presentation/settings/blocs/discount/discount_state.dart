part of 'discount_bloc.dart';

@freezed
class DiscountState with _$DiscountState {
  const factory DiscountState.initial() = _Initial;
  const factory DiscountState.loading() = _Loading;
  const factory DiscountState.loaded(List<Discount> discounts) = _Loaded;
  const factory DiscountState.error(String message) = _Error;
}
