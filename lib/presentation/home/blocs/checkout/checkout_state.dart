part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loading() = _Loading;
  const factory CheckoutState.loaded(
    List<ProductQuantity> items,
    Discount? discount,
    int tax,
    int serviceCharge,
  ) = _Loaded;
  const factory CheckoutState.error() = _Error;
}
