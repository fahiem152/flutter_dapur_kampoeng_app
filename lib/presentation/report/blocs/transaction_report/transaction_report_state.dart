part of 'transaction_report_bloc.dart';

@freezed
class TransactionReportState with _$TransactionReportState {
  const factory TransactionReportState.initial() = _Initial;
  const factory TransactionReportState.loading() = _Loading;
  const factory TransactionReportState.error(String message) = _Error;
  const factory TransactionReportState.loaded(
      List<ItemOrder> transactionReport) = _Loaded;
}
