// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dapur_kampoeng_app/core/components/dashed_line.dart';
import 'package:dapur_kampoeng_app/core/components/spaces.dart';
import 'package:dapur_kampoeng_app/core/constants/colors.dart';
import 'package:dapur_kampoeng_app/core/extensions/int_ext.dart';
import 'package:dapur_kampoeng_app/presentation/report/utils/revenue_invoice.dart';
import 'package:dapur_kampoeng_app/core/utils/helper_pdf_service.dart';
import 'package:dapur_kampoeng_app/core/utils/permission.dart';
import 'package:dapur_kampoeng_app/data/models/response/summary_response_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SummaryReportWidget extends StatelessWidget {
  final String title;
  final String searchDateFormatted;
  final SummaryModel summary;
  const SummaryReportWidget({
    Key? key,
    required this.title,
    required this.searchDateFormatted,
    required this.summary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceHeight(24.0),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 16.0),
              ),
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
                      final status = await checkPermission();
                      if (status.isGranted) {
                        final pdfFile = await RevenueInvoice.generate(
                            summary, searchDateFormatted);
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
            Text(
              'REVENUE : ${int.parse(summary.totalRevenue!).currencyFormatRp}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SpaceHeight(8.0),
            const DashedLine(),
            const DashedLine(),
            const SpaceHeight(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text(
                  int.parse(summary.totalSubtotal!).currencyFormatRp,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SpaceHeight(4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Discount'),
                Text(
                  "- ${int.parse(summary.totalDiscount!.replaceAll('.00', '')).currencyFormatRp}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SpaceHeight(4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tax'),
                Text(
                  "- ${int.parse(summary.totalTax!).currencyFormatRp}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SpaceHeight(4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Service Charge'),
                Text(
                  int.parse(summary.totalServiceCharge!).currencyFormatRp,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SpaceHeight(8.0),
            const DashedLine(),
            const DashedLine(),
            const SpaceHeight(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TOTAL'),
                Text(
                  summary.total!.currencyFormatRp,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
