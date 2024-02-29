import 'package:dapur_kampoeng_app/data/models/response/discount_response_model.dart';
import 'package:dapur_kampoeng_app/data/models/response/product_response_model.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/product_quantity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([], null, 11, 0)) {
    on<_AddItem>((event, emit) {
      var currentState = state as _Loaded;
      List<ProductQuantity> items = [...currentState.items];
      var index =
          items.indexWhere((element) => element.product.id == event.product.id);
      emit(const _Loading());
      if (index != -1) {
        items[index] = ProductQuantity(
            product: event.product, quantity: items[index].quantity + 1);
      } else {
        items.add(ProductQuantity(product: event.product, quantity: 1));
      }
      emit(_Loaded(items, currentState.discount, currentState.tax,
          currentState.serviceCharge));
    });

    on<_RemoveItem>((event, emit) {
      var currentState = state as _Loaded;
      List<ProductQuantity> items = [...currentState.items];
      var index =
          items.indexWhere((element) => element.product.id == event.product.id);
      emit(const _Loading());
      if (index != -1) {
        if (items[index].quantity > 1) {
          items[index] = ProductQuantity(
              product: event.product, quantity: items[index].quantity - 1);
        } else {
          items.removeAt(index);
        }
      }
      emit(_Loaded(items, currentState.discount, currentState.tax,
          currentState.serviceCharge));
    });
    on<_Started>((event, emit) {
      emit(const _Loaded([], null, 11, 0));
    });

    on<_AddDiscount>((event, emit) {
      var currentState = state as _Loaded;
      emit(_Loaded(currentState.items, event.discount, currentState.tax,
          currentState.serviceCharge));
    });
    on<_RemoveDiscount>((event, emit) {
      var currentState = state as _Loaded;
      emit(_Loaded(currentState.items, null, currentState.tax,
          currentState.serviceCharge));
    });
    on<_AddTax>((event, emit) {
      var currentState = state as _Loaded;
      emit(_Loaded(currentState.items, currentState.discount, event.tax,
          currentState.serviceCharge));
    });
    on<_AddServiceCharge>((event, emit) {
      var currentState = state as _Loaded;
      emit(_Loaded(currentState.items, currentState.discount, currentState.tax,
          currentState.serviceCharge));
    });
  }
}
