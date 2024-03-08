import 'package:dapur_kampoeng_app/core/constants/colors.dart';
import 'package:dapur_kampoeng_app/core/extensions/build_context_ext.dart';
import 'package:dapur_kampoeng_app/data/datasource/auth_local_datasource.dart';
import 'package:dapur_kampoeng_app/presentation/auth/login_page.dart';
import 'package:dapur_kampoeng_app/presentation/home/pages/home_page.dart';
import 'package:dapur_kampoeng_app/presentation/home/widgets/nav_item.dart';
import 'package:dapur_kampoeng_app/presentation/report/pages/report_page.dart';
import 'package:dapur_kampoeng_app/presentation/sales/pages/sales_page.dart';
import 'package:dapur_kampoeng_app/presentation/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../auth/bloc/logout/logout_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SalesPage(),
    const ReportPage(),
    // const Center(child: Text('This is page 4')),
    const SettingsPage(),
    // const ManagePrinterPage(),
    // const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SingleChildScrollView(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(16.0)),
                child: SizedBox(
                  height: context.deviceHeight - 20.0,
                  child: ColoredBox(
                    color: AppColors.primary,
                    child: Column(
                      children: [
                        NavItem(
                          iconPath: Assets.icons.homeResto.path,
                          isActive: _selectedIndex == 0,
                          onTap: () => _onItemTapped(0),
                        ),
                        NavItem(
                          iconPath: Assets.icons.discount.path,
                          isActive: _selectedIndex == 1,
                          onTap: () => _onItemTapped(1),
                        ),
                        NavItem(
                          iconPath: Assets.icons.dashboard.path,
                          isActive: _selectedIndex == 2,
                          onTap: () => _onItemTapped(2),
                        ),
                        NavItem(
                          iconPath: Assets.icons.setting.path,
                          isActive: _selectedIndex == 3,
                          onTap: () => _onItemTapped(3),
                        ),
                        BlocListener<LogoutBloc, LogoutState>(
                          listener: (context, state) {
                            state.maybeMap(
                              orElse: () {},
                              error: (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.message),
                                    backgroundColor: AppColors.red,
                                  ),
                                );
                              },
                              success: (value) {
                                AuthLocalDataSource().removeAuthData();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Logout success'),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }));
                              },
                            );
                          },
                          child: NavItem(
                            iconPath: Assets.icons.logout.path,
                            isActive: false,
                            onTap: () {
                              context
                                  .read<LogoutBloc>()
                                  .add(const LogoutEvent.logout());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
