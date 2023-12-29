import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';

import 'package:openvpn/presentations/page/main/server_page/server_page.dart';
import 'package:openvpn/presentations/widget/impl/app_thapgiac_text.dart';
import 'package:openvpn/presentations/widget/impl/custompre.dart';
import 'package:openvpn/presentations/widget/index.dart';

import 'package:openvpn/resources/icondata.dart';


class VpnPage extends StatelessWidget {
  const VpnPage({super.key});

  @override
  Widget build(BuildContext context)  {

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(
                    thickness: 1,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 71,
                  ),
                  Align(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const ServerPage();
                          }));
                        },
                        style: TextButton.styleFrom(
                            minimumSize: const Size(0, 61),
                            maximumSize: Size(
                                MediaQuery.of(context).size.width / 1.3, 61),
                            backgroundColor: const Color(0xff1A1919),
                            side: const BorderSide(
                                width: 1, color: Colors.transparent),
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: state.currentServer?.flag ??
                                  'assets/images/Group51.png',
                              height: 32,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              state.currentServer?.country ?? 'Fastest Server',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 39,
                  ),
                  LoadingButtons(
                    icondata: Appicon.power,
                    isLoading: state.isConnecting,
                    icon: Icon(Appicon.menu),
                    text: 'connecting',
                    onPressed: state.isConnecting
                        ? null
                        : () async {
                            await context.read<AppCubit>().toggle();
                          },
                    changeUI: state.titleStatus == 'Not connected',
                  ),
                  const SizedBox(
                    height: 46,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xff151515)),
                      margin: const EdgeInsets.symmetric(horizontal: 80),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.isConnecting
                              ? const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              : state.titleStatus == 'Not connected'
                                  ? const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.check,
                                      color: Color(0xff29BF12),
                                    ),
                          Text(
                            state.isConnecting
                                ? ' Not connected to VPN'
                                : state.titleStatus == 'Not connected'
                                    ? ' Not connected to VPN'
                                    : 'Connected to VPN',
                            style: TextStyle(
                                color: state.isConnecting
                                    ? Colors.red
                                    : state.titleStatus == 'Not connected'
                                        ? Colors.red
                                        : const Color(0xff29BF12)),
                          ),
                        ],
                      )),
                      const SizedBox(height: 19,),
                CustomPre()
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 10),
                  //   height: 377,
                  //   decoration: const BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //       color: Colors.black),
                  //   child: Column(
                  //     children: [
                  //       SizedBox(height: 10,),
                  //       const Text(
                  //         'VPN connection',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       const SizedBox(height: 30),
                  //       Expanded(
                  //           child: Padding(
                  //         padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                  //         child: GridView.builder(
                  //           gridDelegate:
                  //               const SliverGridDelegateWithMaxCrossAxisExtent(
                  //                   maxCrossAxisExtent: 30,
                  //                   mainAxisSpacing: 1,
                  //                   childAspectRatio: 1,
                  //                   crossAxisSpacing: 1),
                  //           itemBuilder: (context, index) =>
                  //               Center(child: BuildList(state.duration[index])),
                  //           itemCount: state.duration.length,
                  //         ),
                  //       )),
              
                  //       state.titleStatus == 'Not connected'
                  //           ? const Text(
                  //               "Your IP exposed to danger!",
                  //               style: TextStyle(color: Color(0xffD62828)),
                  //             )
                  //           : state.isConnecting
                  //               ? const Text(
                  //                   "Your IP exposed to danger!",
                  //                   style: TextStyle(color: Color(0xffD62828)),
                  //                 )
                  //               : const Text(
                  //                   'Your IP is hidden, you are now very secure!',
                  //                   style: TextStyle(color: Color(0xff119822)),
                  //                 ),
                  //                 SizedBox(height: 10,),
                  //       const Dash(
                  //           dashThickness: 2,
                  //           dashLength: 10,
                  //           dashGap: 6,
                  //           length: 320,
                  //           direction: Axis.horizontal,
                  //           dashColor: Color(0xff2F2F2F)),
                  //       const SizedBox(height: 10),
                  //       Row(
                  //         children: [
                  //           const SizedBox(width: 8),
                  //           const SizedBox(
                  //             width: 8,
                  //           ),
                  //           Expanded(
                            //  child: ClipRRect(
                            //     borderRadius:
                            //         const BorderRadius.all(Radius.circular(16)),
                            //     child: Column(
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 40),
                            //           child: AppLabelText(
                            //             icon: Appicon.upload,
                            //             text: Strings.download,
                            //             coloricon: const Color(0xff08A045),
                            //             size: 10,
                            //             color: AppColors.textSecondary,
                            //           ),
                            //         ),
                            //         const SizedBox(height: 8),
                            //         AppTitleText(
                            //             text: state.byteOut,
                            //             size: 28,
                            //             color: Colors.white)
                            //       ],
                            //     ),
                            //   ),
                            // ),
                  //           const Dash(
                  //               dashThickness: 2,
                  //               dashLength: 10,
                  //               length: 70,
                  //               dashGap: 6,
                  //               direction: Axis.vertical,
                  //               dashColor: Color(0xff2F2F2F)),
                  //           const SizedBox(width: 8),
                  //           Expanded(
                  //             child: ClipRRect(
                  //               borderRadius:
                  //                   const BorderRadius.all(Radius.circular(16)),
                  //               child: Container(
                  //                 child: Column(
                  //                   children: [
                  //                     // Padding(
                  //                     //   padding: const EdgeInsets.symmetric(
                  //                     //       horizontal: 40),
                  //                     //   child: AppLabelText(
                  //                     //     icon: Appicon.download,
                  //                     //     coloricon: const Color(0xffF6AA1C),
                  //                     //     text: Strings.upload,
                  //                     //     size: 10,
                  //                     //     color: AppColors.textSecondary,
                  //                     //   ),
                  //                     // ),
                  //                     const SizedBox(height: 8),
                  //                     AppTitleText(
                  //                       text: state.byteIn,
                  //                       size: 28,
                  //                       color: Colors.white,
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           const SizedBox(width: 8),
                  //         ],
                  //       ),
                  //       const Spacer(),
                  //       const Spacer(),
                  //       const SizedBox(height: 32),
                  //     ],
                  //   ),
                  // ),
                  ,
                  const SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget BuildList(String d) {
    bool flag = false;
    if (d == ':') {
      flag = true;
    }
    return Row(
      children: [
        CustomPaint(painter: MyPainter()),
        const SizedBox(),
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: flag ? Colors.transparent : Colors.black,
          ),
          child: Text(
            d,
            style: const TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
