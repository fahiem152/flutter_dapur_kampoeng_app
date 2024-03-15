import 'package:dapur_kampoeng_app/core/components/spaces.dart';
import 'package:dapur_kampoeng_app/core/extensions/build_context_ext.dart';
import 'package:dapur_kampoeng_app/data/datasource/cache_local_datasource.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/sync_order/sync_order_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/sync_product/sync_product_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/widgets/settings_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dapur_kampoeng_app/core/components/buttons.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({super.key});

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SettingsTitle('Sync Data'),
          const SpaceHeight(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocConsumer<SyncProductBloc, SyncProductState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loaded: (productResponseModel) {
                      CacheLocalDatasource.instance.deleteAllProducts();
                      CacheLocalDatasource.instance.insertProducts(
                        productResponseModel.data!,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sync Product Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        width: context.deviceWidth / 4,
                        onPressed: () {
                          context
                              .read<SyncProductBloc>()
                              .add(const SyncProductEvent.syncProduct());
                        },
                        label: 'Sync Product',
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
              BlocConsumer<SyncOrderBloc, SyncOrderState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loaded: () {
                      CacheLocalDatasource.instance.deleteAllOrders();
                      CacheLocalDatasource.instance.deleteAllOrderItems();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sync Order Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        width: context.deviceWidth / 4,
                        onPressed: () {
                          context
                              .read<SyncOrderBloc>()
                              .add(const SyncOrderEvent.syncOrder());
                        },
                        label: 'Sync Order',
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
