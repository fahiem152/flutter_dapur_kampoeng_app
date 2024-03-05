part of 'item_sales_report_bloc.dart';

@freezed
class ItemSalesReportEvent with _$ItemSalesReportEvent {
  const factory ItemSalesReportEvent.started() = _Started;
  const factory ItemSalesReportEvent.getItemSales({
    required String startDate,
    required String endDate,
  }) = _GetItemSales;
}
