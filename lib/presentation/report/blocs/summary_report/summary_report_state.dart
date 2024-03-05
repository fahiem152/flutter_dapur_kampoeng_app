part of 'summary_report_bloc.dart';

@freezed
class SummaryReportState with _$SummaryReportState {
  const factory SummaryReportState.initial() = _Initial;
  const factory SummaryReportState.loading() = _Loading;
  const factory SummaryReportState.loaded(SummaryModel summary) = _Loaded;
  const factory SummaryReportState.error(String message) = _Error;
}
