
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';

import 'package:openvpn/presentations/page/main/server_page/allserver.dart';


class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Container(
        color: Colors.black,
        child: SafeArea(
          child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: Colors.black),
              child: Scaffold(
                  backgroundColor:  Colors.black,
                  appBar: AppBar(
                    leading: const BackButton(
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Virtual server',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                  body: 
                    AllServer(),

                    // Row(
                    //     children: [
                    //       CachedNetworkImage(
                    //         imageUrl: flag ? 'https://cdn.tgdd.vn/Files/2016/12/09/923744/khongxacdinh_213x379.jpg' : server.flag,
                    //         width: 35,
                    //       ),
                    //       const SizedBox(width: 16),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               AppLabelText(
                    //                 text: server.country ?? '',
                    //               ),
                    //               const SizedBox(width: 8),
                    //               if (server.vip)
                    //                 const Icon(Icons.star, color: AppColors.colorYellow)
                    //             ],
                    //           ),
                    //           AppBodyText(
                    //             text: server.region ?? '',
                    //             size: 12,
                    //           )
                    //         ],
                    //       ),
                    //       const Spacer(),
                  )),
        ),
      );
    });
  }
}
