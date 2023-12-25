import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/route/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AppCubit>().fetchServerList();
    return Scaffold(
      body: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          if (state.servers.isNotEmpty) {
            AutoRouter.of(context).replace(const MainRoute());
          }
        },
        child: const Center(),
      ),
    );
  }
}
