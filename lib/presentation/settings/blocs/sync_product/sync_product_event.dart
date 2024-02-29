part of 'sync_product_bloc.dart';

@freezed
class SyncProductEvent with _$SyncProductEvent {
  const factory SyncProductEvent.started() = _Started;
  const factory SyncProductEvent.syncProduct() = _SyncProduct;
}
