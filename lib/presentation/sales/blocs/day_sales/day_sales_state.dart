part of 'day_sales_bloc.dart';

@freezed
class DaySalesState with _$DaySalesState {
  const factory DaySalesState.initial() = _Initial;
  const factory DaySalesState.loading() = _Loading;
  const factory DaySalesState.loaded(List<OrderModel> orders) = _Loaded;
}
