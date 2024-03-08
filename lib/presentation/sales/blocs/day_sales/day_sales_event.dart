part of 'day_sales_bloc.dart';

@freezed
class DaySalesEvent with _$DaySalesEvent {
  const factory DaySalesEvent.started() = _Started;
  const factory DaySalesEvent.getDaySales() = _GetDaySales;
}
