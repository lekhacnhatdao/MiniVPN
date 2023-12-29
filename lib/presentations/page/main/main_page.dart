
import 'package:auto_route/annotations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';

import 'package:openvpn/presentations/page/main/setting_page/settingpage.dart';
import 'package:openvpn/presentations/page/main/vpn_page.dart';

import 'package:openvpn/presentations/widget/impl/customdata.dart';

import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/icondata.dart';
import 'package:openvpn/resources/strings.dart';
import 'package:openvpn/resources/theme.dart';


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
        child: InkWell(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => SettingPage()));
        }, child: Icon(Appicon.menu, color: AppColors.icon,),),
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
                    const VpnPage(),
                    
               
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
          bottomNavigationBar: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return Container(
                color: Color(0xff131313),
                      height: MediaQuery.of(context).size.height/5.3,
                      child:  Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                
                                CustomData(icon: Appicon.download, color: Color(0xff00D589),text: Strings.download, data: state.byteOut,) ,
                               const SizedBox(width: 50,),
                                  CustomData(icon: Appicon.upload, color: Color(0xffE63946),text: Strings.upload, data: state.byteIn,) 
                              ],),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                child: const Align(
                                  child: Dash(
                                      dashColor: AppColors.icon,
                                      length: 270,
                                      dashLength: 7,
                                      dashGap: 5,
                                      dashThickness :2
                                  ),
                                ),
                              ),
                            
                              Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                   CustomData(icon: Appicon.ping, color: Color(0xffFF9914),text: 'IP Server', data: state.currentServer?.ip ?? '',) ,
                               const SizedBox(width: 50,),
                                  CustomData(icon: Appicon.times,color: Color(0xff008BF8), text: 'Time', data: state.duration,) 
                              ],)
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 18),
                            child: const Align(
                              child: Positioned(
                                
                                child: Dash(direction: Axis.vertical, dashColor: AppColors.icon,
                                length: 110,
                                 dashLength: 7,
                                      dashGap: 5,
                                      dashThickness :2),),
                            ),
                          )
                        ],
                        
                      ),
                    );
            },
          ),
          ),
    );
  }
}
