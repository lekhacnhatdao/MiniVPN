import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/domain/model/vpn/vpn_server_model.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/route/app_router.gr.dart';
import 'package:openvpn/presentations/widget/impl/app_body_text.dart';
import 'package:openvpn/presentations/widget/impl/app_label_text.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/strings.dart';

class AllServer extends StatefulWidget {
  const AllServer({super.key});

  @override
  State<AllServer> createState() => _AllServerState();
}

class _AllServerState extends State<AllServer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder:  (context, state) {
          return     Column(
              children: [
                const SizedBox(height: 24),
                const AppLabelText(text: Strings.visualLocation),
                const AppBodyText(
                  text: Strings.visualLocationDes,
                  color: AppColors.textSecondary,
                  size: 10,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      final server = state.servers[index];
                      final isSelected = state.currentServer?.id == server.id;
                      return _buildItem(server, isSelected, state.isVip);
                    },
                    itemCount: state.servers.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                ),
              ],
            );
    }
    );}
     Widget _buildItem(VpnServerModel server, bool isSelected, bool isVip) {
   

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: isSelected
            ? null
            : () {
                _handleItemTapped(server, isVip);
          
                
              },
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
             
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                   server.flag),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                server.country == 'Hong Kong'
                    ? server.country.toString()
                    : server.region.toString() +
                        '-' +
                        server.country.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const Spacer(),
              if (isSelected)
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return AppLabelText(
                    
                      color: state.colorStatus,
                      size: 10,
                    );
                  },
                ),
              const SizedBox(width: 16),
              isSelected
                  ? const Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 25, 110, 238),
                    )
                  : const Icon(
                      Icons.radio_button_unchecked,
                      color: Color.fromARGB(255, 25, 110, 238),
                    )
            ],
          ),
        ),
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
  

 
  
