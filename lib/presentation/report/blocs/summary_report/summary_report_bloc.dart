// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dapur_kampoeng_app/data/models/response/summary_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dapur_kampoeng_app/data/datasource/order_remote_datasource.dart';

part 'summary_report_bloc.freezed.dart';
part 'summary_report_event.dart';
part 'summary_report_state.dart';

class SummaryReportBloc extends Bloc<SummaryReportEvent, SummaryReportState> {
  final OrderRemoteDatasource datasource;
  SummaryReportBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_GetSummary>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getSummaryByRangeDate(
          event.startDate, event.endDate);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r.data!)));
    });
  }
}
