import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openvpn/presentations/widget/impl/app_body_text.dart';
import 'package:openvpn/presentations/widget/impl/app_buttons.dart';
import 'package:openvpn/presentations/widget/impl/app_label_text.dart';
import 'package:openvpn/resources/assets.gen.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/strings.dart';
import 'package:openvpn/resources/theme.dart';
import 'package:openvpn/utils/config.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> _launchURL(String link) async {
  final url = Uri.parse(link);
  await launchUrl(url, mode: LaunchMode.externalApplication);
}
class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return 
       Dialog(
         child: Container(
               
               decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), ),
       
             child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , topRight: Radius.circular(20)),
                    image: DecorationImage(image: AssetImage('assets/images/Group888.png',), fit: BoxFit.fill,)
                  ),
                  child: AppBar(leading: TextButton(onPressed: (){
                    Navigator.pop(context);
                  },child: const Icon(Icons.clear_rounded, color: Colors.white,), ),
                  
                  ),
                ),
              
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const AppBodyText(
                        text: 'How was your experience after using ${Config.appName} ?',
                        textAlign: TextAlign.center,
                        size: 20,
                        color: Colors.black,
                      ),
                      AppBodyText(
                        text: Platform.isIOS
                            ? 'Tap a star to rate on the App Store'
                            : 'Tap a star to rate on the Google Play',
                        textAlign: TextAlign.center,
                        size: 14,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _rating = i;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: i <= _rating
                                    ? Assets.icons.icStar2.svg(width: 35)
                                    : Assets.icons.icStar1.svg(width: 35),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                  GestureDetector(
                    onTap: (){
                          Navigator.of(context).pop();
                          debugPrint('User rated: $_rating stars');
                          if (_rating > 3) {
                            _launchURL(Config.storeAppUrl);
                            // StoreRedirect.redirect(
                            //   androidAppId: "com.Padoventi.JackpotVPN",
                            // );
                          }
                    },
                    child: Container(
                      width: double.infinity,
                     height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xffCBCBCB)),
                      child: Align(child: Text('Submit', style: CustomTheme.textTheme.labelLarge?.copyWith(),)),
                    ),
                  ),         const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ],),
           ),
       );
       
   
  }
}

