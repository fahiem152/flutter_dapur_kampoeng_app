import 'dart:developer';

import 'package:dapur_kampoeng_app/core/constants/colors.dart';
import 'package:dapur_kampoeng_app/core/extensions/date_time_ext.dart';
import 'package:dapur_kampoeng_app/presentation/sales/blocs/day_sales/day_sales_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/sales/widgets/day_sales_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  void initState() {
    context.read<DaySalesBloc>().add(const DaySalesEvent.getDaySales());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dapur Kampoeng POS Day Sales',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                DateTime.now().toFormattedDate(),
                style: const TextStyle(
                  color: AppColors.subtitle,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Expanded(
            child: BlocBuilder<DaySalesBloc, DaySalesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (orders) {
                    log("message: ${orders.length}");
                    if (orders.isEmpty) {
                      return Center(
                        child: Text(
                          "Belum ada transaksi saat ini. Pastikan sistem siap menerima transaksi baru.",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return DaySalesWidget(
                        headerWidgets: _getTitleHeaderWidget(),
                        orders: orders,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getTitleHeaderWidget() {
    return [
      _getTitleItemWidget('ID', 40),
      _getTitleItemWidget('Payment Amount', 120),
      _getTitleItemWidget('Sub Total', 120),
      _getTitleItemWidget('Tax', 120),
      _getTitleItemWidget('Discount', 60),
      _getTitleItemWidget('Discount Amount', 120),
      _getTitleItemWidget('Service Charge', 120),
      _getTitleItemWidget('Total', 120),
      _getTitleItemWidget('Payment', 60),
      _getTitleItemWidget('Item', 60),
      _getTitleItemWidget('Cashier', 150),
      _getTitleItemWidget('Time', 230),
      _getTitleItemWidget('Action', 230),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      color: AppColors.primary,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
