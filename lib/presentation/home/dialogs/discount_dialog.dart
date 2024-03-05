import 'package:dapur_kampoeng_app/core/extensions/build_context_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/string_text.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/checkout/checkout_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/local_discount/local_discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/discount/discount_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({super.key});

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  @override
  void initState() {
    context
        .read<LocalDiscountBloc>()
        .add(const LocalDiscountEvent.getLocalDiscounts());
    // context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
    super.initState();
  }

  int discountIdSelected = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'DISKON',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.cancel,
                color: AppColors.primary,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      content: BlocBuilder<LocalDiscountBloc, LocalDiscountState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (discounts) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: discounts
                    .map(
                      (discount) => ListTile(
                        title: Text('Nama Diskon: ${discount.name}'),
                        subtitle: Text(
                            'Potongan harga (${discount.value.toString().replaceAll('.00', '').toIntegerFromText}%)'),
                        contentPadding: EdgeInsets.zero,
                        textColor: AppColors.primary,
                        trailing: Checkbox(
                          value: discount.id == discountIdSelected,
                          onChanged: (value) {
                            setState(() {
                              discountIdSelected = discount.id!;
                              context.read<CheckoutBloc>().add(
                                    CheckoutEvent.addDiscount(
                                      discount,
                                    ),
                                  );
                            });
                          },
                        ),
                        onTap: () {
                          // context.pop();
                        },
                      ),
                    )
                    .toList(),
              );
            },
          );
        },
      ),
      // content: BlocBuilder<DiscountBloc, DiscountState>(
      //   builder: (context, state) {
      //     return state.maybeWhen(
      //       orElse: () => const SizedBox.shrink(),
      //       loading: () => const Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //       loaded: (discounts) {
      //         return Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisSize: MainAxisSize.min,
      //           children: discounts
      //               .map(
      //                 (discount) => ListTile(
      //                   title: Text('Nama Diskon: ${discount.name}'),
      //                   subtitle: Text(
      //                       'Potongan harga (${discount.value!.replaceAll('.00', '').toIntegerFromText}%)'),
      //                   contentPadding: EdgeInsets.zero,
      //                   textColor: AppColors.primary,
      //                   trailing: Checkbox(
      //                     value: discount.id == discountIdSelected,
      //                     onChanged: (value) {
      //                       setState(() {
      //                         discountIdSelected = discount.id!;
      //                         context.read<CheckoutBloc>().add(
      //                               CheckoutEvent.addDiscount(
      //                                 discount,
      //                               ),
      //                             );
      //                       });
      //                     },
      //                   ),
      //                   onTap: () {
      //                     // context.pop();
      //                   },
      //                 ),
      //               )
      //               .toList(),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
