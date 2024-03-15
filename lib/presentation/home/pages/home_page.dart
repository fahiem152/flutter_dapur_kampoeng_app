import 'dart:developer';

import 'package:dapur_kampoeng_app/core/extensions/build_context_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/int_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/string_text.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/checkout/checkout_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/local_product/local_product_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/dialogs/discount_dialog.dart';
import 'package:dapur_kampoeng_app/presentation/home/dialogs/service_dialog.dart';
import 'package:dapur_kampoeng_app/presentation/home/dialogs/tax_dialog.dart';
import 'package:dapur_kampoeng_app/presentation/home/pages/confirm_payment_page.dart';
import 'package:dapur_kampoeng_app/presentation/home/widgets/order_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

import '../widgets/column_button.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/home_title.dart';

import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    // searchResults = products;
    context
        .read<LocalProductBloc>()
        .add(const LocalProductEvent.getLocalProduct());
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    // if (index == 0) {
    //   searchResults = products;
    // } else {
    //   searchResults = products
    //       .where((e) => e.category.index.toString().contains(index.toString()))
    //       .toList();
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // if (products.isEmpty) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    return Hero(
      tag: 'confirmation_screen',
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HomeTitle(
                          controller: searchController,
                          onChanged: (value) {
                            searchController.text = value;
                            // // searchResults = products
                            // //     .where((e) => e.name
                            // //         .toLowerCase()
                            // //         .contains(value.toLowerCase()))
                            // //     .toList();
                            log("searchController: $value");
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTabBar(
                          tabTitles: const [
                            'Semua',
                            'Minuman',
                            'Makanan',
                          ],
                          initialTabIndex: 0,
                          tabViews: [
                            // if (searchResults.isEmpty)
                            //   const Padding(
                            //     padding: EdgeInsets.only(top: 80.0),
                            //     child: _IsEmpty(),
                            //   )
                            // else
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(orElse: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loading: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loaded: (products) {
                                    if (products.isEmpty) {
                                      return const Center(
                                        child: Text('No Items'),
                                      );
                                    }
                                    return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: searchController.text == ''
                                            ? products.length
                                            : products
                                                .where((element) => element
                                                    .name!
                                                    .toLowerCase()
                                                    .contains(
                                                        searchController.text))
                                                .toList()
                                                .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) {
                                          return ProductCard(
                                            data: searchController.text == ''
                                                ? products[index]
                                                : products
                                                    .where((element) => element
                                                        .name!
                                                        .toLowerCase()
                                                        .contains(
                                                            searchController
                                                                .text))
                                                    .toList()[index],
                                            onCartButton: () {},
                                          );
                                        });
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(orElse: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loading: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loaded: (products) {
                                    if (products.isEmpty) {
                                      return const Center(
                                        child: Text('No Items'),
                                      );
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products
                                          .where((element) =>
                                              element.category!.id! == 2)
                                          .toList()
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.85,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                        data: products
                                            .where((element) =>
                                                element.category!.id! == 2)
                                            .toList()[index],
                                        onCartButton: () {},
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(orElse: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loading: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loaded: (products) {
                                    if (products.isEmpty) {
                                      return const Center(
                                        child: Text('No Items'),
                                      );
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products
                                          .where((element) =>
                                              element.category!.id! == 1)
                                          .toList()
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.85,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                        data: products
                                            .where((element) =>
                                                element.category!.id! == 1)
                                            .toList()[index],
                                        onCartButton: () {},
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(orElse: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loading: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loaded: (products) {
                                    if (products.isEmpty) {
                                      return const Center(
                                        child: Text('No Items'),
                                      );
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products
                                          .where((element) =>
                                              element.category!.id! == 3)
                                          .toList()
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.85,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                        data: products
                                            .where((element) =>
                                                element.category!.id! == 3)
                                            .toList()[index],
                                        onCartButton: () {},
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                            // if (searchResults
                            //     .where((element) => element.category.isDrink)
                            //     .toList()
                            //     .isEmpty)
                            //   const Padding(
                            //     padding: EdgeInsets.only(top: 80.0),
                            //     child: _IsEmpty(),
                            //   )
                            // else
                            //   SizedBox(
                            //     child: GridView.builder(
                            //       shrinkWrap: true,
                            //       itemCount: searchResults
                            //           .where(
                            //               (element) => element.category.isDrink)
                            //           .toList()
                            //           .length,
                            //       physics: const NeverScrollableScrollPhysics(),
                            //       gridDelegate:
                            //           const SliverGridDelegateWithFixedCrossAxisCount(
                            //         childAspectRatio: 0.85,
                            //         crossAxisCount: 3,
                            //         crossAxisSpacing: 30.0,
                            //         mainAxisSpacing: 30.0,
                            //       ),
                            //       itemBuilder: (context, index) => ProductCard(
                            //         data: searchResults
                            //             .where((element) =>
                            //                 element.category.isDrink)
                            //             .toList()[index],
                            //         onCartButton: () {},
                            //       ),
                            //     ),
                            //   ),
                            // if (searchResults
                            //     .where((element) => element.category.isSnack)
                            //     .toList()
                            //     .isEmpty)
                            //   const Padding(
                            //     padding: EdgeInsets.only(top: 80.0),
                            //     child: _IsEmpty(),
                            //   )
                            // else
                            //   SizedBox(
                            //     child: GridView.builder(
                            //       shrinkWrap: true,
                            //       itemCount: searchResults
                            //           .where(
                            //               (element) => element.category.isSnack)
                            //           .toList()
                            //           .length,
                            //       physics: const NeverScrollableScrollPhysics(),
                            //       gridDelegate:
                            //           const SliverGridDelegateWithFixedCrossAxisCount(
                            //         childAspectRatio: 0.85,
                            //         crossAxisCount: 3,
                            //         crossAxisSpacing: 30.0,
                            //         mainAxisSpacing: 30.0,
                            //       ),
                            //       itemBuilder: (context, index) => ProductCard(
                            //         data: searchResults
                            //             .where((element) =>
                            //                 element.category.isSnack)
                            //             .toList()[index],
                            //         onCartButton: () {},
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
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
                            'Orders #',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            children: [
                              Button.filled(
                                width: 120.0,
                                height: 40,
                                onPressed: () {},
                                label: 'Dine In',
                              ),
                              const SpaceWidth(8.0),
                              Button.outlined(
                                width: 100.0,
                                height: 40,
                                onPressed: () {},
                                label: 'To Go',
                              ),
                            ],
                          ),
                          const SpaceHeight(16.0),
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
                                width: 130,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        OrderMenu(data: products[index]),
                                    separatorBuilder: (context, index) =>
                                        const SpaceHeight(1.0),
                                    itemCount: products.length,
                                  );
                                },
                              );
                            },
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColumnButton(
                                label: 'Diskon',
                                svgGenImage: Assets.icons.diskon,
                                onPressed: () => showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const DiscountDialog(),
                                ),
                              ),
                              ColumnButton(
                                label: 'Pajak',
                                svgGenImage: Assets.icons.pajak,
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => const TaxDialog(),
                                ),
                              ),
                              ColumnButton(
                                label: 'Layanan',
                                svgGenImage: Assets.icons.layanan,
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => const ServiceDialog(),
                                ),
                              ),
                            ],
                          ),
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
                                      loaded: (products, discount, tax,
                                          serviceCharge) {
                                        if (products.isEmpty) {
                                          return 0;
                                        }
                                        return tax;
                                      });
                                  return Text(
                                    '$tax %',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
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
                                  return Text(
                                    '$discount %',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
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
                                      ) {
                                        if (products.isEmpty) {
                                          return 0;
                                        }
                                        return products
                                            .map((e) =>
                                                e.product.price!
                                                    .toIntegerFromText *
                                                e.quantity)
                                            .reduce((value, element) =>
                                                value + element);
                                      });

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
                          child: Button.filled(
                            onPressed: () {
                              context.push(const ConfirmPaymentPage());
                            },
                            label: 'Lanjutkan Pembayaran',
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
    );
  }
}

class _IsEmpty extends StatelessWidget {
  const _IsEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.noProduct.svg(),
          const SizedBox(height: 80.0),
          const Text(
            'Belum Ada Produk',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
