import 'dart:developer';

import 'package:dapur_kampoeng_app/core/components/spaces.dart';
import 'package:dapur_kampoeng_app/core/constants/colors.dart';
import 'package:dapur_kampoeng_app/core/extensions/date_time_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/int_ext.dart';
import 'package:dapur_kampoeng_app/core/utils/helper_pdf_service.dart';
import 'package:dapur_kampoeng_app/core/utils/permission.dart';
import 'package:dapur_kampoeng_app/data/models/response/order_response_model.dart';
import 'package:dapur_kampoeng_app/presentation/report/utils/transaction_invoice.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:permission_handler/permission_handler.dart';

class TransactionReportWidget extends StatelessWidget {
  final String title;
  final String searchDateFormatted;
  final List<ItemOrder> transactionReport;
  final List<Widget>? headerWidgets;
  const TransactionReportWidget({
    super.key,
    required this.transactionReport,
    required this.title,
    required this.searchDateFormatted,
    required this.headerWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          const SpaceHeight(24.0),
          Center(
            child: Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 16.0),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  searchDateFormatted,
                  style: const TextStyle(fontSize: 16.0),
                ),
                GestureDetector(
                  onTap: () async {
                    final status = await PermessionHelper().checkPermission();
                    if (status.isGranted) {
                      final pdfFile = await TransactionSalesInvoice.generate(
                          transactionReport, searchDateFormatted);
                      log("pdfFile: $pdfFile");
                      HelperPdfService.openFile(pdfFile);
                    }
                  },
                  child: const Row(
                    children: [
                      Text(
                        "PDF",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Icon(
                        Icons.download_outlined,
                        color: AppColors.primary,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: 50,
                  rightHandSideColumnWidth: 1020,
                  isFixedHeader: true,
                  headerWidgets: headerWidgets,
                  // isFixedFooter: true,
                  // footerWidgets: _getTitleWidget(),
                  leftSideItemBuilder: (context, index) {
                    return Container(
                      width: 40,
                      height: 52,
                      alignment: Alignment.centerLeft,
                      child: Center(
                          child: Text(transactionReport[index].id.toString())),
                    );
                  },
                  rightSideItemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                              child: Text(
                            transactionReport[index].total!.currencyFormatRp,
                          )),
                        ),
                        Container(
                          width: 120,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                              child: Text(
                            transactionReport[index].subTotal!.currencyFormatRp,
                          )),
                        ),
                        Container(
                          width: 100,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                              child: Text(
                            transactionReport[index].tax!.currencyFormatRp,
                          )),
                        ),
                        Container(
                          width: 100,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                            child: Text(
                              int.parse(transactionReport[index]
                                      .discountAmount!
                                      .replaceAll('.00', ''))
                                  .currencyFormatRp,
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                            child: Text(
                              transactionReport[index]
                                  .serviceCharge!
                                  .currencyFormatRp,
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                            child: Text(
                                transactionReport[index].totalItem.toString()),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                            child: Text(transactionReport[index].namaKasir!),
                          ),
                        ),
                        Container(
                          width: 230,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                            child: Text(transactionReport[index]
                                .transactionTime!
                                .toFormattedDate()),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: transactionReport.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black38,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: AppColors.white,
                  rightHandSideColBackgroundColor: AppColors.white,

                  itemExtent: 55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
