part of 'product_sales_bloc.dart';

@freezed
class ProductSalesState with _$ProductSalesState {
  const factory ProductSalesState.initial() = _Initial;
  const factory ProductSalesState.loading() = _Loading;
  const factory ProductSalesState.loaded(List<ProductSales> productSales) =
      _Loaded;
  const factory ProductSalesState.error(String message) = _Error;
}
