import 'package:dapur_kampoeng_app/core/components/buttons.dart';
import 'package:dapur_kampoeng_app/core/components/custom_text_field.dart';
import 'package:dapur_kampoeng_app/core/components/spaces.dart';
import 'package:dapur_kampoeng_app/data/datasource/auth_local_datasource.dart';
import 'package:dapur_kampoeng_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:dapur_kampoeng_app/presentation/home/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../core/assets/assets.gen.dart';
import '../../core/constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 124.0, vertical: 20.0),
      children: [
        const SpaceHeight(80.0),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130.0),
            child: SvgPicture.asset(
              Assets.icons.homeResto.path,
              width: 100,
              height: 100,
              color: AppColors.primary,
            )),
        const SpaceHeight(24.0),
        const Center(
          child: Text(
            'DAPUR KAMPOENG',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        const SpaceHeight(8.0),
        const Center(
          child: Text(
            'Akses Login Kasir',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        const SpaceHeight(40.0),
        CustomTextField(
          controller: emailController,
          label: 'Email',
        ),
        const SpaceHeight(12.0),
        CustomTextField(
          controller: passwordController,
          label: 'Password',
          obscureText: true,
        ),
        const SpaceHeight(24.0),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: (authResponseModel) {
                AuthLocalDataSource().saveAuthData(authResponseModel);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppColors.red,
                  ),
                );
              },
            );
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                            LoginEvent.login(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    label: 'Masuk',
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
        ),
      ],
    ));
  }
}
