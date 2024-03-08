import 'dart:developer';

import 'package:dapur_kampoeng_app/core/components/buttons.dart';
import 'package:dapur_kampoeng_app/core/components/spaces.dart';
import 'package:dapur_kampoeng_app/core/extensions/date_time_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/int_ext.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/order_model.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/product_quantity.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class DaySalesWidget extends StatelessWidget {
  // final String title;
  // final String searchDateFormatted;
  final List<OrderModel> orders;
  final List<Widget>? headerWidgets;
  const DaySalesWidget({
    super.key,
    required this.orders,
    // required this.title,
    // required this.searchDateFormatted,
    required this.headerWidgets,
  });

  // dialogProducts(BuildContext context, List<ProductQuantity> products) async {
  //   log("products: ${products.length}");
  //   await showDialog<void>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Products'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('List Products'),
  //               ...products.map(
  //                 (e) {
  //                   return Row(
  //                     children: [
  //                       Text(
  //                         e.product!.name!,
  //                         style: TextStyle(
  //                           fontSize: 14.0,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               ).toList()
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text("Ok"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SpaceHeight(16.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: HorizontalDataTable(
                leftHandSideColumnWidth: 40,
                rightHandSideColumnWidth: 1280,
                isFixedHeader: true,
                headerWidgets: headerWidgets,
                // isFixedFooter: true,
                // footerWidgets: _getTitleWidget(),
                leftSideItemBuilder: (context, index) {
                  return Container(
                    width: 40,
                    height: 52,
                    alignment: Alignment.centerLeft,
                    child: Center(child: Text(orders[index].id.toString())),
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
                          orders[index].paymentAmount!.currencyFormatRp,
                        )),
                      ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                            child: Text(
                          orders[index].subTotal!.currencyFormatRp,
                        )),
                      ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                            orders[index].tax!.currencyFormatRp,
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                            orders[index].discount.toString(),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                              orders[index].discountAmount.currencyFormatRp),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                              orders[index].serviceCharge.currencyFormatRp),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].total.currencyFormatRp),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].paymentMethod),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].totalItem.toString()),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].namaKasir!),
                        ),
                      ),
                      Container(
                        width: 230,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                            DateTime.parse(orders[index].transactionTime)
                                .toFormattedDate2(),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 120,
                      //   height: 52,
                      //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      //   alignment: Alignment.centerLeft,
                      //   child: Center(
                      //       child: ElevatedButton(
                      //           onPressed: () {
                      //             dialogProducts(
                      //                 context, orders[index].orderItems);
                      //           },
                      //           child: Text("Products"))),
                      // ),
                    ],
                  );
                },
                itemCount: orders.length,
                rowSeparatorWidget: const Divider(
                  color: Colors.black38,
                  height: 1.0,
                  thickness: 0.0,
                ),
                leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                itemExtent: 55,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
