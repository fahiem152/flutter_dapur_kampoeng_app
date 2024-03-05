part of 'summary_report_bloc.dart';

@freezed
class SummaryReportEvent with _$SummaryReportEvent {
  const factory SummaryReportEvent.started() = _Started;
  const factory SummaryReportEvent.getSummary({
    required String startDate,
    required String endDate,
  }) = _GetSummary;
}
