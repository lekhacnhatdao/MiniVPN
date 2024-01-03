
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/icondata.dart';
import 'package:openvpn/resources/ipdata.dart';
import 'package:openvpn/resources/theme.dart';

class CurrentPage extends StatefulWidget {
  const CurrentPage({super.key});

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
              backgroundColor: Colors.black,
          appBar: AppBar(
            leading: const BackButton(color: Colors.grey,),
            title: Text('${state.currentServer?.ip }', style: CustomTheme.textTheme.labelLarge?.copyWith(
              fontSize: 20
            ),),
            centerTitle: true, 
          ),
          body: Column(
 
            children: [
              Icon(Appicon.location, size: 250,color: AppColors.icon,),
              const SizedBox(height:100,),
              Current('My IP:', state.currentServer?.ip ?? '',
                  state.currentServer?.flag ?? '', false),
            
              Current('Nation:', state.currentServer?.country ?? '',
                  state.currentServer?.flag ?? '', true),
              Current('Area:', state.currentServer?.region ?? '',
                  state.currentServer?.flag ?? '', false),
              Current('City:', '${state.currentServer?.region}' + ' city' ,
                  state.currentServer?.flag ?? '', false),
            ],
          ),
        );
      },
    );
  }

  Widget Current(String text, String text2, String images, bool isflag) {
    return Column(
      children: [
        Row(
          children: [
            Text(text, style: CustomTheme.textTheme.labelLarge?.copyWith(
              color: AppColors.icon
            ),),
            const Spacer(),
            isflag ? Image.network(images, height: 30,) : const SizedBox(),
            const SizedBox(width: 5,),
            Text(text2, style: CustomTheme.textTheme.labelLarge?.copyWith(),)
          ],
        ),
        const Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
