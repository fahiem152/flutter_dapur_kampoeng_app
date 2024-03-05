part of 'item_sales_report_bloc.dart';

@freezed
class ItemSalesReportState with _$ItemSalesReportState {
  const factory ItemSalesReportState.initial() = _Initial;
  const factory ItemSalesReportState.loading() = _Loading;
  const factory ItemSalesReportState.loaded(List<ItemSales> itemSales) =
      _Loaded;
  const factory ItemSalesReportState.error(String message) = _Error;
}
