import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:openvpn/local/app_db.dart';
import 'package:openvpn/resources/ipdata.dart';

import '/di/components/app_component.dart' as di;
import 'core/cubit/cubit_observer.dart';

import 'di/components/app_component.dart';
import 'presentations/bloc/app_cubit.dart';
import 'presentations/root.dart';

Future<void> main() async {
   try {
    /// Initialize Ip Address
    var ipAddress = IpAddress(type: RequestType.json);

    /// Get the IpAddress based on requestType.
    dynamic data = await ipAddress.getIp();
    Ip.ip = data.toString();
    print(data.toString());
    print(Ip.ip);
  } on IpAddressException catch (exception) {
    /// Handle the exception.
    print(exception.message);
  }
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MainCubitObserver();

  //Di
  await di.configureDependencies();

  //Hive
  await AppDatabase().initialize();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider<AppCubit>(create: (_) => getIt())],
      child: RootPage(),
    ),
  );
}
