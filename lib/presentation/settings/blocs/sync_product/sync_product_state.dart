part of 'sync_product_bloc.dart';

@freezed
class SyncProductState with _$SyncProductState {
  const factory SyncProductState.initial() = _Initial;
  const factory SyncProductState.loading() = _Loading;
  const factory SyncProductState.loaded(
      ProductResponseModel productResponseModel) = _Loaded;
  const factory SyncProductState.error(String message) = _Error;
}
