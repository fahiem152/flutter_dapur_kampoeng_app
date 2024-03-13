import 'dart:developer';

import 'package:dapur_kampoeng_app/core/components/buttons.dart';
import 'package:dapur_kampoeng_app/core/components/spaces.dart';
import 'package:dapur_kampoeng_app/core/constants/colors.dart';
import 'package:dapur_kampoeng_app/core/extensions/build_context_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/int_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/string_text.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/checkout/checkout_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/order/order_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/product_quantity.dart';
import 'package:dapur_kampoeng_app/presentation/home/widgets/order_menu.dart';
import 'package:dapur_kampoeng_app/presentation/home/widgets/success_payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPaymentPage extends StatefulWidget {
  const ConfirmPaymentPage({super.key});

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  final totalPriceController = TextEditingController(text: '');
  String priceExcat = '0';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: 'confirmation_screen',
        child: Scaffold(
          body: Row(
            children: [
              // LEFT CONTENT
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Konfirmasi',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Orders #1',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                height: 60.0,
                                width: 60.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(24.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 160,
                            ),
                            SizedBox(
                              width: 50.0,
                              child: Text(
                                'Qty',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(8),
                        const Divider(),
                        const SpaceHeight(8),
                        BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const Center(
                                child: Text('No Items'),
                              ),
                              loaded: (
                                products,
                                discounts,
                                tax,
                                serviceCharge,
                              ) {
                                if (products.isEmpty) {
                                  return const Center(
                                    child: Text('No Items'),
                                  );
                                }
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      OrderMenu(data: products[index]),
                                  separatorBuilder: (context, index) =>
                                      const SpaceHeight(16.0),
                                  itemCount: products.length,
                                );
                              },
                            );
                          },
                        ),
                        const SpaceHeight(16.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     ColumnButton(
                        //       label: 'Diskon',
                        //       svgGenImage: Assets.icons.diskon,
                        //       onPressed: () => showDialog(
                        //         context: context,
                        //         builder: (context) => const DiscountDialog(),
                        //       ),
                        //     ),
                        //     ColumnButton(
                        //       label: 'Pajak',
                        //       svgGenImage: Assets.icons.pajak,
                        //       onPressed: () => showDialog(
                        //         context: context,
                        //         builder: (context) => const TaxDialog(),
                        //       ),
                        //     ),
                        //     ColumnButton(
                        //       label: 'Layanan',
                        //       svgGenImage: Assets.icons.layanan,
                        //       onPressed: () => showDialog(
                        //         context: context,
                        //         builder: (context) => const ServiceDialog(),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(8.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pajak',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final tax = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products, discount, tax, service) =>
                                      tax,
                                );
                                final price = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (
                                    products,
                                    discounts,
                                    tax,
                                    serviceCharge,
                                  ) =>
                                      products.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.product.price!
                                                .toIntegerFromText *
                                            element.quantity),
                                  ),
                                );

                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products, discount, tax,
                                        serviceCharge) {
                                      if (discount == null) {
                                        return 0;
                                      }
                                      return discount.value!
                                          .toString()
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal = price -
                                    (discount / 100 * price) -
                                    (5 / 100 * price);

                                final finalTax = subTotal * 0.11;
                                return Text(
                                  '0.11 % (${finalTax.toInt().currencyFormatRp})',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Diskon',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products, discount, tax,
                                        serviceCharge) {
                                      if (discount == null) {
                                        return 0;
                                      }
                                      return discount.value!
                                          .toString()
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (
                                      products,
                                      discounts,
                                      tax,
                                      serviceCharge,
                                    ) =>
                                        products.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element.product.price!
                                                      .toIntegerFromText *
                                                  element.quantity),
                                        ));

                                final finalDiscount = discount / 100 * subTotal;
                                return Text(
                                  finalDiscount.toInt().currencyFormatRp,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Service',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final service = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products, discount, tax,
                                        serviceCharge) {
                                      if (serviceCharge == null) {
                                        return 0;
                                      }
                                      return serviceCharge
                                          .toString()
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (
                                      products,
                                      discounts,
                                      tax,
                                      serviceCharge,
                                    ) =>
                                        products.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element.product.price!
                                                      .toIntegerFromText *
                                                  element.quantity),
                                        ));

                                final finalService = 5 / 100 * subTotal;
                                return Text(
                                  finalService.toInt().currencyFormatRp,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sub total',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final price = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (
                                      products,
                                      discounts,
                                      tax,
                                      serviceCharge,
                                    ) =>
                                        products.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element.product.price!
                                                      .toIntegerFromText *
                                                  element.quantity),
                                        ));
                                return Text(
                                  price.currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final price = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (
                                    products,
                                    discounts,
                                    tax,
                                    serviceCharge,
                                  ) =>
                                      products.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.product.price!
                                                .toIntegerFromText *
                                            element.quantity),
                                  ),
                                );

                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products, discount, tax,
                                        serviceCharge) {
                                      if (discount == null) {
                                        return 0;
                                      }
                                      return discount.value!
                                          .toString()
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal = price -
                                    (discount / 100 * price) -
                                    (5 / 100 * price);
                                final tax = subTotal * 0.11;
                                final total = subTotal + tax;

                                totalPriceController.text =
                                    total.ceil().currencyFormatRp;
                                priceExcat = total.ceil().toString();

                                return Text(
                                  total.ceil().currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // RIGHT CONTENT
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pembayaran',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              '1 opsi pembayaran tersedia',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SpaceHeight(8.0),
                            const Divider(),
                            const SpaceHeight(8.0),
                            const Text(
                              'Metode Bayar',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SpaceHeight(12.0),
                            Row(
                              children: [
                                Button.filled(
                                  width: 120.0,
                                  height: 50.0,
                                  onPressed: () {},
                                  label: 'Cash',
                                ),
                                const SpaceWidth(8.0),
                                Button.outlined(
                                  width: 120.0,
                                  height: 50.0,
                                  onPressed: () {},
                                  label: 'QRIS',
                                  disabled: true,
                                ),
                              ],
                            ),
                            const SpaceHeight(8.0),
                            const Divider(),
                            const SpaceHeight(8.0),
                            const Text(
                              'Total Bayar',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SpaceHeight(12.0),
                            TextFormField(
                              controller: totalPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                hintText: 'Total harga',
                              ),
                            ),
                            const SpaceHeight(45.0),
                            Wrap(
                              spacing: 20.0, // Jarak horizontal antara widget
                              runSpacing:
                                  10.0, // Jarak vertikal antara baris widget
                              children: [
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        int.parse(priceExcat).currencyFormatRp;
                                  },
                                  label: 'UANG PAS',
                                ),
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        10000.currencyFormatRp;
                                  },
                                  label: 'Rp 10.000',
                                ),
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        20000.currencyFormatRp;
                                  },
                                  label: 'Rp 20.000',
                                ),
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        50000.currencyFormatRp;
                                  },
                                  label: 'Rp 50.000',
                                ),
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        75000.currencyFormatRp;
                                  },
                                  label: 'Rp 75.000',
                                ),
                                ...List.generate(
                                  10,
                                  (index) {
                                    final nominal = (index + 1) * 100000;
                                    return Button.filled(
                                      width: 150.0,
                                      onPressed: () {
                                        totalPriceController.text =
                                            nominal.currencyFormatRp;
                                        print(
                                            'Tombol dengan nominal Rp ${nominal.currencyFormatRp} ditekan');
                                      },
                                      label: nominal.currencyFormatRp,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SpaceHeight(100.0),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ColoredBox(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 16.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Button.outlined(
                                    onPressed: () => context.pop(),
                                    label: 'Batalkan',
                                  ),
                                ),
                                const SpaceWidth(8.0),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    final discount = state.maybeWhen(
                                        orElse: () => 0,
                                        loaded: (
                                          products,
                                          discount,
                                          tax,
                                          serviceCharge,
                                        ) {
                                          if (discount == null) {
                                            return 0;
                                          }
                                          return discount.value!
                                              .toString()
                                              .replaceAll('.00', '')
                                              .toIntegerFromText;
                                        });

                                    final price = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (
                                        products,
                                        discount,
                                        tax,
                                        serviceCharge,
                                      ) =>
                                          products.fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue +
                                            (element.product.price!
                                                    .toIntegerFromText *
                                                element.quantity),
                                      ),
                                    );
                                    final finalDiscount =
                                        discount / 100 * price;
                                    final finalService = 5 / 100 * price;
                                    final subTotal = price -
                                        (discount / 100 * price) -
                                        (5 / 100 * price);

                                    final finalTax = subTotal * 0.11;

                                    List<ProductQuantity> items =
                                        state.maybeWhen(
                                      orElse: () => [],
                                      loaded: (
                                        products,
                                        discount,
                                        tax,
                                        serviceCharge,
                                      ) =>
                                          products,
                                    );

                                    log("DISCOUNT FINAL: $finalDiscount");
                                    return Flexible(
                                      child: Button.filled(
                                        onPressed: () async {
                                          context
                                              .read<OrderBloc>()
                                              .add(OrderEvent.order(
                                                items,
                                                discount,
                                                finalDiscount.toInt(),
                                                finalTax.toInt(),
                                                finalService.toInt(),
                                                totalPriceController
                                                    .text.toIntegerFromText,
                                              ));
                                          await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) =>
                                                const SuccessPaymentDialog(),
                                          );
                                        },
                                        label: 'Bayar',
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
