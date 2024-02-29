part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  const factory CheckoutEvent.addItem(Product product) = _AddItem;
  const factory CheckoutEvent.removeItem(Product product) = _RemoveItem;
  const factory CheckoutEvent.addDiscount(Discount discount) = _AddDiscount;
  const factory CheckoutEvent.removeDiscount() = _RemoveDiscount;
  const factory CheckoutEvent.addTax(int tax) = _AddTax;
  const factory CheckoutEvent.addServiceCharge(int serviceCharge) =
      _AddServiceCharge;
}
