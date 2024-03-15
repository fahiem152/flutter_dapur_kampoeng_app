import 'dart:developer';

import 'package:dapur_kampoeng_app/core/assets/assets.gen.dart';
import 'package:dapur_kampoeng_app/core/constants/variables.dart';
import 'package:dapur_kampoeng_app/core/extensions/int_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/string_text.dart';
import 'package:dapur_kampoeng_app/data/models/response/product_response_model.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/checkout/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  final VoidCallback onCartButton;

  const ProductCard({
    super.key,
    required this.data,
    required this.onCartButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CheckoutBloc>().add(CheckoutEvent.addItem(data));
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.card),
            borderRadius: BorderRadius.circular(19),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.disabled.withOpacity(0.4),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    child: Image.network(
                      data.image!.contains('http')
                          ? data.image!
                          : '${Variables.baseUrl}/${data.image}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Spacer(),
                FittedBox(
                  child: Text(
                    data.name ?? '-',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SpaceHeight(8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          data.category?.name ?? '-',
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          data.price!.toIntegerFromText.currencyFormatRp,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox(),
                  loaded: (
                    products,
                    discount,
                    taxt,
                    serviceCharge,
                  ) {
                    return products.any((element) => element.product == data)
                        ? products
                                    .firstWhere(
                                        (element) => element.product == data)
                                    .quantity >
                                0
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.0)),
                                    color: AppColors.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      products
                                          .firstWhere((element) =>
                                              element.product == data)
                                          .quantity
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.0)),
                                    color: AppColors.primary,
                                  ),
                                  child: Assets.icons.shoppingBasket.svg(),
                                ),
                              )
                        : Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 36,
                              height: 36,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)),
                                color: AppColors.primary.withOpacity(0.8),
                              ),
                              child: Assets.icons.shoppingBasket.svg(),
                            ),
                          );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
