part of 'local_discount_bloc.dart';

@freezed
class LocalDiscountState with _$LocalDiscountState {
  const factory LocalDiscountState.initial() = _Initial;
  const factory LocalDiscountState.loading() = _Loading;
  const factory LocalDiscountState.loaded(List<DiscountModel> data) = _Loaded;
  const factory LocalDiscountState.error(String message) = _Error;
}
