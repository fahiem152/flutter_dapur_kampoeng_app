import 'package:dapur_kampoeng_app/core/constants/colors.dart';
import 'package:dapur_kampoeng_app/data/datasource/auth_local_datasource.dart';
import 'package:dapur_kampoeng_app/data/datasource/auth_remote_datasource.dart';
import 'package:dapur_kampoeng_app/data/datasource/discount_remote_datasource.dart';
import 'package:dapur_kampoeng_app/data/datasource/order_item_remote_datasource.dart';
import 'package:dapur_kampoeng_app/data/datasource/order_remote_datasource.dart';
import 'package:dapur_kampoeng_app/data/datasource/cache_local_datasource.dart';
import 'package:dapur_kampoeng_app/data/datasource/product_remote_datasource.dart';
import 'package:dapur_kampoeng_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/auth/login_page.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/checkout/checkout_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/local_discount/local_discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/local_product/local_product_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/blocs/order/order_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/pages/dashboard_page.dart';
import 'package:dapur_kampoeng_app/presentation/report/blocs/item_sales_report/item_sales_report_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/report/blocs/summary_report/summary_report_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/report/blocs/transaction_report/transaction_report_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/add_discount/add_discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/delete_discount/delete_discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/discount/discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/edit_discount/edit_discount_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/sync_order/sync_order_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/settings/blocs/sync_product/sync_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LocalProductBloc(CacheLocalDatasource.instance),
        ),
        BlocProvider(
          create: (context) => LocalDiscountBloc(CacheLocalDatasource.instance),
        ),
        BlocProvider(
          create: (context) => SyncProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => SyncOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddDiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => EditDiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DeleteDiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => TransactionReportBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ItemSalesReportBloc(OrderItemRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SummaryReportBloc(OrderRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
            future: AuthLocalDataSource().isAuthDataExists(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return const DashboardPage();
                } else {
                  return const LoginPage();
                }
              }
              return const Scaffold(
                body: Center(
                  child: Text('Error'),
                ),
              );
            }),
      ),
    );
  }
}
