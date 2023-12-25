import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/page/main/home_left_menu_page.dart';
import 'package:openvpn/presentations/page/main/server_page/server_page.dart';
import 'package:openvpn/presentations/page/main/settingpage.dart';
import 'package:openvpn/presentations/page/main/vpn_page.dart';
import 'package:openvpn/presentations/widget/impl/custombar.dart';
import 'package:openvpn/presentations/widget/index.dart';
import 'package:openvpn/resources/assets.gen.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/icondata.dart';
import 'package:openvpn/resources/strings.dart';
import 'package:openvpn/utils/config.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().startBilling();
    });

    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Image(
                  image: AssetImage('assets/images/Frame.png'),
                  height: 30,
                ),
              ],
            ),
            title: const AppTitleText(
              text: Config.appName,
              color: Colors.white,
            ),
            actions: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/crown.png'),
                        const Text(
                          'Go VIP',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              )
              // BlocBuilder<AppCubit, AppState>(
              //   builder: (context, state) {
              //     return Container(
              //       decoration: const BoxDecoration(
              //         boxShadow: <BoxShadow>[
              //           BoxShadow(
              //             color: Colors.white12,
              //             blurRadius: 10,
              //           ),
              //         ],
              //         borderRadius: BorderRadius.all(Radius.circular(100)),
              //       ),
              //       padding: const EdgeInsets.symmetric(horizontal: 16),
              //       child: CachedNetworkImage(
              //         imageUrl: state.currentServer?.flag ?? 'assets/images/Frame.png',
              //         height: 32,
              //       ),
              //     );
              //   },
              // )
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(195, 0, 0, 0),
                image: DecorationImage(
                  image: AssetImage('assets/images/Layer 1.png'),
                  fit: BoxFit.fill,
                )),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Expanded(
                  child:
                      TabBarView(controller: controller, children: const  [
                    Text(
                      'data',
                      style: TextStyle(
                          fontSize: 50, color: Colors.white),
                    ),
                    VpnPage(),
                    SettingPage(),
                  ]),
                ),
                CustomBar(
                  lenght: controller.length,
                  icon: [
                    Appicon.heart,
                    Appicon.flashcircle,
                    Icons.settings,
                  ],
                  onSelect: (index ) => controller.animateTo(index),
                )
              ],
            ),
          ),
        ));
  }
}
