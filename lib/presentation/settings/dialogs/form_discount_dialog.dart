import 'package:dapur_kampoeng_app/core/components/custom_text_field.dart';
import 'package:dapur_kampoeng_app/core/constants/colors.dart';
import 'package:dapur_kampoeng_app/core/extensions/build_context_ext.dart';
import 'package:dapur_kampoeng_app/data/models/response/discount_response_model.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/add_discount/add_discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/delete_discount/delete_discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/discount/discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/edit_discount/edit_discount_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';

class FormDiscountDialog extends StatefulWidget {
  final Discount? data;
  const FormDiscountDialog({super.key, this.data});

  @override
  State<FormDiscountDialog> createState() => _FormDiscountDialogState();
}

class _FormDiscountDialogState extends State<FormDiscountDialog> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.data?.name ?? '';
    descriptionController.text = widget.data?.description ?? '';
    discountController.text = widget.data?.value?.replaceAll('.00', '') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close),
          ),
          const Text('Tambah Diskon'),
          const Spacer(),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: context.deviceWidth / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Nama Diskon',
                onChanged: (value) {},
              ),
              const SpaceHeight(24.0),
              CustomTextField(
                controller: descriptionController,
                label: 'Deskripsi (Opsional)',
                onChanged: (value) {},
              ),
              const SpaceHeight(24.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: CustomTextField(
                      controller: TextEditingController(text: 'Presentase'),
                      label: 'Nilai',
                      suffixIcon: const Icon(Icons.chevron_right),
                      onChanged: (value) {},
                      readOnly: true,
                    ),
                  ),
                  const SpaceWidth(14.0),
                  Flexible(
                    child: CustomTextField(
                      showLabel: false,
                      controller: discountController,
                      label: 'Percent',
                      prefixIcon: const Icon(Icons.percent),
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SpaceHeight(24.0),
              widget.data == null
                  ? BlocConsumer<AddDiscountBloc, AddDiscountState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          success: () {
                            context
                                .read<DiscountBloc>()
                                .add(const DiscountEvent.getDiscounts());
                            context.pop();
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<AddDiscountBloc>().add(
                                    AddDiscountEvent.addDiscount(
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      value: int.parse(discountController.text),
                                    ),
                                  );
                            },
                            label: 'Simpan Diskon',
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    )
                  : BlocConsumer<EditDiscountBloc, EditDiscountState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loaded: () {
                            context
                                .read<DiscountBloc>()
                                .add(const DiscountEvent.getDiscounts());
                            context.pop();
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<EditDiscountBloc>().add(
                                    EditDiscountEvent.editDiscount(
                                      widget.data!.id.toString(),
                                      nameController.text,
                                      descriptionController.text,
                                      int.parse(discountController.text),
                                    ),
                                  );
                            },
                            label: 'Simpan Diskon',
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    ),
              const SizedBox(
                height: 12.0,
              ),
              widget.data != null
                  ? BlocConsumer<DeleteDiscountBloc, DeleteDiscountState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loaded: () {
                            context
                                .read<DiscountBloc>()
                                .add(const DiscountEvent.getDiscounts());
                            context.pop();
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<DeleteDiscountBloc>().add(
                                    DeleteDiscountEvent.deleteDiscount(
                                      widget.data!.id.toString(),
                                    ),
                                  );
                            },
                            label: 'Hapus Diskon',
                            color: AppColors.red,
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
