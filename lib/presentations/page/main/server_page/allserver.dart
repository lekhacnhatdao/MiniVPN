import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/domain/model/vpn/vpn_server_model.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/route/app_router.gr.dart';

import 'package:openvpn/resources/icondata.dart';


class AllServer extends StatefulWidget {
  const AllServer({super.key});

  @override
  State<AllServer> createState() => _AllServerState();
}

class _AllServerState extends State<AllServer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Column(
        children: [
          const SizedBox(height: 24),
         
          
          const SizedBox(height: 24),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  itemBuilder: (context, index) {
                    final server = state.servers[index];
                    final isSelected = state.currentServer?.id == server.id;
                    final ispre = state.currentServer?.vip == server.vip;
                    return _buildItem(server, isSelected, state.isVip, ispre );
                  },
                  itemCount: state.servers.length)
              // ListView.separated(
              //   padding: const EdgeInsets.only(bottom: 16),
              //   itemBuilder: (context, index) {
              //     final server = state.servers[index];
              //     final isSelected = state.currentServer?.id == server.id;
              //     return _buildItem(server, isSelected, state.isVip);
              //   },
              //   itemCount: state.servers.length,
              //   separatorBuilder: (context, index) {
              //     return const SizedBox(height: 16);
              //   },
              // ),
              ),
        ],
      );
    });
  }

  Widget _buildItem(VpnServerModel server, bool isSelected, bool isVip , bool ispre) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: const Color(0xff131313), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 140,),
            padding: const EdgeInsets.fromLTRB(5, 5.3, 0, 5),
           decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft : Radius.circular(10), bottomRight: Radius.circular(10)
             ),color: Color(0xff5A189A),
           ),
            child:  Row(
              children: [
                Icon(Appicon.heart, color: Colors.white,)
              ],
            ),
          ),
          
          InkWell(
            onTap: isSelected
                ? null
                : () {
                    _handleItemTapped(server, isVip);
                  },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                    
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 39,
                    width: 39,
                    decoration: const BoxDecoration(
                     
                    ),
                    child: Image.network(server.flag),
                  ),
                 const SizedBox(height: 10,),
                  Text(
                   
                      
                         server.region.toString() +
                            '-' +
                            server.country.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                
                  const SizedBox(height: 44,),
                  Container(
                    margin: const EdgeInsets.only(right: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                                    
                      children: [ispre?
                        isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 25, 110, 238),
                              )
                            : const Icon(
                                Icons.radio_button_unchecked,
                                color: Color.fromARGB(255, 25, 110, 238),
                              ): Image.asset('assets/images/crown.png',height:24)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleItemTapped(VpnServerModel server, bool isVip) {
    if (server.vip && !isVip) {
      AutoRouter.of(context).push(const PremiumRoute());
    } else {
      context.read<AppCubit>().autoConnect(server);
    }
  }
}
