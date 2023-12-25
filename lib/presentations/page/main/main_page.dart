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
import 'package:openvpn/resources/theme.dart';
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
   
    return SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title:  Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Image(
                  image: AssetImage('assets/images/Group51.png'),
                  height: 30,
                ),
                Text('Unlimited Connection' , style: CustomTheme.textTheme.labelLarge?.copyWith(),)
              ],
            ),
 
            actions: [
                   Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xff131313),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: InkWell(onTap: (){}, child: Icon(Appicon.menu, color: AppColors.icon,),),
      ),
      const SizedBox(width: 13,),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xff131313),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: InkWell(onTap: (){}, child: Icon(Appicon.menu, color: AppColors.icon,),),
      ),
      const SizedBox(width: 20,),
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
            child: 
                    VpnPage(),
                    
               
                // CustomBar(
                //   lenght: controller.length,
                //   icon: [
                //     Appicon.heart,
                //     Appicon.flashcircle,
                //     Icons.settings,
                //   ],
                //   onSelect: (index ) => controller.animateTo(index),
                // )
              
            ),
          ),
    );
  }
}
